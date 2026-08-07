import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cross_file/cross_file.dart';
import '../../models/component_item.dart';

final ComponentItem pp_skeletonData = ComponentItem(
    name: 'PPSkeleton',
    description: 'Displays a placeholder skeleton to indicate loading state.',
    demoCode: '''PPSkeleton(
  loading: true,
  animated: true,
  rows: 3,
  child: Text('Loaded Content!'),
)''',
    demoBuilder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default (3 rows, animated)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const PPSkeleton(
              loading: true,
              child: SizedBox(),
            ),
            const SizedBox(height: 32),
            const Text('Custom Skeleton Template', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            PPSkeleton(
              loading: true,
              skeleton: Row(
                children: [
                  const PPSkeletonItem(variant: PPSkeletonVariant.circle),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        PPSkeletonItem(variant: PPSkeletonVariant.text, width: 120),
                        SizedBox(height: 8),
                        PPSkeletonItem(variant: PPSkeletonVariant.text),
                      ],
                    ),
                  ),
                ],
              ),
              child: const SizedBox(),
            ),
            const SizedBox(height: 32),
            const Text('Image & Rect Variants', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            PPSkeleton(
              loading: true,
              skeleton: Column(
                children: const [
                  PPSkeletonItem(variant: PPSkeletonVariant.image),
                  SizedBox(height: 16),
                  PPSkeletonItem(variant: PPSkeletonVariant.rect, height: 40),
                ],
              ),
              child: const SizedBox(),
            ),
          ],
        ),
      );
    },
  );


