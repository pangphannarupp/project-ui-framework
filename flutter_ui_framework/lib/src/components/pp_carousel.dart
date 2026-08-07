import 'package:flutter/material.dart';
import 'dart:async';

enum PPCarouselVariant { standard, story, reel }

class PPCarousel extends StatefulWidget {
  final List<Widget> children;
  final bool autoplay;
  final int interval;
  final bool showArrows;
  final bool showDots;
  final int itemsPerView;
  final double gap;
  final bool loop;
  final PPCarouselVariant variant;

  const PPCarousel({
    super.key,
    required this.children,
    this.autoplay = false,
    this.interval = 3000,
    this.showArrows = true,
    this.showDots = true,
    this.itemsPerView = 1,
    this.gap = 16.0,
    this.loop = false,
    this.variant = PPCarouselVariant.standard,
  });

  @override
  State<PPCarousel> createState() => _PPCarouselState();
}

class _PPCarouselState extends State<PPCarousel> {
  late PageController _pageController;
  late int _currentIndex;
  Timer? _autoplayTimer;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    double viewportFraction = 1.0;
    if (widget.variant != PPCarouselVariant.story && widget.variant != PPCarouselVariant.reel) {
      viewportFraction = 1 / widget.itemsPerView;
    }
    
    _currentIndex = widget.loop ? widget.children.length * 100 : 0;
    
    _pageController = PageController(
      viewportFraction: viewportFraction,
      initialPage: _currentIndex,
    );

    if (widget.autoplay && widget.variant != PPCarouselVariant.story) {
      _startAutoplay();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoplayTimer?.cancel();
    super.dispose();
  }

  void _startAutoplay() {
    _autoplayTimer?.cancel();
    if (!widget.autoplay || _isHovered || widget.variant == PPCarouselVariant.story) return;
    
    _autoplayTimer = Timer.periodic(Duration(milliseconds: widget.interval), (timer) {
      if (_pageController.hasClients) {
        if (!widget.loop && _currentIndex >= widget.children.length - 1) {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _stopAutoplay() {
    _autoplayTimer?.cancel();
  }

  int get _realIndex {
    if (widget.children.isEmpty) return 0;
    if (widget.loop) {
      return _currentIndex % widget.children.length;
    }
    return _currentIndex;
  }

  int get _totalDots {
    if (widget.children.length <= widget.itemsPerView) return 0;
    return (widget.children.length / widget.itemsPerView).ceil();
  }

  int get _activeDotIndex {
    if (widget.itemsPerView == 1) return _realIndex;
    return (_realIndex / widget.itemsPerView).floor();
  }

  void _goToDot(int dotIndex) {
    int targetItemIndex = dotIndex * widget.itemsPerView;
    if (targetItemIndex >= widget.children.length) {
      targetItemIndex = widget.children.length - 1;
    }
    
    int pageDiff = targetItemIndex - _realIndex;
    int targetPage = _currentIndex + pageDiff;
    
    _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _next() {
    if (!widget.loop && _currentIndex >= widget.children.length - 1) return;
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _prev() {
    if (!widget.loop && _currentIndex <= 0) return;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final realIndex = widget.loop ? index % widget.children.length : index;
    Widget child = widget.children[realIndex];

    if (widget.variant == PPCarouselVariant.standard && widget.itemsPerView > 1) {
      // Add gap using padding
      child = Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.gap / 2),
        child: child,
      );
    }

    return child;
  }

  Widget _buildArrows() {
    if (!widget.showArrows || widget.variant == PPCarouselVariant.story || widget.variant == PPCarouselVariant.reel) {
      return const SizedBox.shrink();
    }

    return Positioned.fill(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: _ArrowButton(
              icon: Icons.chevron_left,
              onTap: _prev,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _ArrowButton(
              icon: Icons.chevron_right,
              onTap: _next,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    if (!widget.showDots || widget.variant == PPCarouselVariant.story || _totalDots <= 1) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_totalDots, (index) {
          final isActive = index == _activeDotIndex;
          return GestureDetector(
            onTap: () => _goToDot(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF003399) : const Color(0xFFD1D5DB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStoryOverlay() {
    if (widget.variant != PPCarouselVariant.story) return const SizedBox.shrink();

    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: 8,
            left: 8,
            right: 8,
            child: Row(
              children: List.generate(widget.children.length, (index) {
                bool isCompleted = index < _realIndex;
                bool isActive = index == _realIndex;
                
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: isActive && widget.autoplay && !_isHovered
                          ? TweenAnimationBuilder<double>(
                              key: ValueKey('story-\$index-\$_currentIndex'), // Force rebuild
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: Duration(milliseconds: widget.interval),
                              builder: (context, value, child) {
                                return FractionallySizedBox(
                                  widthFactor: value,
                                  child: child,
                                );
                              },
                              onEnd: _next,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            )
                          : FractionallySizedBox(
                              widthFactor: isCompleted ? 1.0 : 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _prev,
                  behavior: HitTestBehavior.opaque,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: _next,
                  behavior: HitTestBehavior.opaque,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) return const SizedBox.shrink();

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _stopAutoplay();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _startAutoplay();
      },
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: widget.variant == PPCarouselVariant.reel ? Axis.vertical : Axis.horizontal,
            itemCount: widget.loop ? null : widget.children.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: _buildItem,
          ),
          _buildArrows(),
          _buildDots(),
          _buildStoryOverlay(),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ArrowButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.9),
      shape: const CircleBorder(
        side: BorderSide(color: Color(0xFFEAEAEA)),
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        hoverColor: Colors.white,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Icon(icon, color: const Color(0xFF333333), size: 24),
        ),
      ),
    );
  }
}

class PPCarouselItem extends StatelessWidget {
  final Widget child;

  const PPCarouselItem({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
