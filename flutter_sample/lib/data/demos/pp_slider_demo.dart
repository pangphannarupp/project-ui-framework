import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_sliderData = ComponentItem(
    name: 'PPSlider',
    description: 'A customizable slider component supporting single values and ranges.',
    demoCode: '''
// Standard Slider
PPSlider(
  label: 'Brightness',
  showValue: true,
  value: sliderValue,
  onChanged: (val) => setState(() => sliderValue = val),
)

// Range Slider
PPSlider.range(
  label: 'Price Range',
  showValue: true,
  min: 0,
  max: 1000,
  rangeValues: rangeValue, // PPRangeValues
  onRangeChanged: (val) => setState(() => rangeValue = val),
)
''',
    demoBuilder: (context) {
      double singleValue = 50.0;
      PPRangeValues rangeValue = const PPRangeValues(200.0, 800.0);
      double m3Value = 75.0;

      return StatefulBuilder(
        builder: (context, setState) {
          return Center(
            child: SizedBox(
              width: 320,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Single Value Slider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPSlider(
                    label: 'Brightness',
                    showValue: true,
                    value: singleValue,
                    onChanged: (val) => setState(() => singleValue = val),
                  ),
                  const SizedBox(height: 32),
                  const Text('Range Slider', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPSlider.range(
                    label: 'Price Range (\$)',
                    showValue: true,
                    min: 0,
                    max: 1000,
                    rangeValues: rangeValue,
                    onRangeChanged: (val) => setState(() => rangeValue = val),
                  ),
                  const SizedBox(height: 32),
                  const Text('Material 3 Variant', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  PPSlider(
                    label: 'Volume',
                    showValue: true,
                    variant: PPSliderVariant.m3,
                    value: m3Value,
                    onChanged: (val) => setState(() => m3Value = val),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );


