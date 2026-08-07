import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPDataDisplayDemo extends StatelessWidget {
  const _PPDataDisplayDemo();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Avatars', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              const PPAvatar(name: 'John Doe', size: PPAvatarSize.sm),
              const SizedBox(width: 8),
              const PPAvatar(name: 'Jane Smith'),
              const SizedBox(width: 8),
              const PPAvatar(icon: Icons.person, size: PPAvatarSize.lg),
              const SizedBox(width: 8),
              const PPAvatar(
                src: 'https://i.pravatar.cc/150?img=1',
                size: PPAvatarSize.xl,
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Avatar Groups', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          PPAvatarGroup(
            items: [
              PPAvatarGroupItem(src: 'https://i.pravatar.cc/150?img=1'),
              PPAvatarGroupItem(src: 'https://i.pravatar.cc/150?img=2'),
              PPAvatarGroupItem(src: 'https://i.pravatar.cc/150?img=3'),
              PPAvatarGroupItem(src: 'https://i.pravatar.cc/150?img=4'),
              PPAvatarGroupItem(src: 'https://i.pravatar.cc/150?img=5'),
            ],
            max: 3,
            size: PPAvatarSize.lg,
          ),

          const SizedBox(height: 48),

          const Text('Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              PPBadge(
                value: '5',
                color: PPBadgeColor.danger,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.notifications),
                ),
              ),
              const SizedBox(width: 24),
              PPBadge(
                value: '99',
                max: 9,
                color: PPBadgeColor.primary,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.message),
                ),
              ),
              const SizedBox(width: 24),
              PPBadge(
                dot: true,
                color: PPBadgeColor.success,
                child: const PPAvatar(src: 'https://i.pravatar.cc/150?img=2'),
              ),
            ],
          ),

          const SizedBox(height: 48),

          const Text('Chips', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const PPChip(label: 'Default'),
              const PPChip(label: 'Primary', color: PPChipColor.primary),
              const PPChip(label: 'Success', color: PPChipColor.success, variant: PPChipVariant.outline),
              const PPChip(label: 'Warning', color: PPChipColor.warning, variant: PPChipVariant.soft),
              PPChip(
                label: 'Closable', 
                color: PPChipColor.danger, 
                closable: true,
                onClose: () {},
              ),
              const PPChip(
                label: 'With Icon',
                color: PPChipColor.info,
                icon: Icon(Icons.star),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final ComponentItem pp_data_displayData = ComponentItem(
  name: 'Avatar, Badge & Chip',
  description: 'Components used to display user avatars, status badges, and interactive chips.',
  demoCode: '''// Avatar
PPAvatar(name: 'John Doe')

// Avatar Group
PPAvatarGroup(
  items: [PPAvatarGroupItem(src: 'url')],
  max: 3,
)

// Badge
PPBadge(
  value: '5',
  child: Icon(Icons.notifications),
)

// Chip
PPChip(
  label: 'Success',
  color: PPChipColor.success,
  variant: PPChipVariant.soft,
)''',
  demoBuilder: (context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: _PPDataDisplayDemo(),
    );
  },
);
