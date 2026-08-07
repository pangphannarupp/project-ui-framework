import 'package:flutter/material.dart';

class PPFabAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? backgroundColor;

  const PPFabAction({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 56,
            child: Center(
              child: FloatingActionButton(
                heroTag: null,
                mini: true,
                backgroundColor: backgroundColor ?? Colors.white,
                foregroundColor: color ?? Theme.of(context).primaryColor,
                elevation: 4,
                onPressed: onPressed,
                child: Icon(icon, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
