import 'package:flutter/material.dart';

enum PPSwitchVariant {
  standard,
  m3,
  icon,
}

class PPSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final Widget? labelWidget;
  final bool disabled;
  final PPSwitchVariant variant;

  const PPSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.label,
    this.labelWidget,
    this.disabled = false,
    this.variant = PPSwitchVariant.standard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      if (disabled || onChanged == null) return;
      onChanged!(!value);
    }

    Widget buildSwitch() {
      switch (variant) {
        case PPSwitchVariant.standard:
          return _StandardSwitch(value: value, disabled: disabled);
        case PPSwitchVariant.m3:
          return _M3Switch(value: value, disabled: disabled);
        case PPSwitchVariant.icon:
          return _IconSwitch(value: value, disabled: disabled);
      }
    }

    final switchWidget = GestureDetector(
      onTap: handleTap,
      behavior: HitTestBehavior.opaque,
      child: buildSwitch(),
    );

    if (label == null && labelWidget == null) {
      return Opacity(
        opacity: disabled ? 0.5 : 1.0,
        child: switchWidget,
      );
    }

    return Opacity(
      opacity: disabled ? 0.5 : 1.0,
      child: GestureDetector(
        onTap: handleTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (label != null || labelWidget != null) ...[
              labelWidget ??
                  Text(
                    label!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1A2A5E),
                    ),
                  ),
              const SizedBox(width: 16),
            ],
            switchWidget,
          ],
        ),
      ),
    );
  }
}

class _StandardSwitch extends StatelessWidget {
  final bool value;
  final bool disabled;

  const _StandardSwitch({required this.value, required this.disabled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 52,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: value ? const Color(0xFF003399) : const Color(0xFFE0E0E0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: value ? 22 : 2,
            right: value ? 2 : 22,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _M3Switch extends StatelessWidget {
  final bool value;
  final bool disabled;

  const _M3Switch({required this.value, required this.disabled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 52,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value ? Colors.transparent : const Color(0xFF757575),
          width: 2,
        ),
        color: value ? const Color(0xFF003399) : const Color(0xFFE0E0E0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: value ? 22 : 4,
            right: value ? 4 : 22,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: value ? 24 : 16,
              height: value ? 24 : 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value ? Colors.white : const Color(0xFF757575),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconSwitch extends StatelessWidget {
  final bool value;
  final bool disabled;

  const _IconSwitch({required this.value, required this.disabled});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 52,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: value ? const Color(0xFF003399) : const Color(0xFFE0E0E0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: value ? 22 : 2,
            right: value ? 2 : 22,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  value ? Icons.check : Icons.close,
                  size: 16,
                  color: value ? const Color(0xFF003399) : const Color(0xFF757575),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
