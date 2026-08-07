import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_file_uploadData = ComponentItem(
    name: 'PPFileUpload',
    description: 'A dropzone area for file uploading with a list showing selected files and upload progress.',
    demoCode: '''
// Real usage requires the `file_picker` package:
PPFileUpload(
  accept: 'image/png, image/jpeg, application/pdf',
  maxSize: 5242880,
  files: _files,
  onDropzoneTap: () async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );
    if (result != null) {
      // Convert to PPFileItem and update state
    }
  },
  onRemove: (id) {
    setState(() => _files.removeWhere((f) => f.id == id));
  },
)''',
    demoBuilder: (context) {
      return const _FileUploadDemo();
    },
  );

class _FileUploadDemo extends StatefulWidget {
  const _FileUploadDemo({Key? key}) : super(key: key);

  @override
  State<_FileUploadDemo> createState() => _FileUploadDemoState();
}

class _FileUploadDemoState extends State<_FileUploadDemo> {
  final List<PPFileItem> _files = [];

  void _pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );
    if (result != null) {
      setState(() {
        for (final file in result.files) {
          _files.add(PPFileItem(
            id: file.name,
            name: file.name,
            size: file.size,
            status: PPFileUploadStatus.success,
            bytes: file.bytes,
          ));
        }
      });
    }
  }

  void _handleDrop(List<dynamic> droppedFiles) async {
    final files = droppedFiles.cast<XFile>();
    for (final file in files) {
      final bytes = await file.readAsBytes();
      final length = await file.length();
      setState(() {
        _files.add(PPFileItem(
          id: file.name,
          name: file.name,
          size: length,
          status: PPFileUploadStatus.success,
          bytes: bytes,
        ));
      });
    }
  }

  void _handlePreview(PPFileItem file) {
    if (file.bytes == null && file.previewUrl == null) return;
    showDialog(
      context: context,
      builder: (context) => Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (file.bytes != null)
              Image.memory(file.bytes!, fit: BoxFit.contain)
            else if (file.previewUrl != null)
              Image.network(file.previewUrl!, fit: BoxFit.contain),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(file.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Standard File Upload:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        PPFileUpload(
          accept: 'image/png, image/jpeg, application/pdf',
          maxSize: 5242880, // 5MB
          files: _files,
          onDropzoneTap: _pickFiles,
          onDrop: _handleDrop,
          onPreview: _handlePreview,
          onRemove: (id) {
            setState(() {
              _files.removeWhere((f) => f.id == id);
            });
          },
        ),
        const SizedBox(height: 32),
        const Text('Disabled State:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const PPFileUpload(
          disabled: true,
        ),
      ],
    );
  }
}
