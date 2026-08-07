import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/compare_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const McncContentToolApp());
}

class McncContentToolApp extends StatelessWidget {
  const McncContentToolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mcnc-content-tool',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B4EE6),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
      ),
      home: const MainLayoutScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  String _activeTabId = 'home';
  final GlobalKey<HomeScreenState> _homeScreenKey = GlobalKey<HomeScreenState>();
  final GlobalKey<CompareScreenState> _compareScreenKey = GlobalKey<CompareScreenState>();
  final ValueNotifier<bool> _canDownload = ValueNotifier<bool>(false);
  String _curlInput = '';

  String? _remoteZipPath;

  Map<String, dynamic> _profiles = {};
  String? _selectedProfile;
  final TextEditingController _newProfileCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfiles();
  }

  Future<void> _loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    final profilesJson = prefs.getString('api_profiles');
    if (profilesJson != null) {
      setState(() {
        _profiles = jsonDecode(profilesJson);
      });
    }
  }

  Future<void> _saveProfiles() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_profiles', jsonEncode(_profiles));
  }

  void _saveCurrentProfile() {
    final name = _newProfileCtrl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a profile name to save')));
      return;
    }
    if (_homeScreenKey.currentState != null) {
      setState(() {
        _profiles[name] = _homeScreenKey.currentState!.getProfile();
        _selectedProfile = name;
      });
      _saveProfiles();
      _newProfileCtrl.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile "$name" saved!')));
    }
  }
  
  void _deleteProfile() {
    if (_selectedProfile != null) {
      final name = _selectedProfile;
      setState(() {
        _profiles.remove(_selectedProfile);
        _selectedProfile = null;
      });
      _saveProfiles();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile "$name" deleted!')));
    }
  }
  
  void _applyProfile(String name) {
    setState(() {
      _selectedProfile = name;
    });
    if (_homeScreenKey.currentState != null && _profiles.containsKey(name)) {
      _homeScreenKey.currentState!.setProfile(_profiles[name]);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile "$name" loaded!')));
    }
  }

  Widget _buildActiveScreen() {
    switch (_activeTabId) {
      case 'home':
        return HomeScreen(key: _homeScreenKey);
      case 'compare':
        return CompareScreen(
          key: _compareScreenKey,
          initialRemoteZipPath: _remoteZipPath,
        );
      case 'settings':
        return const SettingsScreen();
      default:
        return HomeScreen(key: _homeScreenKey);
    }
  }

  @override
  void dispose() {
    _canDownload.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          PPRibbon(
            initialActiveTabId: _activeTabId,
            collapsible: true,
            onTabChanged: (id) {
              setState(() {
                _activeTabId = id;
              });
            },
            tabs: [
              PPRibbonTab(
                id: 'home',
                title: 'Home',
                groups: [
                  PPRibbonGroup(
                    title: 'Actions',
                    children: [
                      PPRibbonButton(
                        label: 'Check Update',
                        icon: Icons.sync,
                        active: true,
                        onPressed: () async {
                          if (_homeScreenKey.currentState != null) {
                            await _homeScreenKey.currentState!.checkUpdate();
                            if (_homeScreenKey.currentState!.remoteVersionInfo != null) {
                              _canDownload.value = true;
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Update checked successfully')),
                                );
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Update check failed (Check Network or API)'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          }
                        },
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: _canDownload,
                        builder: (context, canDownload, _) {
                          return PPRibbonButton(
                            label: 'Download Content',
                            icon: Icons.download_outlined,
                            disabled: !canDownload,
                            onPressed: canDownload ? () async {
                              if (_homeScreenKey.currentState != null) {
                                final savePath = await _homeScreenKey.currentState!.downloadUpdate();
                                if (savePath != null) {
                                  setState(() {
                                    _remoteZipPath = savePath;
                                  });
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Download complete! Compare tab updated.')),
                                    );
                                  }
                                }
                              }
                            } : null,
                          );
                        },
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: 'Tools',
                    children: [
                      PPRibbonButton(
                        label: 'Import cURL',
                        icon: Icons.upload_outlined,
                        onPressed: () {
                          _curlInput = '';
                          PPDialog.show(
                            context: context,
                            title: const Text('Import cURL'),
                            content: SizedBox(
                              width: 400,
                              child: PPInput(
                                label: 'Paste cURL command',
                                placeholder: 'curl -X GET "https://api.example.com"...',
                                value: _curlInput,
                                onChanged: (v) => _curlInput = v,
                              ),
                            ),
                            actions: [
                              PPButton(
                                variant: PPButtonVariant.ghost,
                                onPressed: () => Navigator.pop(context),
                                label: 'Cancel',
                              ),
                              PPButton(
                                label: 'Import',
                                onPressed: () {
                                  if (_homeScreenKey.currentState != null) {
                                    _homeScreenKey.currentState!.importCurl(_curlInput);
                                  }
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('cURL imported successfully')),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: 'Profiles',
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              margin: const EdgeInsets.only(bottom: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  isDense: true,
                                  dropdownColor: Colors.white,
                                  focusColor: Colors.transparent,
                                  icon: const Icon(Icons.arrow_drop_down, size: 16),
                                  hint: const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text('Load Profile...', style: TextStyle(fontSize: 11)),
                                  ),
                                  value: _selectedProfile != null && _profiles.containsKey(_selectedProfile) ? _selectedProfile : null,
                                  items: _profiles.keys.map((String key) {
                                    return DropdownMenuItem<String>(
                                      value: key,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(key, style: const TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) {
                                    if (val != null) _applyProfile(val);
                                  },
                                ),
                              ),
                            ),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: TextField(
                                controller: _newProfileCtrl,
                                style: const TextStyle(fontSize: 11),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  hintText: 'New Profile...',
                                  hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PPRibbonButton(
                        label: 'Save',
                        icon: Icons.save_outlined,
                        size: PPRibbonButtonSize.small,
                        onPressed: _saveCurrentProfile,
                      ),
                      PPRibbonButton(
                        label: 'Delete',
                        icon: Icons.delete_outline,
                        size: PPRibbonButtonSize.small,
                        onPressed: _selectedProfile != null ? _deleteProfile : null,
                      ),
                    ],
                  ),
                ],
              ),
              PPRibbonTab(
                id: 'compare',
                title: 'Compare',
                groups: [
                  PPRibbonGroup(
                    title: 'File Selection',
                    children: [
                      PPRibbonButton(
                        label: 'Remote Archive',
                        icon: Icons.note_add_outlined,
                        onPressed: () {
                          _compareScreenKey.currentState?.pickRemoteArchive();
                        },
                      ),
                      PPRibbonButton(
                        label: 'Local Archive',
                        icon: Icons.folder_open_outlined,
                        onPressed: () {
                          _compareScreenKey.currentState?.pickLocalArchive();
                        },
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: 'Analysis',
                    children: [
                      PPRibbonButton(
                        label: 'Compare Zips',
                        icon: Icons.compare_arrows,
                        onPressed: () {
                          if (_compareScreenKey.currentState?.remoteZipPath == null ||
                              _compareScreenKey.currentState?.localZipPath == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please select both Remote and Local archives first.')),
                            );
                            return;
                          }
                          _compareScreenKey.currentState?.runCompare();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              PPRibbonTab(
                id: 'settings',
                title: 'Settings',
                groups: [
                  PPRibbonGroup(
                    title: 'Language',
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Language', style: TextStyle(fontSize: 10)),
                            const SizedBox(height: 4),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(child: Padding(padding: EdgeInsets.only(left: 8), child: Text('English', style: TextStyle(fontSize: 11)))),
                                  Icon(Icons.arrow_drop_down, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: 'Interface Theme',
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Interface Theme', style: TextStyle(fontSize: 10)),
                            const SizedBox(height: 4),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Row(
                                children: [
                                  Expanded(child: Padding(padding: EdgeInsets.only(left: 8), child: Text('Light', style: TextStyle(fontSize: 11)))),
                                  Icon(Icons.arrow_drop_down, size: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: '',
                    children: [
                      Container(
                        width: 40,
                        height: 24,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF9370DB),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: '',
                    children: [
                      PPRibbonButton(
                        label: 'About App',
                        icon: Icons.info_outline,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: '',
                    children: [
                      PPRibbonButton(
                        label: 'Exit',
                        icon: Icons.exit_to_app,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: _buildActiveScreen(),
          ),
        ],
      ),
    );
  }
}
