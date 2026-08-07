import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPCarouselDemo extends StatelessWidget {
  const _PPCarouselDemo();

  Widget _buildDemoSection(String title, Widget carousel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        Container(
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: carousel,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSlide(Color color, String text) {
    return PPCarouselItem(
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDemoSection(
          'Standard Variant (Autoplay & Loop)',
          PPCarousel(
            autoplay: true,
            loop: true,
            children: [
              _buildSlide(Colors.blue, 'Slide 1'),
              _buildSlide(Colors.green, 'Slide 2'),
              _buildSlide(Colors.orange, 'Slide 3'),
              _buildSlide(Colors.purple, 'Slide 4'),
            ],
          ),
        ),

        _buildDemoSection(
          'Multiple Items Per View (Gap = 16)',
          PPCarousel(
            itemsPerView: 2,
            gap: 16,
            loop: true,
            children: [
              _buildSlide(Colors.red.shade400, 'Item 1'),
              _buildSlide(Colors.blue.shade400, 'Item 2'),
              _buildSlide(Colors.green.shade400, 'Item 3'),
              _buildSlide(Colors.orange.shade400, 'Item 4'),
              _buildSlide(Colors.purple.shade400, 'Item 5'),
            ],
          ),
        ),

        _buildDemoSection(
          'Story Variant (Instagram style)',
          PPCarousel(
            variant: PPCarouselVariant.story,
            autoplay: true,
            interval: 4000,
            children: [
              _buildSlide(Colors.pink, 'Story 1\\n(Tap left/right or wait)'),
              _buildSlide(Colors.indigo, 'Story 2\\n(Hover to pause)'),
              _buildSlide(Colors.teal, 'Story 3\\n(Progress bar above)'),
            ],
          ),
        ),

        _buildDemoSection(
          'Reel Variant (Vertical Scrolling)',
          PPCarousel(
            variant: PPCarouselVariant.reel,
            loop: true,
            children: [
              _buildSlide(Colors.deepOrange, 'Reel 1\\n(Scroll vertically)'),
              _buildSlide(Colors.deepPurple, 'Reel 2\\n(Snaps automatically)'),
              _buildSlide(Colors.brown, 'Reel 3'),
            ],
          ),
        ),
      ],
    );
  }
}

final ComponentItem pp_carouselData = ComponentItem(
  name: 'PPCarousel',
  description: 'A flexible carousel component supporting multiple variants including standard sliders, multi-item views, vertical reels, and Instagram-style stories.',
  demoCode: '''PPCarousel(
  autoplay: true,
  loop: true,
  interval: 3000,
  variant: PPCarouselVariant.standard,
  children: [
    PPCarouselItem(child: Image.network('...')),
    PPCarouselItem(child: Image.network('...')),
  ],
);''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: _PPCarouselDemo(),
    );
  },
);
