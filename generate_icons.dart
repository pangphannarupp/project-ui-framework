import 'dart:io';

void main() async {
  final url = Uri.parse('https://raw.githubusercontent.com/flutter/flutter/master/packages/flutter/lib/src/material/icons.dart');
  final request = await HttpClient().getUrl(url);
  final response = await request.close();
  final contents = await response.transform(const SystemEncoding().decoder).join();

  final regex = RegExp(r'static const IconData ([a-zA-Z0-9_]+) =');
  final matches = regex.allMatches(contents);

  final uniqueIcons = <String>{};
  for (final match in matches) {
    uniqueIcons.add(match.group(1)!);
  }

  var mapString = '  final Map<String, IconData> _icons = {\n';
  for (final icon in uniqueIcons) {
    mapString += "    '$icon': Icons.$icon,\n";
  }
  mapString += '  };';

  final demoFile = File('flutter_sample/lib/data/demos/pp_icons_demo.dart');
  var demoContent = await demoFile.readAsString();

  demoContent = demoContent.replaceFirst(RegExp(r'final Map<String, IconData> _icons = \{.*?\};', dotAll: true), mapString);

  await demoFile.writeAsString(demoContent);
  print('Generated \${uniqueIcons.length} icons.');
}
