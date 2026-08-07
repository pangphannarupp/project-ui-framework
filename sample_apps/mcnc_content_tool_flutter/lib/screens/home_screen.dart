import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _baseUrl = '';
  String _appKey = '';
  String _osType = 'Android';
  String _appMajor = '1';
  String _appMinor = '0';
  String _appBuild = '0';
  String _contentMajor = '0';
  String _contentMinor = '0';
  bool _testerMode = false;
  
  Map<String, dynamic>? remoteVersionInfo;
  bool isDownloading = false;
  double downloadProgress = 0;

  Map<String, dynamic> getProfile() {
    return {
      'baseUrl': _baseUrl,
      'appKey': _appKey,
      'osType': _osType,
      'appMajor': _appMajor,
      'appMinor': _appMinor,
      'appBuild': _appBuild,
      'contentMajor': _contentMajor,
      'contentMinor': _contentMinor,
      'testerMode': _testerMode,
    };
  }

  void setProfile(Map<String, dynamic> data) {
    setState(() {
      _baseUrl = data['baseUrl'] ?? '';
      _appKey = data['appKey'] ?? '';
      _osType = data['osType'] ?? 'Android';
      _appMajor = data['appMajor'] ?? '1';
      _appMinor = data['appMinor'] ?? '0';
      _appBuild = data['appBuild'] ?? '0';
      _contentMajor = data['contentMajor'] ?? '0';
      _contentMinor = data['contentMinor'] ?? '0';
      _testerMode = data['testerMode'] ?? false;
    });
  }

  Future<void> checkUpdate() async {
    if (_baseUrl.isEmpty) return;

    final url = Uri.tryParse(_baseUrl);
    if (url == null) return;

    try {
      final ioClient = HttpClient()
        ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      final client = IOClient(ioClient);

      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "header": {
            "error_code": "",
            "error_text": "",
            "info_text": "",
            "message_version": "",
            "result": true
          },
          "body": {
            "app_key": _appKey,
            "os_type": _osType,
            "app_major_version": int.tryParse(_appMajor) ?? 1,
            "app_minor_version": int.tryParse(_appMinor) ?? 0,
            "app_build_version": int.tryParse(_appBuild) ?? 0,
            "content_major_version": int.tryParse(_contentMajor) ?? 0,
            "content_minor_version": int.tryParse(_contentMinor) ?? 0,
            "app_tester": _testerMode
          }
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final body = data['body'];
        if (body != null) {
          _appMajor = body['app_major_version']?.toString() ?? _appMajor;
          _appMinor = body['app_minor_version']?.toString() ?? _appMinor;
          _appBuild = body['app_build_version']?.toString() ?? _appBuild;
          _osType = body['app_os_type']?.toString() ?? _osType;
          _contentMajor = body['content_major_version']?.toString() ?? _contentMajor;
          _contentMinor = body['content_minor_version']?.toString() ?? _contentMinor;
          
          setState(() {
            remoteVersionInfo = data;
          });
        }
      } else {
        debugPrint("Error: HTTP ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      debugPrint("Error checking update: $e");
    }
  }

  void importCurl(String curl) {
    // Very basic regex to pull out a URL
    final urlMatch = RegExp(r'"(https?://[^"]+)"').firstMatch(curl) ?? RegExp(r"'(https?://[^']+)'").firstMatch(curl);
    if (urlMatch != null) {
      _baseUrl = urlMatch.group(1) ?? '';
    } else {
      // check for unquoted url
      final unquotedUrl = RegExp(r'(https?://[^\s]+)').firstMatch(curl);
      if (unquotedUrl != null) {
        _baseUrl = unquotedUrl.group(1) ?? '';
      }
    }
    
    // Parse JSON body if present
    final dataIdx = curl.indexOf('--data');
    if (dataIdx != -1) {
      final jsonStart = curl.indexOf('{', dataIdx);
      final jsonEnd = curl.lastIndexOf('}');
      if (jsonStart != -1 && jsonEnd != -1 && jsonEnd > jsonStart) {
        final jsonStr = curl.substring(jsonStart, jsonEnd + 1);
        try {
          final data = jsonDecode(jsonStr);
          final body = data['body'];
          if (body != null) {
            _appKey = body['app_key']?.toString() ?? _appKey;
            _osType = body['os_type']?.toString() ?? _osType;
            _appMajor = body['app_major_version']?.toString() ?? _appMajor;
            _appMinor = body['app_minor_version']?.toString() ?? _appMinor;
            _appBuild = body['app_build_version']?.toString() ?? _appBuild;
            _contentMajor = body['content_major_version']?.toString() ?? _contentMajor;
            _contentMinor = body['content_minor_version']?.toString() ?? _contentMinor;
            if (body['app_tester'] is bool) {
              _testerMode = body['app_tester'];
            }
          }
        } catch (e) {
          debugPrint("Error parsing JSON from cURL: $e");
        }
      }
    } else {
      // Example extracting App Key if it's in a header
      final appKeyMatch = RegExp(r'App-Key:\s*([^\s"'"'"']+)').firstMatch(curl) ?? RegExp(r'app-key:\s*([^\s"'"'"']+)').firstMatch(curl);
      if (appKeyMatch != null) {
        _appKey = appKeyMatch.group(1) ?? '';
      }
    }
    
    setState(() {});
  }

  Future<String?> downloadUpdate() async {
    if (remoteVersionInfo == null) return null;
    
    final fileName = remoteVersionInfo!['body']?['content_filename'] ?? 'update.zip';
    
    final savePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Content Update',
      fileName: fileName,
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    
    if (savePath == null) return null; // User canceled
    
    setState(() {
      isDownloading = true;
      downloadProgress = 0;
    });

    bool success = false;
    try {
      final rootUrl = _baseUrl.endsWith('/update-check') 
          ? _baseUrl.substring(0, _baseUrl.length - '/update-check'.length) 
          : _baseUrl;
      final downloadUrl = Uri.parse('$rootUrl/download/update/content?file_name=$fileName&os_type=$_osType');
      
      final ioClient = HttpClient()
        ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      final client = IOClient(ioClient);
      
      final request = http.Request('GET', downloadUrl);
      final response = await client.send(request);
      
      if (response.statusCode != 200) {
        throw Exception('HTTP Error ${response.statusCode}: ${response.reasonPhrase}');
      }
      
      final totalBytes = response.contentLength ?? 0;
      int receivedBytes = 0;
      
      final file = File(savePath);
      final sink = file.openWrite();
      
      await for (final chunk in response.stream) {
        sink.add(chunk);
        receivedBytes += chunk.length;
        if (totalBytes > 0) {
          final progress = receivedBytes / totalBytes;
          if (mounted) {
            setState(() {
              downloadProgress = progress;
            });
          }
        }
      }
      
      await sink.flush();
      await sink.close();
      client.close();
      success = true;
    } catch (e) {
      debugPrint("Download failed: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isDownloading = false;
          downloadProgress = 0;
        });
      }
      return success ? savePath : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: [
              if (isDownloading)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 24.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F1FB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFCCE4F7)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Downloading ${remoteVersionInfo?['body']?['content_filename'] ?? 'Content'}...",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0067C0),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '${(downloadProgress * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0067C0),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: downloadProgress,
                          minHeight: 8,
                          backgroundColor: const Color(0xFF0067C0).withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0067C0)),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'API Configuration Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF9370DB),
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFE5E7EB)),
                const SizedBox(height: 16),
                
                // Form Layout
                PPInput(
                  label: 'Base URL',
                  placeholder: 'Enter base URL',
                  value: _baseUrl,
                  onChanged: (v) => _baseUrl = v,
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: PPInput(
                        label: 'App Key',
                        placeholder: '',
                        value: _appKey,
                        onChanged: (v) => _appKey = v,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PPInput(
                        label: 'OS Type',
                        placeholder: 'Android',
                        value: _osType,
                        onChanged: (v) => _osType = v,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PPInput(
                        label: 'App Major Version',
                        placeholder: '1',
                        value: _appMajor,
                        onChanged: (v) => _appMajor = v,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: PPInput(
                        label: 'App Minor Version',
                        placeholder: '0',
                        value: _appMinor,
                        onChanged: (v) => _appMinor = v,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PPInput(
                        label: 'App Build Version',
                        placeholder: '0',
                        value: _appBuild,
                        onChanged: (v) => _appBuild = v,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: PPInput(
                        label: 'Content Major Version',
                        placeholder: '0',
                        value: _contentMajor,
                        onChanged: (v) => _contentMajor = v,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: PPInput(
                        label: 'Content Minor Version',
                        placeholder: '0',
                        value: _contentMinor,
                        onChanged: (v) => _contentMinor = v,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(child: SizedBox()),
                    const SizedBox(width: 16),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 24),
                
                PPCheckbox(
                  label: 'Enable App Tester Mode',
                  value: _testerMode,
                  onChanged: (val) => setState(() => _testerMode = val ?? false),
                ),
                
                if (remoteVersionInfo != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Server Response:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          const JsonEncoder.withIndent('  ').convert(remoteVersionInfo),
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
