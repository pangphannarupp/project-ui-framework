import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_ribbonData = ComponentItem(
    name: 'PPRibbon',
    description: 'A Microsoft Office style ribbon menu with tabs, groups, and buttons.',
    demoCode: '''
PPRibbon(
  tabs: [
    PPRibbonTab(
      id: 'home',
      title: 'HOME',
      groups: [
        PPRibbonGroup(
          title: 'Clipboard',
          children: [
            PPRibbonButton(label: 'Paste', icon: Icons.paste),
            PPRibbonButton(label: 'Cut', icon: Icons.content_cut, size: PPRibbonButtonSize.small),
            PPRibbonButton(label: 'Copy', icon: Icons.copy, size: PPRibbonButtonSize.small),
          ],
        ),
      ],
    ),
  ],
)
''',
    demoBuilder: (context) {
      return const _RibbonDemo();
    },
  );

class _RibbonDemo extends StatelessWidget {
  const _RibbonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PPRibbon(
        initialActiveTabId: 'home',
          tabs: [
            PPRibbonTab(
              id: 'file',
              title: 'FILE',
              color: const Color(0xFF2563EB), // Primary blue
              groups: [
                PPRibbonGroup(
                  title: 'Document',
                  children: [
                    PPRibbonButton(
                      label: 'Save',
                      icon: Icons.save,
                      size: PPRibbonButtonSize.large,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Save As',
                      icon: Icons.save_as,
                      size: PPRibbonButtonSize.large,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            PPRibbonTab(
              id: 'home',
              title: 'HOME',
              groups: [
                PPRibbonGroup(
                  title: 'Clipboard',
                  children: [
                    PPRibbonButton(
                      label: 'Paste',
                      icon: Icons.paste,
                      size: PPRibbonButtonSize.large,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Cut',
                      icon: Icons.content_cut,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Copy',
                      icon: Icons.copy,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Format Painter',
                      icon: Icons.format_paint,
                      size: PPRibbonButtonSize.small,
                      disabled: true,
                      onPressed: () {},
                    ),
                  ],
                ),
                PPRibbonGroup(
                  title: 'Font',
                  children: [
                    PPRibbonButton(
                      label: 'Bold',
                      hideLabel: true,
                      icon: Icons.format_bold,
                      size: PPRibbonButtonSize.small,
                      active: true,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Italic',
                      hideLabel: true,
                      icon: Icons.format_italic,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Underline',
                      hideLabel: true,
                      icon: Icons.format_underline,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Strikethrough',
                      hideLabel: true,
                      icon: Icons.format_strikethrough,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Text Color',
                      hideLabel: true,
                      icon: Icons.format_color_text,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Fill Color',
                      hideLabel: true,
                      icon: Icons.format_color_fill,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                  ],
                ),
                PPRibbonGroup(
                  title: 'Paragraph',
                  children: [
                    PPRibbonButton(label: 'Bullets', hideLabel: true, icon: Icons.format_list_bulleted, size: PPRibbonButtonSize.small, onPressed: () {}),
                    PPRibbonButton(label: 'Numbering', hideLabel: true, icon: Icons.format_list_numbered, size: PPRibbonButtonSize.small, onPressed: () {}),
                    PPRibbonButton(label: 'Left', hideLabel: true, icon: Icons.format_align_left, size: PPRibbonButtonSize.small, onPressed: () {}),
                    PPRibbonButton(label: 'Center', hideLabel: true, icon: Icons.format_align_center, size: PPRibbonButtonSize.small, onPressed: () {}),
                    PPRibbonButton(label: 'Right', hideLabel: true, icon: Icons.format_align_right, size: PPRibbonButtonSize.small, onPressed: () {}),
                    PPRibbonButton(label: 'Justify', hideLabel: true, icon: Icons.format_align_justify, size: PPRibbonButtonSize.small, onPressed: () {}),
                  ],
                ),
                PPRibbonGroup(
                  title: 'Styles',
                  children: [
                    PPRibbonButton(
                      label: 'Conditional Formatting',
                      icon: Icons.color_lens,
                      size: PPRibbonButtonSize.large,
                      onPressed: () {},
                    ),
                  ],
                ),
                PPRibbonGroup(
                  title: 'Editing',
                  children: [
                    PPRibbonButton(
                      label: 'Find',
                      icon: Icons.search,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Replace',
                      icon: Icons.find_replace,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Select',
                      icon: Icons.select_all,
                      size: PPRibbonButtonSize.small,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            PPRibbonTab(
              id: 'insert',
              title: 'INSERT',
              groups: [
                PPRibbonGroup(
                  title: 'Illustrations',
                  children: [
                    PPRibbonButton(
                      label: 'Pictures',
                      icon: Icons.image,
                      size: PPRibbonButtonSize.large,
                      onPressed: () {},
                    ),
                    PPRibbonButton(
                      label: 'Shapes',
                      icon: Icons.category,
                      size: PPRibbonButtonSize.large,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
    );
  }
}
