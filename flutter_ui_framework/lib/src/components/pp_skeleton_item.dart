import 'package:flutter/material.dart';

enum PPSkeletonVariant { text, rect, circle, image }

class PPSkeletonItem extends StatelessWidget {
  final PPSkeletonVariant variant;
  final double? width;
  final double? height;
  final Color baseColor;

  const PPSkeletonItem({
    Key? key,
    this.variant = PPSkeletonVariant.text,
    this.width,
    this.height,
    this.baseColor = const Color(0xFFF0F0F0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = width ?? double.infinity;
    double h = height ?? 16.0;
    BorderRadiusGeometry? br;

    switch (variant) {
      case PPSkeletonVariant.text:
        h = height ?? 16.0;
        br = BorderRadius.circular(4.0);
        break;
      case PPSkeletonVariant.rect:
        w = width ?? double.infinity;
        h = height ?? double.infinity;
        br = BorderRadius.circular(8.0);
        break;
      case PPSkeletonVariant.circle:
        w = width ?? 48.0;
        h = height ?? 48.0;
        br = BorderRadius.circular(w / 2);
        break;
      case PPSkeletonVariant.image:
        w = width ?? double.infinity;
        h = height ?? 200.0;
        br = BorderRadius.zero;
        break;
    }

    return Container(
      width: w == double.infinity ? null : w,
      height: h == double.infinity ? null : h,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: br,
      ),
    );
  }
}
