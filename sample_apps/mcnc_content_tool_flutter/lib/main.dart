import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/compare_screen.dart';

import 'dart:io' show exit, Platform;
import 'package:flutter/services.dart';

class AppSettings {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);
  static final ValueNotifier<Color> themeColor = ValueNotifier(const Color(0xFF4F46E5));
  static final ValueNotifier<String> language = ValueNotifier('English');
  
  static Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    final themeStr = prefs.getString('themeMode');
    if (themeStr == 'Light') themeMode.value = ThemeMode.light;
    else if (themeStr == 'Dark') themeMode.value = ThemeMode.dark;
    else themeMode.value = ThemeMode.system;
    
    final colorVal = prefs.getInt('themeColor');
    if (colorVal != null) themeColor.value = Color(colorVal);
    
    language.value = prefs.getString('language') ?? 'English';
  }

  static Future<void> saveThemeMode(String val) async {
    if (val == 'Light') themeMode.value = ThemeMode.light;
    else if (val == 'Dark') themeMode.value = ThemeMode.dark;
    else themeMode.value = ThemeMode.system;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', val);
  }

  static Future<void> saveThemeColor(Color val) async {
    themeColor.value = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', val.value);
  }

  static Future<void> saveLanguage(String val) async {
    language.value = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', val);
  }
}

const _khmerStrings = {
  'Home': 'ទំព័រដើម',
  'Compare': 'ប្រៀបធៀប',
  'Settings': 'ការកំណត់',
  'Check Update': 'ពិនិត្យ',
  'Download Content': 'ទាញយក',
  'Actions': 'សកម្មភាព',
  'Tools': 'ឧបករណ៍',
  'Import cURL': 'នាំចូល cURL',
  'Profiles': 'ប្រវត្តិរូប',
  'Save': 'រក្សាទុក',
  'Delete': 'លុប',
  'File Selection': 'ជ្រើសរើសឯកសារ',
  'Remote Archive': 'ឯកសារពីចម្ងាយ',
  'Local Archive': 'ឯកសារក្នុងម៉ាស៊ីន',
  'Analysis': 'វិភាគ',
  'Compare Zips': 'ប្រៀបធៀបឯកសារ',
  'Language': 'ភាសា',
  'Interface Theme': 'រូបរាង',
  'About App': 'អំពីកម្មវិធី',
  'Exit': 'ចាកចេញ',
};

String t(String key) {
  if (AppSettings.language.value == 'Khmer') {
    return _khmerStrings[key] ?? key;
  }
  return key;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSettings.loadSettings();
  runApp(const McncContentToolApp());
}

class McncContentToolApp extends StatelessWidget {
  const McncContentToolApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppSettings.themeMode,
      builder: (context, mode, _) {
        return ValueListenableBuilder<Color>(
          valueListenable: AppSettings.themeColor,
          builder: (context, color, _) {
            return ValueListenableBuilder<String>(
              valueListenable: AppSettings.language,
              builder: (context, lang, _) {
                return MaterialApp(
                  title: 'mcnc-content-tool',
                  themeMode: mode,
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: color,
                      brightness: Brightness.light,
                    ),
                    useMaterial3: true,
                    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
                  ),
                  darkTheme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: color,
                      brightness: Brightness.dark,
                    ),
                    useMaterial3: true,
                    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
                  ),
                  home: MainLayoutScreen(),
                  debugShowCheckedModeBanner: false,
                );
              },
            );
          },
        );
      },
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                title: t('Home'),
                groups: [
                  PPRibbonGroup(
                    title: t('Actions'),
                    children: [
                      PPRibbonButton(
                        label: t('Check Update'),
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
                            label: t('Download Content'),
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
                    title: t('Tools'),
                    children: [
                      PPRibbonButton(
                        label: t('Import cURL'),
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
                    title: t('Profiles'),
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: PPSelect(
                                size: PPSelectSize.sm,
                                borderRadius: 4.0,
                                placeholder: 'Load Profile...',
                                value: _selectedProfile != null && _profiles.containsKey(_selectedProfile) ? _selectedProfile : null,
                                options: _profiles.keys.map((String key) {
                                  return PPSelectOption(label: key, value: key);
                                }).toList(),
                                onChanged: (String? val) {
                                  if (val != null) _applyProfile(val);
                                },
                              ),
                            ),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF333333) : Colors.white,
                                border: Border.all(color: isDark ? const Color(0xFF555555) : Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: TextField(
                                controller: _newProfileCtrl,
                                style: TextStyle(fontSize: 11, color: isDark ? Colors.white : Colors.black),
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
                        label: t('Save'),
                        icon: Icons.save_outlined,
                        size: PPRibbonButtonSize.small,
                        onPressed: _saveCurrentProfile,
                      ),
                      PPRibbonButton(
                        label: t('Delete'),
                        icon: Icons.delete_outline,
                        size: PPRibbonButtonSize.small,
                        onPressed: _selectedProfile != null ? _deleteProfile : null,
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: t('Language'),
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t('Language'), style: const TextStyle(fontSize: 10)),
                            const SizedBox(height: 4),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white,
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  isDense: true,
                                  dropdownColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white,
                                  value: AppSettings.language.value,
                                  items: ['English', 'Khmer'].map((String val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(t(val), style: TextStyle(fontSize: 11, color: Theme.of(context).textTheme.bodyMedium?.color)),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) {
                                    if (val != null) AppSettings.saveLanguage(val);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: t('Interface Theme'),
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(t('Interface Theme'), style: const TextStyle(fontSize: 10)),
                            const SizedBox(height: 4),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white,
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  isDense: true,
                                  dropdownColor: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF333333) : Colors.white,
                                  value: AppSettings.themeMode.value == ThemeMode.light 
                                      ? 'Light' : (AppSettings.themeMode.value == ThemeMode.dark ? 'Dark' : 'System'),
                                  items: ['System', 'Light', 'Dark'].map((String val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(t(val), style: TextStyle(fontSize: 11, color: Theme.of(context).textTheme.bodyMedium?.color)),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? val) {
                                    if (val != null) AppSettings.saveThemeMode(val);
                                  },
                                ),
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
                      InkWell(
                        onTap: () {
                          // Cycle through some colors
                          final colors = [const Color(0xFF4F46E5), Colors.pink, Colors.orange, Colors.green, Colors.teal];
                          final idx = colors.indexOf(AppSettings.themeColor.value);
                          AppSettings.saveThemeColor(colors[(idx + 1) % colors.length]);
                        },
                        child: Container(
                          width: 40,
                          height: 24,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: AppSettings.themeColor.value,
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: '',
                    children: [
                      PPRibbonButton(
                        label: t('About App'),
                        icon: Icons.info_outline,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(t('About App')),
                              content: const Text('MCNC Content Tool\nVersion 1.0.0+1\nDeveloped by MCNC.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK'))
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: '',
                    children: [
                      PPRibbonButton(
                        label: t('Exit'),
                        icon: Icons.exit_to_app,
                        onPressed: () {
                          if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
                            exit(0);
                          } else {
                            SystemNavigator.pop();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
              PPRibbonTab(
                id: 'compare',
                title: t('Compare'),
                groups: [
                  PPRibbonGroup(
                    title: t('File Selection'),
                    children: [
                      PPRibbonButton(
                        label: t('Remote Archive'),
                        icon: Icons.note_add_outlined,
                        onPressed: () {
                          _compareScreenKey.currentState?.pickRemoteArchive();
                        },
                      ),
                      PPRibbonButton(
                        label: t('Local Archive'),
                        icon: Icons.folder_open_outlined,
                        onPressed: () {
                          _compareScreenKey.currentState?.pickLocalArchive();
                        },
                      ),
                    ],
                  ),
                  PPRibbonGroup(
                    title: t('Analysis'),
                    children: [
                      PPRibbonButton(
                        label: t('Compare Zips'),
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
