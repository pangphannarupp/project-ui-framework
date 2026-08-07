import 'package:flutter/material.dart';
import 'dart:ui';

enum PPSegmentVariant { pill, underline, block, material3, iosGlass }

class PPSegmentButton<T> {
  final T value;
  final String label;
  final Widget? icon;

  PPSegmentButton({
    required this.value,
    required this.label,
    this.icon,
  });
}

class PPSegment<T> extends StatelessWidget {
  final T value;
  final List<PPSegmentButton<T>> items;
  final ValueChanged<T> onChanged;
  final PPSegmentVariant variant;

  const PPSegment({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.variant = PPSegmentVariant.pill,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == PPSegmentVariant.underline) {
      return _buildUnderlineVariant();
    }

    return _buildAnimatedVariant();
  }

  Widget _buildUnderlineVariant() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((item) {
          final isActive = item.value == value;
          return InkWell(
            onTap: () => onChanged(item.value),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isActive ? const Color(0xFF3B82F6) : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.icon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
                        size: 18,
                      ),
                      child: item.icon!,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAnimatedVariant() {
    Color containerBgColor;
    Color containerBorderColor;
    double containerRadius;
    EdgeInsets containerPadding;

    Color indicatorBgColor;
    double indicatorRadius;
    List<BoxShadow>? indicatorShadow;

    Color activeTextColor;
    Color inactiveTextColor;
    FontWeight activeFontWeight;
    FontWeight inactiveFontWeight = FontWeight.w500;
    
    double gap = 0;

    switch (variant) {
      case PPSegmentVariant.pill:
        containerBgColor = Colors.white;
        containerBorderColor = const Color(0xFFE0E0E0);
        containerRadius = 30;
        containerPadding = const EdgeInsets.all(4);
        
        indicatorBgColor = const Color(0xFF1A2A5E);
        indicatorRadius = 30;
        indicatorShadow = [const BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2))];
        
        activeTextColor = Colors.white;
        inactiveTextColor = const Color(0xFF666666);
        activeFontWeight = FontWeight.w500;
        break;
        
      case PPSegmentVariant.block:
        containerBgColor = const Color(0xFFF1F5F9);
        containerBorderColor = Colors.transparent;
        containerRadius = 8;
        containerPadding = const EdgeInsets.all(4);
        gap = 4;
        
        indicatorBgColor = Colors.white;
        indicatorRadius = 6;
        indicatorShadow = [const BoxShadow(color: Color(0x1A000000), blurRadius: 3, offset: Offset(0, 1))];
        
        activeTextColor = const Color(0xFF0F172A);
        inactiveTextColor = const Color(0xFF475569);
        activeFontWeight = FontWeight.w500;
        break;
        
      case PPSegmentVariant.material3:
        containerBgColor = const Color(0xFFF3F4F6);
        containerBorderColor = Colors.transparent;
        containerRadius = 30;
        containerPadding = const EdgeInsets.all(4);
        
        indicatorBgColor = const Color(0xFFD8E4FF);
        indicatorRadius = 30;
        indicatorShadow = null;
        
        activeTextColor = const Color(0xFF004085);
        inactiveTextColor = const Color(0xFF4B5563);
        activeFontWeight = FontWeight.w600;
        break;
        
      case PPSegmentVariant.iosGlass:
        containerBgColor = Colors.white.withOpacity(0.4);
        containerBorderColor = Colors.white.withOpacity(0.3);
        containerRadius = 20;
        containerPadding = const EdgeInsets.all(3);
        
        indicatorBgColor = Colors.white;
        indicatorRadius = 18;
        indicatorShadow = [
          const BoxShadow(color: Color(0x1F000000), blurRadius: 8, offset: Offset(0, 3)),
          const BoxShadow(color: Color(0x0A000000), blurRadius: 1, offset: Offset(0, 3))
        ];
        
        activeTextColor = Colors.black;
        inactiveTextColor = Colors.black.withOpacity(0.6);
        activeFontWeight = FontWeight.w600;
        inactiveFontWeight = FontWeight.w600;
        break;
        
      default:
        containerBgColor = Colors.transparent;
        containerBorderColor = Colors.transparent;
        containerRadius = 0;
        containerPadding = EdgeInsets.zero;
        indicatorBgColor = Colors.transparent;
        indicatorRadius = 0;
        activeTextColor = Colors.black;
        inactiveTextColor = Colors.black;
        activeFontWeight = FontWeight.normal;
    }

    int selectedIndex = items.indexWhere((item) => item.value == value);
    if (selectedIndex == -1) selectedIndex = 0;

    Widget containerContent = Container(
      padding: containerPadding,
      decoration: BoxDecoration(
        color: containerBgColor,
        borderRadius: BorderRadius.circular(containerRadius),
        border: Border.all(color: containerBorderColor),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = constraints.maxWidth;
          // Calculate the width of one segment, considering gaps
          // If we have gap G and N items, total gap space is G * (N - 1)
          // Width of one item W = (totalWidth - (N - 1) * G) / N
          // The indicator left position = index * (W + G)
          
          double itemWidth = 0;
          double indicatorLeft = 0;
          
          if (items.isNotEmpty) {
            itemWidth = (totalWidth - gap * (items.length - 1)) / items.length;
            indicatorLeft = selectedIndex * (itemWidth + gap);
          }

          return Stack(
            children: [
              // Indicator
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                left: indicatorLeft,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: indicatorBgColor,
                    borderRadius: BorderRadius.circular(indicatorRadius),
                    boxShadow: indicatorShadow,
                  ),
                ),
              ),
              
              // Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  final isActive = index == selectedIndex;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (index > 0) SizedBox(width: gap),
                      SizedBox(
                        width: itemWidth,
                        child: InkWell(
                          onTap: () => onChanged(item.value),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: isActive ? activeTextColor : inactiveTextColor,
                                fontWeight: isActive ? activeFontWeight : inactiveFontWeight,
                                fontSize: variant == PPSegmentVariant.iosGlass ? 13 : 14,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (item.icon != null) ...[
                                    IconTheme(
                                      data: IconThemeData(
                                        color: isActive ? activeTextColor : inactiveTextColor,
                                        size: 18,
                                      ),
                                      child: item.icon!,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                  Text(item.label),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          );
        },
      ),
    );

    if (variant == PPSegmentVariant.iosGlass) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(containerRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: containerContent,
        ),
      );
    }

    return containerContent;
  }
}
