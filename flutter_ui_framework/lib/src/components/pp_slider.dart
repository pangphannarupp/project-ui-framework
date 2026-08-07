import 'package:flutter/material.dart';

enum PPSliderVariant {
  standard,
  m3,
}

class PPRangeValues {
  final double lower;
  final double upper;

  const PPRangeValues(this.lower, this.upper);
}

class PPSlider extends StatelessWidget {
  final double min;
  final double max;
  final int? divisions; // Maps to 'step' indirectly, or we can use step logic.
  final bool disabled;
  final String? label;
  final bool showValue;
  final PPSliderVariant variant;
  final String Function(double)? valueFormatter;
  final String Function(PPRangeValues)? rangeValueFormatter;

  // Single Slider
  final double? value;
  final ValueChanged<double>? onChanged;

  // Range Slider
  final bool dualKnobs;
  final PPRangeValues? rangeValues;
  final ValueChanged<PPRangeValues>? onRangeChanged;

  const PPSlider({
    Key? key,
    this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.disabled = false,
    this.label,
    this.showValue = false,
    this.variant = PPSliderVariant.standard,
    this.valueFormatter,
  })  : dualKnobs = false,
        rangeValues = null,
        onRangeChanged = null,
        rangeValueFormatter = null,
        super(key: key);

  const PPSlider.range({
    Key? key,
    required PPRangeValues this.rangeValues,
    required ValueChanged<PPRangeValues>? this.onRangeChanged,
    this.min = 0.0,
    this.max = 100.0,
    this.divisions,
    this.disabled = false,
    this.label,
    this.showValue = false,
    this.variant = PPSliderVariant.standard,
    this.rangeValueFormatter,
  })  : dualKnobs = true,
        value = null,
        onChanged = null,
        valueFormatter = null,
        super(key: key);

  String _getDisplayValue() {
    if (dualKnobs && rangeValues != null) {
      if (rangeValueFormatter != null) {
        return rangeValueFormatter!(rangeValues!);
      }
      return '${rangeValues!.lower.toStringAsFixed(1)} - ${rangeValues!.upper.toStringAsFixed(1)}';
    } else if (!dualKnobs && value != null) {
      if (valueFormatter != null) {
        return valueFormatter!(value!);
      }
      return value!.toStringAsFixed(1);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final bool isM3 = variant == PPSliderVariant.m3;
    final primaryColor = const Color(0xFF003399);

    SliderThemeData themeData = SliderTheme.of(context).copyWith(
      activeTrackColor: primaryColor,
      inactiveTrackColor: isM3 ? primaryColor.withOpacity(0.15) : const Color(0xFFE0E0E0),
      thumbColor: Colors.white,
      overlayColor: primaryColor.withOpacity(0.1),
      trackHeight: isM3 ? 16.0 : 4.0,
    );

    if (isM3) {
      themeData = themeData.copyWith(
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 14.0,
          elevation: 4.0,
          pressedElevation: 8.0,
        ),
        rangeThumbShape: const RoundRangeSliderThumbShape(
          enabledThumbRadius: 14.0,
          elevation: 4.0,
          pressedElevation: 8.0,
        ),
      );
    } else {
      themeData = themeData.copyWith(
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 12.0,
          elevation: 2.0,
          pressedElevation: 4.0,
        ),
        rangeThumbShape: const RoundRangeSliderThumbShape(
          enabledThumbRadius: 12.0,
          elevation: 2.0,
          pressedElevation: 4.0,
        ),
      );
    }

    Widget sliderWidget;

    if (dualKnobs) {
      sliderWidget = RangeSlider(
        values: RangeValues(rangeValues?.lower ?? min, rangeValues?.upper ?? max),
        min: min,
        max: max,
        divisions: divisions,
        onChanged: disabled
            ? null
            : (values) {
                if (onRangeChanged != null) {
                  onRangeChanged!(PPRangeValues(values.start, values.end));
                }
              },
      );
    } else {
      sliderWidget = Slider(
        value: value ?? min,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: disabled ? null : onChanged,
      );
    }

    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null || showValue)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1A2A5E),
                      ),
                    ),
                  if (showValue)
                    Text(
                      _getDisplayValue(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          SliderTheme(
            data: themeData,
            child: sliderWidget,
          ),
        ],
      ),
    );
  }
}
