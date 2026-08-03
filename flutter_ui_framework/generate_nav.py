import os

dart_code = """import 'package:flutter/material.dart';

class PPBottomNavItem {
  final String label;
  final String value;
  final IconData icon;
  final IconData? activeIcon;
  final bool isAction;

  const PPBottomNavItem({
    required this.label,
    required this.value,
    required this.icon,
    this.activeIcon,
    this.isAction = false,
  });
}

class PPBottomNav extends StatelessWidget {
  final String value;
  final List<PPBottomNavItem> items;
  final ValueChanged<String> onChanged;
  final String variant; // 'material', 'classic', 'floating', 'shift', 'dot', 'bubble', 'magic-line', 'curved', 'pill-slide', 'cutout'
  final Color primaryColor;

  const PPBottomNav({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.variant = 'material',
    this.primaryColor = const Color(0xFF007AFF),
  });

  int get activeIndex => items.indexWhere((i) => i.value == value) != -1 ? items.indexWhere((i) => i.value == value) : 0;

  @override
  Widget build(BuildContext context) {
    if (variant == 'floating') return _buildFloating(context);
    if (variant == 'shift') return _buildShift(context);
    if (variant == 'bubble') return _buildBubble(context);
    if (variant == 'classic') return _buildClassic(context);
    if (variant == 'dot') return _buildDot(context);
    if (variant == 'magic-line') return _buildMagicLine(context);
    if (variant == 'curved') return _buildCurved(context);
    if (variant == 'pill-slide') return _buildPillSlide(context);
    if (variant == 'cutout') return _buildCutout(context);
    
    return _buildMaterial(context);
  }

  // Helper for sliding indicator variants
  Widget _buildWithSlidingIndicator({
    required BuildContext context,
    required double height,
    required Color bgColor,
    required Widget indicator,
    required Widget Function(PPBottomNavItem item, bool isActive) buildItem,
    Alignment indicatorAlignment = Alignment.topCenter,
    double shadowRadius = 10,
    double? customWidth,
    BorderRadius? borderRadius,
  }) {
    return _buildBaseContainer(
      context: context,
      height: height,
      color: bgColor,
      shadowRadius: shadowRadius,
      borderRadius: borderRadius,
      width: customWidth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / items.length;
          return Stack(
            children: [
              // Sliding Indicator
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastLinearToSlowEaseIn,
                left: itemWidth * activeIndex,
                top: 0,
                bottom: 0,
                width: itemWidth,
                child: Align(
                  alignment: indicatorAlignment,
                  child: indicator,
                ),
              ),
              // Items
              Row(
                children: items.map((item) {
                  final isActive = item.value == value;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onChanged(item.value),
                      child: buildItem(item, isActive),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }

  // --- VARIANTS ---

  Widget _buildMaterial(BuildContext context) {
    return _buildBaseContainer(
      context: context,
      height: 80,
      color: const Color(0xFFF4F5F8),
      child: Row(
        children: items.map((item) {
          final isActive = item.value == value;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(item.value),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 64,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFFD3E3FD) : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      isActive ? (item.activeIcon ?? item.icon) : item.icon,
                      color: isActive ? const Color(0xFF041E49) : const Color(0xFF5F6368),
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                      color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF5F6368),
                    ),
                    child: Text(item.label),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildClassic(BuildContext context) {
    return _buildBaseContainer(
      context: context,
      height: 60,
      color: Colors.white,
      shadowRadius: 10,
      child: Row(
        children: items.map((item) {
          final isActive = item.value == value;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(item.value),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isActive ? (item.activeIcon ?? item.icon) : item.icon,
                    color: isActive ? primaryColor : const Color(0xFF5F6368),
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? primaryColor : const Color(0xFF5F6368),
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

  Widget _buildFloating(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 32,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: items.map((item) {
            final isActive = item.value == value;
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onChanged(item.value),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isActive ? primaryColor.withOpacity(0.15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      border: isActive ? Border.all(color: primaryColor, width: 2) : null,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      isActive ? (item.activeIcon ?? item.icon) : item.icon,
                      color: isActive ? primaryColor : const Color(0xFF5F6368),
                      size: 24,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildShift(BuildContext context) {
    return _buildBaseContainer(
      context: context,
      height: 64,
      color: Colors.white,
      shadowRadius: 20,
      child: Row(
        children: items.map((item) {
          final isActive = item.value == value;
          return Expanded(
            flex: isActive ? 2 : 1,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(item.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                decoration: BoxDecoration(
                  color: isActive ? primaryColor.withOpacity(0.15) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isActive ? (item.activeIcon ?? item.icon) : item.icon,
                      color: isActive ? primaryColor : const Color(0xFF5F6368),
                      size: 24,
                    ),
                    if (isActive) ...[
                      const SizedBox(width: 8),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBubble(BuildContext context) {
    return _buildBaseContainer(
      context: context,
      height: 60,
      color: Colors.white,
      shadowRadius: 10,
      child: Row(
        children: items.map((item) {
          final isActive = item.value == value;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(item.value),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastLinearToSlowEaseIn,
                    top: isActive ? -12 : 6,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isActive ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: isActive ? [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ] : [],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        isActive ? (item.activeIcon ?? item.icon) : item.icon,
                        color: isActive ? Colors.white : const Color(0xFF5F6368),
                        size: 24,
                      ),
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

  Widget _buildDot(BuildContext context) {
    return _buildWithSlidingIndicator(
      context: context,
      height: 60,
      bgColor: Colors.white,
      indicatorAlignment: Alignment.bottomCenter,
      indicator: Container(
        margin: const EdgeInsets.only(bottom: 6),
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      buildItem: (item, isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(0, isActive ? -6 : 0, 0),
              child: Icon(
                isActive ? (item.activeIcon ?? item.icon) : item.icon,
                color: isActive ? primaryColor : const Color(0xFF5F6368),
                size: 24,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMagicLine(BuildContext context) {
    return _buildWithSlidingIndicator(
      context: context,
      height: 60,
      bgColor: const Color(0xFF1A1A24),
      indicatorAlignment: Alignment.topCenter,
      indicator: Container(
        width: 40,
        height: 3,
        decoration: const BoxDecoration(
          color: Color(0xFF4DA3FF),
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
          boxShadow: [BoxShadow(color: Color(0xFF007AFF), blurRadius: 10)],
        ),
      ),
      buildItem: (item, isActive) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: Matrix4.translationValues(0, isActive ? -2 : 0, 0),
              child: Icon(
                isActive ? (item.activeIcon ?? item.icon) : item.icon,
                color: isActive ? const Color(0xFF4DA3FF) : const Color(0xFF888899),
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.white : const Color(0xFF888899),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCurved(BuildContext context) {
    return _buildWithSlidingIndicator(
      context: context,
      height: 64,
      bgColor: Colors.white,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      indicatorAlignment: Alignment.topCenter,
      indicator: Container(
        margin: const EdgeInsets.only(top: 0),
        transform: Matrix4.translationValues(0, -20, 0),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFF9F9FC), width: 6),
          boxShadow: [
            BoxShadow(color: primaryColor.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 8)),
          ],
        ),
      ),
      buildItem: (item, isActive) {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastLinearToSlowEaseIn,
              top: isActive ? -12 : 20,
              child: Icon(
                isActive ? (item.activeIcon ?? item.icon) : item.icon,
                color: isActive ? Colors.white : const Color(0xFF5F6368),
                size: 24,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPillSlide(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFEEF0F4),
          borderRadius: BorderRadius.circular(28),
        ),
        padding: const EdgeInsets.all(4),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / items.length;
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  left: itemWidth * activeIndex,
                  top: 0,
                  bottom: 0,
                  width: itemWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2)),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: items.map((item) {
                    final isActive = item.value == value;
                    return Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => onChanged(item.value),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isActive ? (item.activeIcon ?? item.icon) : item.icon,
                              color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF8C939D),
                              size: 20,
                            ),
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF8C939D),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCutout(BuildContext context) {
    return _buildBaseContainer(
      context: context,
      height: 90,
      color: Colors.transparent, // We draw custom background
      shadowRadius: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background cutout imitation
          Positioned(
            top: 10, left: 0, right: 0, bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -4))],
              ),
            ),
          ),
          // Items
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: items.map((item) {
              final isActive = item.value == value;
              final isAction = item.isAction;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(item.value),
                  child: Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: isAction 
                      ? Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              top: -32,
                              child: Container(
                                width: 64, height: 64,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.4), blurRadius: 16, offset: const Offset(0, 6))],
                                ),
                                child: Icon(item.icon, color: Colors.white, size: 28),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text(item.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(isActive ? (item.activeIcon ?? item.icon) : item.icon, color: isActive ? primaryColor : const Color(0xFF5F6368), size: 24),
                            const SizedBox(height: 4),
                            Text(item.label, style: TextStyle(fontSize: 12, color: isActive ? primaryColor : const Color(0xFF5F6368), fontWeight: isActive ? FontWeight.w600 : FontWeight.w500)),
                          ],
                        ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBaseContainer({
    required BuildContext context,
    required double height,
    required Color color,
    required Widget child,
    double shadowRadius = 2,
    double? width,
    BorderRadius? borderRadius,
  }) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      width: width,
      height: height + bottomPadding,
      padding: EdgeInsets.only(bottom: bottomPadding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        boxShadow: shadowRadius > 0 ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: shadowRadius,
            offset: const Offset(0, -2),
          ),
        ] : [],
      ),
      child: child,
    );
  }
}
"""

with open('lib/src/components/pp_bottom_nav.dart', 'w') as f:
    f.write(dart_code)
