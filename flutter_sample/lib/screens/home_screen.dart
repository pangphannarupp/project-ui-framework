import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'component_detail_screen.dart';
import '../data/component_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedMenu = 'PPButton';
  List<String> _expandedGroups = ['Elements'];
  final TextEditingController _searchController = TextEditingController();

  List<PPSidebarGroup> _getSidebarItems(String query) {
    final allItems = [
      PPSidebarItem(
        id: 'Getting Started',
        label: 'Getting Started',
        icon: Icons.rocket_launch_outlined,
        children: [
          PPSidebarItem(id: 'Installation', label: 'Installation & Usage'),
        ],
      ),
      PPSidebarItem(
        id: 'Data Display',
        label: 'Data Display',
        icon: Icons.dataset_outlined,
        children: [
          PPSidebarItem(id: 'Avatar, Badge & Chip', label: 'Avatar, Badge, Chip'),
        ],
      ),
      PPSidebarItem(
        id: 'Elements',
        label: 'Elements',
        icon: Icons.widgets_outlined,
        children: [
          PPSidebarItem(id: 'PPButton', label: 'Button'),
          PPSidebarItem(id: 'PPButtonGroup', label: 'Button Group'),
          PPSidebarItem(id: 'PPToggleButton', label: 'Toggle Button'),
          PPSidebarItem(id: 'PPIconButton', label: 'Icon Button'),
          PPSidebarItem(id: 'Icons Collection', label: 'Icons Collection'),
          PPSidebarItem(id: 'PPGrid', label: 'Grid/List Layout'),
          PPSidebarItem(id: 'PPTree', label: 'Tree View'),
          PPSidebarItem(id: 'PPKanbanBoard', label: 'Kanban Board'),
          PPSidebarItem(id: 'PPPullToRefresh', label: 'Pull to Refresh'),
          PPSidebarItem(id: 'PPSwipeItem', label: 'Swipe Actions'),
          PPSidebarItem(id: 'PPSelect', label: 'Select'),
          PPSidebarItem(id: 'PPCollapse', label: 'Collapse / Accordion'),
          PPSidebarItem(id: 'PPCarousel', label: 'Carousel'),
          PPSidebarItem(id: 'PPFab', label: 'Floating Action Button'),
        ],
      ),
      PPSidebarItem(
        id: 'Forms',
        label: 'Forms',
        icon: Icons.text_snippet_outlined,
        children: [
          PPSidebarItem(id: 'PPSearch', label: 'Search Input'),
          PPSidebarItem(id: 'PPInput', label: 'Text Input & Textarea'),
          PPSidebarItem(id: 'PPPhoneInput', label: 'Phone Input'),
          PPSidebarItem(id: 'PPAutocomplete', label: 'Autocomplete'),
          PPSidebarItem(id: 'PPNumberSpinner', label: 'Number Spinner'),
          PPSidebarItem(id: 'PPRating', label: 'Rating Stars'),
          PPSidebarItem(id: 'PPCheckbox', label: 'Checkbox & Group'),
          PPSidebarItem(id: 'PPRadio', label: 'Radio & Group'),
          PPSidebarItem(id: 'PPSwitch', label: 'Switch Toggle'),
          PPSidebarItem(id: 'PPSlider', label: 'Slider & Range'),
          PPSidebarItem(id: 'PPTransferList', label: 'Transfer List'),
          PPSidebarItem(id: 'PPFileUpload', label: 'File Upload'),
          PPSidebarItem(id: 'PPOtpInput', label: 'OTP Input'),
          PPSidebarItem(id: 'PPPinDots & Keypad', label: 'PIN & Security'),
          PPSidebarItem(id: 'Secure & Khmer Keyboards', label: 'Keyboards'),
          PPSidebarItem(id: 'PPSignaturePad', label: 'Signature Pad'),
        ],
      ),
      PPSidebarItem(
        id: 'Feedback',
        label: 'Feedback',
        icon: Icons.chat_bubble_outline,
        children: [
          PPSidebarItem(id: 'PPSkeleton', label: 'Skeleton'),
          PPSidebarItem(id: 'PPDialog', label: 'Dialog'),
          PPSidebarItem(id: 'Progress & Activity', label: 'Progress, Activity'),
          PPSidebarItem(id: 'Charts', label: 'Charts & Graphs', icon: Icons.bar_chart),
        ],
      ),
      PPSidebarItem(
        id: 'Surfaces',
        label: 'Surfaces',
        icon: Icons.layers_outlined,
        children: [
          PPSidebarItem(id: 'PPInfoCard', label: 'Info Card'),
          PPSidebarItem(id: 'PPBottomSheet', label: 'Bottom Sheet'),
          PPSidebarItem(id: 'PPScrollArea', label: 'Scroll Area'),
        ],
      ),
      PPSidebarItem(
        id: 'Pickers',
        label: 'Pickers',
        icon: Icons.calendar_month_outlined,
        children: [
          PPSidebarItem(id: 'PPCalendar', label: 'Calendar'),
          PPSidebarItem(id: 'PPKhmerCalendar', label: 'Khmer Calendar'),
          PPSidebarItem(id: 'PPCalendarBottomSheet', label: 'Calendar (Bottom Sheet)'),
          PPSidebarItem(id: 'PPKhmerCalendarBottomSheet', label: 'Khmer Calendar (Bottom Sheet)'),
          PPSidebarItem(id: 'PPCalendarDialog', label: 'Calendar (Dialog)'),
          PPSidebarItem(id: 'PPKhmerCalendarDialog', label: 'Khmer Calendar (Dialog)'),
          PPSidebarItem(id: 'PPCalendarPicker', label: 'Calendar Picker'),
          PPSidebarItem(id: 'PPKhmerCalendarPicker', label: 'Khmer Calendar Picker'),
          PPSidebarItem(id: 'PPColorPicker', label: 'Color Picker'),
          PPSidebarItem(id: 'PPPicker', label: 'Picker'),
          PPSidebarItem(id: 'Date & Time Pickers', label: 'Date & Time Pickers'),
        ],
      ),
      PPSidebarItem(
        id: 'Navigation',
        label: 'Navigation',
        icon: Icons.navigation_outlined,
        children: [
          PPSidebarItem(id: 'PPBreadcrumb', label: 'Breadcrumb'),
          PPSidebarItem(id: 'PPStepper', label: 'Stepper'),
          PPSidebarItem(id: 'PPDropdown', label: 'Dropdown Menu'),
          PPSidebarItem(id: 'PPSidebarNavigation', label: 'Sidebar Navigation'),
          PPSidebarItem(id: 'PPBottomNav', label: 'Bottom Navigation'),
          PPSidebarItem(id: 'PPRibbon', label: 'Ribbon Menu'),
          PPSidebarItem(id: 'PPTabs', label: 'Tabs'),
          PPSidebarItem(id: 'PPSegment', label: 'Segments'),
          PPSidebarItem(id: 'PPScrollSegment', label: 'Scroll Segments'),
          PPSidebarItem(id: 'PPContextMenu', label: 'Context Menu'),
          PPSidebarItem(id: 'PPHideAppBar', label: 'Hide App Bar (Scroll)'),
          PPSidebarItem(id: 'PPCollapsingToolbar', label: 'Collapsing App Bar'),
        ],
      ),
    ];

    if (query.isEmpty) {
      return [PPSidebarGroup(items: allItems)];
    }

    final filteredItems = <PPSidebarItem>[];
    for (final item in allItems) {
      if (item.label.toLowerCase().contains(query)) {
        filteredItems.add(item);
      } else {
        final matchingChildren = item.children
            ?.where((child) =>
                child.label.toLowerCase().contains(query) ||
                child.id.toLowerCase().contains(query))
            .toList();
        if (matchingChildren != null && matchingChildren.isNotEmpty) {
          filteredItems.add(
            PPSidebarItem(
              id: item.id,
              label: item.label,
              icon: item.icon,
              children: matchingChildren,
            ),
          );
        }
      }
    }
    return [PPSidebarGroup(items: filteredItems)];
  }

  Widget _buildMainContent() {
    return ComponentDetailScreen(
      key: ValueKey(_selectedMenu),
      componentName: _selectedMenu,
    );
  }

  Widget _buildSidebar(bool isMobile) {
    final query = _searchController.text.toLowerCase();
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PPSearch(
            value: _searchController.text,
            placeholder: 'Search components...',
            onChanged: (value) {
              setState(() {
                _searchController.text = value;
                if (value.isNotEmpty) {
                  // Auto-expand all groups when searching
                  _expandedGroups = ['Getting Started', 'Elements', 'Forms', 'Surfaces', 'Pickers', 'Navigation'];
                } else {
                  // Reset to default expansion when cleared
                  _expandedGroups = ['Elements'];
                }
              });
            },
          ),
        ),
        Expanded(
          child: PPSidebarNavigation(
            modelValue: _selectedMenu,
            expandedItems: _expandedGroups,
            onModelValueChanged: (value) {
              setState(() {
                _selectedMenu = value;
              });
              if (isMobile) {
                Navigator.pop(context);
              }
            },
            onExpandedItemsChanged: (value) {
              setState(() {
                _expandedGroups = value;
              });
            },
            theme: 'light',
            variant: 'pill',
            width: 280,
            items: _getSidebarItems(query),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Full Component Catalog'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1,
            ),
            body: Row(
              children: [
                SizedBox(
                  width: 280,
                  child: _buildSidebar(false),
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(
                  child: _buildMainContent(),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Full Component Catalog'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 1,
            ),
            body: _buildMainContent(),
            drawer: Drawer(
              child: SafeArea(
                child: _buildSidebar(true),
              ),
            ),
          );
        }
      },
    );
  }
}
