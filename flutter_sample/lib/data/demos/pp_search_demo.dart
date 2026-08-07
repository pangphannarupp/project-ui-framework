import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_searchData = ComponentItem(
    name: 'PPSearch',
    description: 'A comprehensive search component that supports real-time results, custom templates, and search history.',
    demoCode: '''
// 1. Search with History
PPSearch(
  value: query1,
  placeholder: 'Search with history...',
  history: historyList,
  results: results1,
  onChanged: (v) { /* ... */ },
)

// 2. Loading State & Custom Template
PPSearch(
  value: query2,
  placeholder: 'Search users...',
  loading: true, // or false when loaded
  results: userResults,
  itemLabelBuilder: (item) => "\${item['label']} - \${item['role']}",
)

// 3. Filter List (No History)
PPSearch(
  value: query3,
  placeholder: 'Filter framework...',
  results: filteredResults,
)

// 4. Simple Input (No Dropdown)
PPSearch(
  value: query4,
  placeholder: 'Type to search...',
)
''',
    demoBuilder: (context) {
      String q1 = '';
      List<String> history1 = ['Vue', 'React', 'Angular'];
      List<String> results1 = [];
      String? lastSearch1;

      String q2 = '';
      bool loading2 = false;
      List<Map<String, String>> results2 = [];

      String q3 = '';
      List<String> results3 = [];
      String? lastSearch3;

      String q4 = '';

      return StatefulBuilder(
        builder: (context, setState) {
          Widget _buildBox(String title, String desc, Widget child, Widget? footer) {
            return Container(
              width: 320,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(desc, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                  const SizedBox(height: 16),
                  child,
                  if (footer != null) ...[
                    const SizedBox(height: 16),
                    footer,
                  ],
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                // 1. Search with History
                _buildBox(
                  'Search with History',
                  'Try typing "vue" or focusing to see history.',
                  PPSearch(
                    value: q1,
                    placeholder: 'Search...',
                    history: history1,
                    results: results1,
                    onChanged: (val) {
                      setState(() {
                        q1 = val;
                        if (val.isEmpty) {
                          results1 = [];
                        } else {
                          results1 = ['Vue 3 Framework', 'React Native', 'Angular 14']
                              .where((e) => e.toLowerCase().contains(val.toLowerCase()))
                              .toList();
                        }
                      });
                    },
                    onSearch: (val) {
                      if (val.isNotEmpty && !history1.contains(val)) {
                        setState(() => history1.insert(0, val));
                      }
                      setState(() => lastSearch1 = val);
                    },
                    onSelect: (item) {
                      setState(() {
                        q1 = item as String;
                        lastSearch1 = item;
                        if (!history1.contains(item)) history1.insert(0, item);
                      });
                    },
                    onClearHistory: () => setState(() => history1.clear()),
                    onRemoveHistoryItem: (item) => setState(() => history1.remove(item)),
                  ),
                  lastSearch1 != null ? Text('Last searched: $lastSearch1', style: const TextStyle(color: Color(0xFF003399))) : null,
                ),

                // 2. Simulated API Search
                _buildBox(
                  'Simulated API Search',
                  'Types something to trigger loading state.',
                  PPSearch(
                    value: q2,
                    placeholder: 'Search users...',
                    loading: loading2,
                    results: results2,
                    itemLabelBuilder: (item) => "\${item['label']} (\${item['role']})",
                    onChanged: (val) {
                      setState(() {
                        q2 = val;
                        loading2 = true;
                        results2 = [];
                      });
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        setState(() {
                          loading2 = false;
                          if (val.isNotEmpty) {
                            results2 = [
                              {'label': 'Alice', 'role': 'Admin'},
                              {'label': 'Bob', 'role': 'User'},
                            ];
                          }
                        });
                      });
                    },
                  ),
                  null,
                ),

                // 3. Filter List
                _buildBox(
                  'Filter List',
                  'Search with results but no history state.',
                  PPSearch(
                    value: q3,
                    placeholder: 'Filter framework...',
                    results: results3,
                    onChanged: (val) {
                      setState(() {
                        q3 = val;
                        if (val.isEmpty) {
                          results3 = [];
                        } else {
                          results3 = ['Next.js', 'Nuxt', 'SvelteKit']
                              .where((e) => e.toLowerCase().contains(val.toLowerCase()))
                              .toList();
                        }
                      });
                    },
                    onSelect: (item) {
                      setState(() {
                        q3 = item as String;
                        lastSearch3 = item;
                        results3 = [];
                      });
                    },
                  ),
                  lastSearch3 != null ? Text('Selected: $lastSearch3', style: const TextStyle(color: Color(0xFF003399))) : null,
                ),

                // 4. Simple Search Input
                _buildBox(
                  'Simple Search Input',
                  'Just the styled input, no dropdown menu.',
                  PPSearch(
                    value: q4,
                    placeholder: 'Type to search...',
                    onChanged: (val) {
                      setState(() {
                        q4 = val;
                      });
                    },
                  ),
                  q4.isNotEmpty ? Text('Current query: $q4', style: const TextStyle(color: Color(0xFF003399))) : null,
                ),
              ],
            ),
          );
        }
      );
    },
  );


