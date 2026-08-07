import 'package:flutter/material.dart';
import 'dart:math' as math;

class PPCollapsingToolbar extends StatelessWidget {
  final String title;
  final Widget? background;
  final Widget? profile;
  final Widget body;
  final double expandedHeight;
  final double collapsedHeight;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitleOnCollapse;
  final Color? backgroundColor;

  const PPCollapsingToolbar({
    super.key,
    required this.title,
    this.background,
    this.profile,
    required this.body,
    this.expandedHeight = 250.0,
    this.collapsedHeight = 56.0,
    this.actions,
    this.leading,
    this.centerTitleOnCollapse = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.of(context).padding.top;
    final totalExpandedHeight = expandedHeight + safeAreaTop;
    final totalCollapsedHeight = collapsedHeight + safeAreaTop;

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: _PPCollapsingToolbarDelegate(
              title: title,
              background: background,
              profile: profile,
              expandedHeight: totalExpandedHeight,
              collapsedHeight: totalCollapsedHeight,
              safeAreaTop: safeAreaTop,
              actions: actions,
              leading: leading,
              centerTitleOnCollapse: centerTitleOnCollapse,
              backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
            ),
          ),
        ];
      },
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: body,
        ),
      ),
    );
  }
}

class _PPCollapsingToolbarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Widget? background;
  final Widget? profile;
  final double expandedHeight;
  final double collapsedHeight;
  final double safeAreaTop;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitleOnCollapse;
  final Color backgroundColor;

  _PPCollapsingToolbarDelegate({
    required this.title,
    this.background,
    this.profile,
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.safeAreaTop,
    this.actions,
    this.leading,
    required this.centerTitleOnCollapse,
    required this.backgroundColor,
  });

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final currentExtent = math.max(minExtent, maxExtent - shrinkOffset);
    final range = maxExtent - minExtent;
    final progress = range <= 0 ? 0.0 : ((currentExtent - minExtent) / range).clamp(0.0, 1.0);

    // Profile animation logic
    final profileScale = 1.0 + (1.5 * progress);
    final profileY = (maxExtent - minExtent - 64) * progress;
    
    // We want the profile X to animate from -40 (expanded) to 0 (collapsed)
    final profileX = -40 * progress;

    // Title animation logic
    final titleScale = 1.0 + (0.5 * progress);
    final titleY = (maxExtent - minExtent) * progress;
    
    // If we have a profile, when collapsed we need room for it (so X=44). When expanded, X=-40.
    final collapsedX = profile != null ? 44.0 : 0.0;
    final expandedX = -40.0;
    final titleX = collapsedX + ((expandedX - collapsedX) * progress);

    return Container(
      color: backgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background (fades out as it shrinks)
          if (background != null)
            Opacity(
              opacity: progress,
              child: background!,
            ),

          // Toolbar Layer (always at top)
          Positioned(
            top: safeAreaTop,
            left: 0,
            right: 0,
            height: collapsedHeight - safeAreaTop,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Leading
                  if (leading != null)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: leading,
                    ),

                  // Actions
                  if (actions != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!,
                      ),
                    ),

                  // Profile
                  if (profile != null)
                    Positioned(
                      left: 40, // Base offset to align with back button
                      top: 8, // Base top padding inside toolbar
                      child: Transform.translate(
                        offset: Offset(profileX, profileY),
                        child: Transform.scale(
                          scale: profileScale,
                          alignment: Alignment.centerLeft,
                          child: profile!,
                        ),
                      ),
                    ),

                  // Title
                  Positioned(
                    left: centerTitleOnCollapse ? 0 : 40,
                    right: centerTitleOnCollapse ? 0 : null,
                    top: 14, // Base top padding to vertically center text
                    child: Transform.translate(
                      offset: centerTitleOnCollapse 
                          ? Offset(0, titleY)
                          : Offset(titleX, titleY),
                      child: Transform.scale(
                        scale: titleScale,
                        alignment: centerTitleOnCollapse && progress == 0.0
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: Text(
                          title,
                          textAlign: centerTitleOnCollapse && progress == 0.0
                              ? TextAlign.center
                              : TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PPCollapsingToolbarDelegate oldDelegate) {
    return title != oldDelegate.title ||
        background != oldDelegate.background ||
        profile != oldDelegate.profile ||
        expandedHeight != oldDelegate.expandedHeight ||
        collapsedHeight != oldDelegate.collapsedHeight ||
        safeAreaTop != oldDelegate.safeAreaTop ||
        centerTitleOnCollapse != oldDelegate.centerTitleOnCollapse ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
