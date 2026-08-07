import 'package:flutter/material.dart';
import 'pp_skeleton_item.dart';

class PPSkeleton extends StatefulWidget {
  final bool loading;
  final bool animated;
  final int rows;
  final Widget child;
  final Widget? skeleton; // Custom skeleton template

  const PPSkeleton({
    Key? key,
    required this.child,
    this.loading = true,
    this.animated = true,
    this.rows = 3,
    this.skeleton,
  }) : super(key: key);

  @override
  State<PPSkeleton> createState() => _PPSkeletonState();
}

class _PPSkeletonState extends State<PPSkeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (widget.loading && widget.animated) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(PPSkeleton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading && widget.animated) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFallbackSkeleton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.rows,
        (index) => const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: PPSkeletonItem(variant: PPSkeletonVariant.text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.loading) {
      return widget.child;
    }

    final skeletonWidget = widget.skeleton ?? _buildFallbackSkeleton();

    if (!widget.animated) {
      return skeletonWidget;
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: const [
                Color(0x00FFFFFF),
                Color(0x60FFFFFF),
                Color(0x00FFFFFF),
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: const Alignment(-1.0, -0.3),
              end: const Alignment(1.0, 0.3),
              transform: _SlidingGradientTransform(slidePercent: _controller.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: skeletonWidget,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});
  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * (slidePercent * 2 - 1), 0.0, 0.0);
  }
}
