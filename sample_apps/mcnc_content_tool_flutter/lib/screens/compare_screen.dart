import 'dart:math';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive_io.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CompareStatus { same, modify, newFile, delete }

class CompareResult {
  final String path;
  final CompareStatus status;
  final int size;
  
  CompareResult({
    required this.path,
    required this.status,
    required this.size,
  });
}

class CompareScreen extends StatefulWidget {
  final String? initialRemoteZipPath;
  
  const CompareScreen({super.key, this.initialRemoteZipPath});

  @override
  State<CompareScreen> createState() => CompareScreenState();
}

class CompareScreenState extends State<CompareScreen> {
  String? remoteZipPath;
  String? localZipPath;
  
  bool isComparing = false;
  List<CompareResult>? results;
  
  CompareStatus? _filterStatus;
  String _searchQuery = '';
  CompareResult? _selectedFile;
  
  Map<String, dynamic>? _previewData;
  bool _isLoadingPreview = false;

  @override
  void initState() {
    super.initState();
    remoteZipPath = widget.initialRemoteZipPath;
  }

  @override
  void didUpdateWidget(CompareScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRemoteZipPath != oldWidget.initialRemoteZipPath && widget.initialRemoteZipPath != null) {
      setState(() {
        remoteZipPath = widget.initialRemoteZipPath;
        results = null; // reset results if remote changes
      });
    }
  }

  Future<void> pickRemoteArchive() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        remoteZipPath = result.files.single.path;
        results = null;
      });
    }
  }

  Future<void> pickLocalArchive() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        localZipPath = result.files.single.path;
        results = null;
      });
    }
  }

  Future<void> runCompare() async {
    if (remoteZipPath == null || localZipPath == null) return;
    
    setState(() {
      isComparing = true;
      results = null;
      _selectedFile = null;
      _previewData = null;
    });

    try {
      final results = await compute(_compareZips, {
        'remote': remoteZipPath!,
        'local': localZipPath!,
      });
      
      if (mounted) {
        setState(() {
          this.results = results;
          isComparing = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isComparing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error comparing zips: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  void _selectFile(CompareResult file) async {
    setState(() {
      _selectedFile = file;
      _isLoadingPreview = true;
      _previewData = null;
    });
    
    try {
      // For preview, we'll try to read from local zip, or remote if it's 'delete' (doesn't exist in local)
      final zipPath = file.status == CompareStatus.delete ? remoteZipPath : localZipPath;
      if (zipPath != null) {
        final data = await compute(_readZipFileContent, {
          'zip': zipPath,
          'file': file.path,
        });
        if (mounted && _selectedFile == file) {
          setState(() {
            _previewData = data;
            _isLoadingPreview = false;
          });
        }
      }
    } catch (e) {
      if (mounted && _selectedFile == file) {
        setState(() {
          _previewData = {'type': 'error', 'message': 'Cannot preview file. It may be binary or too large.'};
          _isLoadingPreview = false;
        });
      }
    }
  }

  Future<void> _exportZip(List<CompareStatus> statuses, String defaultFileName) async {
    if (localZipPath == null || results == null) return;

    final savePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Export Archive',
      fileName: defaultFileName,
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    if (savePath == null) return;

    // Show loading
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exporting to $defaultFileName...'), duration: const Duration(days: 1)),
      );
    }

    final targetPaths = results!
        .where((r) => statuses.contains(r.status))
        .map((r) => r.path)
        .toList();

    try {
      await compute(_createExportZip, {
        'sourceZip': localZipPath!,
        'savePath': savePath,
        'targetPaths': targetPaths,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Export complete!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  int get _sameCount => results?.where((r) => r.status == CompareStatus.same).length ?? 0;
  int get _modifyCount => results?.where((r) => r.status == CompareStatus.modify).length ?? 0;
  int get _newCount => results?.where((r) => r.status == CompareStatus.newFile).length ?? 0;
  int get _deleteCount => results?.where((r) => r.status == CompareStatus.delete).length ?? 0;
  int get _totalCount => results?.length ?? 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Paths Section
                Row(
                  children: [
                    Expanded(
                      child: _buildPathCard('Remote Archive', remoteZipPath),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildPathCard('Local Archive', localZipPath),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                if (isComparing)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(48.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  
                if (results != null) ...[
                  // Dashboard
                  _buildDashboard(),
                  const SizedBox(height: 24),
                  
                  // Unified List & Preview
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // List
                      Expanded(
                        flex: 4,
                        child: _buildFileList(),
                      ),
                      const SizedBox(width: 24),
                      // Preview
                      Expanded(
                        flex: 6,
                        child: _buildFilePreview(),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPathCard(String title, String? path) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? const Color(0xFF333333) : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? const Color(0xFFB493E6) : const Color(0xFF9370DB),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2D2D30) : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: isDark ? const Color(0xFF3E3E42) : const Color(0xFFE5E7EB)),
            ),
            child: Text(
              path ?? 'No file selected.',
              style: TextStyle(
                fontSize: 13,
                color: path == null ? (isDark ? Colors.grey.shade600 : Colors.grey.shade500) : (isDark ? Colors.grey.shade300 : Colors.grey.shade800),
                fontFamily: 'Courier',
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDashboard() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? const Color(0xFF333333) : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Proper Donut Chart
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: DonutChartPainter(
                      same: _sameCount,
                      modify: _modifyCount,
                      newFile: _newCount,
                      delete: _deleteCount,
                      baseColor: isDark ? const Color(0xFF333333) : Colors.grey.shade300,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    '$_totalCount',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLegendItem('Same', _sameCount, Colors.grey),
              _buildLegendItem('Modify', _modifyCount, Colors.blue),
              _buildLegendItem('New', _newCount, Colors.green),
              _buildLegendItem('Delete', _deleteCount, Colors.red),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('EXPORT OPTIONS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildExportBtn('Download All', Icons.download, () {
                    if (localZipPath != null) {
                      FilePicker.platform.saveFile(
                        dialogTitle: 'Export Archive',
                        fileName: 'all.zip',
                        type: FileType.custom,
                        allowedExtensions: ['zip'],
                      ).then((savePath) {
                        if (savePath != null) {
                          File(localZipPath!).copy(savePath);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Export complete!'), backgroundColor: Colors.green),
                          );
                        }
                      });
                    }
                  }),
                  const SizedBox(width: 12),
                  _buildExportBtn('Download Modify + New', Icons.download, () {
                    _exportZip([CompareStatus.modify, CompareStatus.newFile], 'modify_new.zip');
                  }, color: const Color(0xFF9370DB)),
                  const SizedBox(width: 12),
                  _buildExportBtn('Download Same', Icons.download, () {
                    _exportZip([CompareStatus.same], 'same.zip');
                  }),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(String label, int count, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color ?? (isDark ? Colors.white70 : Colors.black87), borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 8),
          Text('$label ($count)', style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
  
  Widget _buildExportBtn(String label, IconData icon, VoidCallback onTap, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          border: Border.all(color: isDark ? const Color(0xFF444444) : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: color ?? (isDark ? Colors.white70 : Colors.black87)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, color: color ?? (isDark ? Colors.white70 : Colors.black87))),
          ],
        ),
      ),
    );
  }

  Widget _buildFileList() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filtered = results!.where((r) {
      if (_filterStatus != null && r.status != _filterStatus) return false;
      if (_searchQuery.isNotEmpty && !r.path.toLowerCase().contains(_searchQuery.toLowerCase())) return false;
      return true;
    }).toList();
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? const Color(0xFF333333) : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Unified File List ($_totalCount)',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildFilterBtn('All', null),
                _buildFilterBtn('New', CompareStatus.newFile, color: Colors.green),
                _buildFilterBtn('Modify', CompareStatus.modify, color: Colors.blue),
                _buildFilterBtn('Delete', CompareStatus.delete, color: Colors.red),
                _buildFilterBtn('Same', CompareStatus.same, color: isDark ? Colors.grey.shade400 : Colors.grey.shade700),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PPInput(
              placeholder: 'Search files...',
              iconLeft: const Icon(Icons.search, size: 18),
              size: PPInputSize.sm,
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final file = filtered[i];
              final isSelected = _selectedFile == file;
              return InkWell(
                onTap: () => _selectFile(file),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: isSelected ? (isDark ? const Color(0xFF333333) : const Color(0xFFF3F4F6)) : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
                  child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          file.path,
                          style: const TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatStatus(file.status),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: _statusColor(file.status),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterBtn(String label, CompareStatus? status, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _filterStatus == status;
    return GestureDetector(
      onTap: () => setState(() => _filterStatus = status),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? (color ?? (isDark ? Colors.white70 : Colors.grey.shade800)).withOpacity(isDark ? 0.2 : 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: color ?? (isDark ? Colors.white70 : Colors.black87) ?? Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 600,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? const Color(0xFF333333) : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: isDark ? const Color(0xFF333333) : Colors.grey.shade200)),
            ),
            child: Text(
              'Select a file to preview',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? const Color(0xFFB493E6) : const Color(0xFF9370DB)),
            ),
          ),
          Expanded(
            child: _isLoadingPreview
                ? const Center(child: CircularProgressIndicator())
                : _previewData != null
                    ? SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: _buildPreviewContent(),
                      )
                    : const Center(
                        child: Text('No preview available', style: TextStyle(color: Colors.grey)),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewContent() {
    final type = _previewData!['type'];
    if (type == 'error') {
      return Text(_previewData!['message'], style: const TextStyle(color: Colors.red));
    } else if (type == 'image') {
      return Image.memory(_previewData!['bytes']);
    } else if (type == 'svg') {
      return SvgPicture.memory(_previewData!['bytes']);
    } else {
      String language = 'plaintext';
      if (_selectedFile != null) {
        if (_selectedFile!.path.endsWith('.json')) language = 'json';
        else if (_selectedFile!.path.endsWith('.js')) language = 'javascript';
        else if (_selectedFile!.path.endsWith('.css')) language = 'css';
        else if (_selectedFile!.path.endsWith('.html')) language = 'xml';
      }

      final isDark = Theme.of(context).brightness == Brightness.dark;

      return HighlightView(
        _previewData!['content'],
        language: language,
        theme: isDark ? darculaTheme : githubTheme,
        padding: const EdgeInsets.all(8),
        textStyle: const TextStyle(fontFamily: 'Courier', fontSize: 13),
      );
    }
  }

  String _formatStatus(CompareStatus status) {
    switch (status) {
      case CompareStatus.same: return 'SAME';
      case CompareStatus.modify: return 'MODIFIED';
      case CompareStatus.newFile: return 'NEW';
      case CompareStatus.delete: return 'DELETED';
    }
  }

  Color _statusColor(CompareStatus status) {
    switch (status) {
      case CompareStatus.same: return Colors.grey.shade700;
      case CompareStatus.modify: return Colors.blue;
      case CompareStatus.newFile: return Colors.green;
      case CompareStatus.delete: return Colors.red;
    }
  }
}

// TOP LEVEL ISOLATE FUNCTIONS

Future<List<CompareResult>> _compareZips(Map<String, String> args) async {
  final remotePath = args['remote']!;
  final localPath = args['local']!;

  final remoteBytes = File(remotePath).readAsBytesSync();
  final localBytes = File(localPath).readAsBytesSync();

  final remoteArchive = ZipDecoder().decodeBytes(remoteBytes);
  final localArchive = ZipDecoder().decodeBytes(localBytes);

  final remoteMap = <String, ArchiveFile>{};
  for (var file in remoteArchive) {
    if (file.isFile) remoteMap[file.name] = file;
  }

  final localMap = <String, ArchiveFile>{};
  for (var file in localArchive) {
    if (file.isFile) localMap[file.name] = file;
  }

  final results = <CompareResult>[];

  // Compare Local against Remote
  for (var entry in localMap.entries) {
    final name = entry.key;
    final localFile = entry.value;

    if (remoteMap.containsKey(name)) {
      final remoteFile = remoteMap[name]!;
      final localHash = md5.convert(localFile.content as List<int>).toString();
      final remoteHash = md5.convert(remoteFile.content as List<int>).toString();

      if (localHash == remoteHash) {
        results.add(CompareResult(path: name, status: CompareStatus.same, size: localFile.size));
      } else {
        results.add(CompareResult(path: name, status: CompareStatus.modify, size: localFile.size));
      }
    } else {
      results.add(CompareResult(path: name, status: CompareStatus.newFile, size: localFile.size));
    }
  }

  // Check remote against local for deletions
  for (var entry in remoteMap.entries) {
    final name = entry.key;
    final remoteFile = entry.value;

    if (!localMap.containsKey(name)) {
      results.add(CompareResult(path: name, status: CompareStatus.delete, size: remoteFile.size));
    }
  }

  // Sort: Modified -> New -> Delete -> Same
  results.sort((a, b) => a.status.index.compareTo(b.status.index));

  return results;
}

Future<Map<String, dynamic>> _readZipFileContent(Map<String, String> args) async {
  final zipPath = args['zip']!;
  final filePath = args['file']!;

  final bytes = File(zipPath).readAsBytesSync();
  final archive = ZipDecoder().decodeBytes(bytes);

  for (var file in archive) {
    if (file.name == filePath) {
      if (file.size > 1024 * 500) { // Max 500KB preview
        return {'type': 'error', 'message': "File is too large to preview (> 500KB)."};
      }
      
      final content = file.content as List<int>;
      final ext = filePath.split('.').last.toLowerCase();
      
      if (['png', 'jpg', 'jpeg', 'gif', 'webp'].contains(ext)) {
        return {'type': 'image', 'bytes': Uint8List.fromList(content)};
      } else if (ext == 'svg') {
        return {'type': 'svg', 'bytes': Uint8List.fromList(content)};
      }
      
      // Basic check for text
      try {
        return {'type': 'text', 'content': String.fromCharCodes(content)};
      } catch (e) {
        return {'type': 'error', 'message': "File appears to be binary."};
      }
    }
  }
  
  throw Exception("File not found in archive");
}

Future<void> _createExportZip(Map<String, dynamic> args) async {
  final sourceZip = args['sourceZip'] as String;
  final savePath = args['savePath'] as String;
  final targetPaths = (args['targetPaths'] as List).cast<String>();

  final bytes = File(sourceZip).readAsBytesSync();
  final sourceArchive = ZipDecoder().decodeBytes(bytes);

  final newArchive = Archive();
  final targetPathSet = targetPaths.toSet();

  for (var file in sourceArchive) {
    if (targetPathSet.contains(file.name)) {
      newArchive.addFile(file);
    }
  }

  final encodedBytes = ZipEncoder().encode(newArchive);
  if (encodedBytes != null) {
    File(savePath).writeAsBytesSync(encodedBytes);
  } else {
    throw Exception("Failed to encode ZIP file");
  }
}

class DonutChartPainter extends CustomPainter {
  final int same;
  final int modify;
  final int newFile;
  final int delete;
  final Color baseColor;

  DonutChartPainter({
    required this.same,
    required this.modify,
    required this.newFile,
    required this.delete,
    required this.baseColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final int total = same + modify + newFile + delete;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.butt;

    final Rect rect = Rect.fromLTWH(7, 7, size.width - 14, size.height - 14);

    if (total == 0) {
      paint.color = baseColor;
      canvas.drawArc(rect, 0, 2 * pi, false, paint);
      return;
    }

    double startAngle = -pi / 2;

    void drawSegment(int count, Color color) {
      if (count == 0) return;
      final sweepAngle = (count / total) * 2 * pi;
      paint.color = color;
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
      startAngle += sweepAngle;
    }

    drawSegment(same, Colors.grey);
    drawSegment(modify, Colors.blue);
    drawSegment(newFile, Colors.green);
    drawSegment(delete, Colors.red);
  }

  @override
  bool shouldRepaint(covariant DonutChartPainter oldDelegate) {
    return oldDelegate.same != same ||
        oldDelegate.modify != modify ||
        oldDelegate.newFile != newFile ||
        oldDelegate.delete != delete ||
        oldDelegate.baseColor != baseColor;
  }
}
