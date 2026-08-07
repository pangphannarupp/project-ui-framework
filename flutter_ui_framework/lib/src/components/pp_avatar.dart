import 'package:flutter/material.dart';

enum PPAvatarSize { xs, sm, md, lg, xl }
enum PPAvatarShape { circle, square, rounded }

class PPAvatar extends StatelessWidget {
  final String? src;
  final String? name;
  final IconData? icon;
  final PPAvatarSize size;
  final PPAvatarShape shape;
  final Color? bgColor;
  final Color? textColor;
  final bool hasBorder;

  const PPAvatar({
    super.key,
    this.src,
    this.name,
    this.icon,
    this.size = PPAvatarSize.md,
    this.shape = PPAvatarShape.circle,
    this.bgColor,
    this.textColor,
    this.hasBorder = false,
  });

  double get _sizeDimension {
    switch (size) {
      case PPAvatarSize.xs: return 24.0;
      case PPAvatarSize.sm: return 32.0;
      case PPAvatarSize.md: return 40.0;
      case PPAvatarSize.lg: return 56.0;
      case PPAvatarSize.xl: return 72.0;
    }
  }

  double get _fontSize {
    switch (size) {
      case PPAvatarSize.xs: return 10.0;
      case PPAvatarSize.sm: return 12.0;
      case PPAvatarSize.md: return 14.0;
      case PPAvatarSize.lg: return 18.0;
      case PPAvatarSize.xl: return 24.0;
    }
  }

  BorderRadius get _borderRadius {
    switch (shape) {
      case PPAvatarShape.circle: return BorderRadius.circular(9999);
      case PPAvatarShape.square: return BorderRadius.zero;
      case PPAvatarShape.rounded: return BorderRadius.circular(8);
    }
  }

  String get _initials {
    if (name != null && name!.isNotEmpty) {
      final parts = name!.split(' ').where((p) => p.isNotEmpty).toList();
      if (parts.length >= 2) {
        return (parts[0][0] + parts[1][0]).toUpperCase();
      } else if (parts.length == 1) {
        return parts[0].length >= 2 
            ? parts[0].substring(0, 2).toUpperCase() 
            : parts[0][0].toUpperCase();
      }
    }
    return '?';
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (src != null) {
      content = Image.network(
        src!,
        width: _sizeDimension,
        height: _sizeDimension,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildFallback(),
      );
    } else if (icon != null) {
      content = Icon(
        icon,
        size: _fontSize * 1.5,
        color: textColor ?? const Color(0xFF475569),
      );
    } else {
      content = _buildFallback();
    }

    return Container(
      width: _sizeDimension,
      height: _sizeDimension,
      decoration: BoxDecoration(
        color: bgColor ?? const Color(0xFFCBD5E1),
        borderRadius: _borderRadius,
        border: hasBorder ? Border.all(color: Colors.white, width: 2) : null,
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: content,
    );
  }

  Widget _buildFallback() {
    return Text(
      _initials,
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.w600,
        color: textColor ?? const Color(0xFF475569),
      ),
    );
  }
}

class PPAvatarGroupItem {
  final String? src;
  final String? name;
  final IconData? icon;
  final Color? bgColor;
  final Color? textColor;

  PPAvatarGroupItem({
    this.src,
    this.name,
    this.icon,
    this.bgColor,
    this.textColor,
  });
}

class PPAvatarGroup extends StatelessWidget {
  final List<PPAvatarGroupItem> items;
  final int max;
  final PPAvatarSize size;
  final PPAvatarShape shape;

  const PPAvatarGroup({
    super.key,
    required this.items,
    this.max = 4,
    this.size = PPAvatarSize.md,
    this.shape = PPAvatarShape.circle,
  });

  double get _overlap {
    switch (size) {
      case PPAvatarSize.xs: return -8.0;
      case PPAvatarSize.sm: return -12.0;
      case PPAvatarSize.md: return -16.0;
      case PPAvatarSize.lg: return -20.0;
      case PPAvatarSize.xl: return -24.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = items.take(max).toList();
    final overflowCount = items.length - visibleItems.length;

    List<Widget> avatars = [];

    for (int i = 0; i < visibleItems.length; i++) {
      final item = visibleItems[i];
      avatars.add(
        Positioned(
          left: i == 0 ? 0 : i * (_getDimension() + _overlap),
          child: PPAvatar(
            src: item.src,
            name: item.name,
            icon: item.icon,
            bgColor: item.bgColor,
            textColor: item.textColor,
            size: size,
            shape: shape,
            hasBorder: true,
          ),
        ),
      );
    }

    if (overflowCount > 0) {
      avatars.add(
        Positioned(
          left: visibleItems.length * (_getDimension() + _overlap),
          child: PPAvatar(
            name: '+$overflowCount',
            bgColor: const Color(0xFFE2E8F0),
            textColor: const Color(0xFF475569),
            size: size,
            shape: shape,
            hasBorder: true,
          ),
        ),
      );
    }

    double totalWidth = _getDimension();
    if (visibleItems.length > 1) {
      totalWidth += (visibleItems.length - 1) * (_getDimension() + _overlap);
    }
    if (overflowCount > 0) {
      totalWidth += (_getDimension() + _overlap);
    }

    return SizedBox(
      width: totalWidth,
      height: _getDimension(),
      child: Stack(
        clipBehavior: Clip.none,
        children: avatars,
      ),
    );
  }

  double _getDimension() {
    switch (size) {
      case PPAvatarSize.xs: return 24.0;
      case PPAvatarSize.sm: return 32.0;
      case PPAvatarSize.md: return 40.0;
      case PPAvatarSize.lg: return 56.0;
      case PPAvatarSize.xl: return 72.0;
    }
  }
}
