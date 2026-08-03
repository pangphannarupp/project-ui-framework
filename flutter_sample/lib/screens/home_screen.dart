import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  String _buildDemoCode(String name) {
    switch (name) {
      case 'PPBottomNav':
        return '''Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    PPBottomNav(variant: 'material', value: '0', ...),
    PPBottomNav(variant: 'classic', value: '0', ...),
    PPBottomNav(variant: 'floating', value: '0', ...),
    PPBottomNav(variant: 'shift', value: '0', ...),
    PPBottomNav(variant: 'bubble', value: '0', ...),
  ],
)''';
      case 'PPButton':
        return '''PPButton(
  text: 'Click Me',
  onPressed: () {},
)''';
      default:
        return 'const Placeholder(fallbackHeight: 50, fallbackWidth: 100)';
    }
  }

  void _navigateTo(BuildContext context, String componentName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      final code = _buildDemoCode(componentName);
      return Scaffold(
        appBar: AppBar(title: Text(componentName)),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Colors.grey[100],
                child: Center(child: _buildDemoComponent(componentName)),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: const Color(0xFF1E1E1E),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Usage', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.white70, size: 20),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: code));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Code copied to clipboard!')),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          code,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.greenAccent,
                            fontSize: 14,
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
    }));
  }

  Widget _buildDemoComponent(String name) {
    switch (name) {
      case 'PPBottomNav':
        final items = const [
          PPBottomNavItem(label: 'Home', value: '0', icon: Icons.home),
          PPBottomNavItem(label: 'Search', value: '1', icon: Icons.search),
          PPBottomNavItem(label: 'Settings', value: '2', icon: Icons.settings),
        ];
        final cutoutItems = const [
          PPBottomNavItem(label: 'Home', value: '0', icon: Icons.home),
          PPBottomNavItem(label: 'Add', value: '1', icon: Icons.add, isAction: true),
          PPBottomNavItem(label: 'Settings', value: '2', icon: Icons.settings),
        ];
        String selectedValue = '0';
        return StatefulBuilder(
          builder: (context, setState) {
            void handleChange(String val) {
              setState(() => selectedValue = val);
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Material Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'material'),
                  const SizedBox(height: 16),
                  const Text('Classic Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'classic'),
                  const SizedBox(height: 16),
                  const Text('Floating Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'floating'),
                  const SizedBox(height: 16),
                  const Text('Shift Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'shift'),
                  const SizedBox(height: 16),
                  const Text('Bubble Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'bubble'),
                  const SizedBox(height: 16),
                  const Text('Dot Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'dot'),
                  const SizedBox(height: 16),
                  const Text('Magic Line Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'magic-line'),
                  const SizedBox(height: 16),
                  const Text('Curved Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'curved'),
                  const SizedBox(height: 16),
                  const Text('Pill Slide Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: items, variant: 'pill-slide'),
                  const SizedBox(height: 16),
                  const Text('Cutout Variant'),
                  PPBottomNav(value: selectedValue, onChanged: handleChange, items: cutoutItems, variant: 'cutout'),
                  const SizedBox(height: 32),
                ],
              ),
            );
          },
        );
      case 'PPButton':
        return PPButton(text: 'Click Me', onPressed: () {});
      default:
        return const Placeholder(fallbackHeight: 50, fallbackWidth: 100);
    }
  }

  Widget _buildComponentList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
          ListTile(
            title: const Text('MyButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'MyButton'),
          ),
          ListTile(
            title: const Text('MyList'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'MyList'),
          ),
          ListTile(
            title: const Text('PPAccountCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAccountCard'),
          ),
          ListTile(
            title: const Text('PPAccountListCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAccountListCard'),
          ),
          ListTile(
            title: const Text('PPAccountReorderList'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAccountReorderList'),
          ),
          ListTile(
            title: const Text('PPAccountSavingCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAccountSavingCard'),
          ),
          ListTile(
            title: const Text('PPActionCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPActionCard'),
          ),
          ListTile(
            title: const Text('PPAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAlert'),
          ),
          ListTile(
            title: const Text('PPAnimatedTabs'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAnimatedTabs'),
          ),
          ListTile(
            title: const Text('PPAppBar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAppBar'),
          ),
          ListTile(
            title: const Text('PPAudioWave'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAudioWave'),
          ),
          ListTile(
            title: const Text('PPAutocomplete'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAutocomplete'),
          ),
          ListTile(
            title: const Text('PPAvatar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAvatar'),
          ),
          ListTile(
            title: const Text('PPAvatarGroup'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPAvatarGroup'),
          ),
          ListTile(
            title: const Text('PPBadge'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPBadge'),
          ),
          ListTile(
            title: const Text('PPBarChart'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPBarChart'),
          ),
          ListTile(
            title: const Text('PPBiometricSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPBiometricSheet'),
          ),
          ListTile(
            title: const Text('PPBottomBar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPBottomBar'),
          ),
          ListTile(
            title: const Text('PPBottomNav'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPBottomNav'),
          ),
          ListTile(
            title: const Text('PPBottomSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPBottomSheet'),
          ),
          ListTile(
            title: const Text('PPBreadcrumb'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPBreadcrumb'),
          ),
          ListTile(
            title: const Text('PPButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPButton'),
          ),
          ListTile(
            title: const Text('PPButtonGroup'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPButtonGroup'),
          ),
          ListTile(
            title: const Text('PPCalendar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCalendar'),
          ),
          ListTile(
            title: const Text('PPCalendarAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCalendarAlert'),
          ),
          ListTile(
            title: const Text('PPCalendarIsland'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCalendarIsland'),
          ),
          ListTile(
            title: const Text('PPCalendarSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCalendarSheet'),
          ),
          ListTile(
            title: const Text('PPCarousel'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCarousel'),
          ),
          ListTile(
            title: const Text('PPCarouselItem'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCarouselItem'),
          ),
          ListTile(
            title: const Text('PPChatItem'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPChatItem'),
          ),
          ListTile(
            title: const Text('PPCheckbox'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCheckbox'),
          ),
          ListTile(
            title: const Text('PPCheckboxGroup'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCheckboxGroup'),
          ),
          ListTile(
            title: const Text('PPChip'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPChip'),
          ),
          ListTile(
            title: const Text('PPCollapse'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCollapse'),
          ),
          ListTile(
            title: const Text('PPCollapseItem'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCollapseItem'),
          ),
          ListTile(
            title: const Text('PPCollapsingToolbar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCollapsingToolbar'),
          ),
          ListTile(
            title: const Text('PPColorPicker'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPColorPicker'),
          ),
          ListTile(
            title: const Text('PPColorPickerAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPColorPickerAlert'),
          ),
          ListTile(
            title: const Text('PPColorPickerIsland'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPColorPickerIsland'),
          ),
          ListTile(
            title: const Text('PPColorPickerSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPColorPickerSheet'),
          ),
          ListTile(
            title: const Text('PPCompanySelector'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCompanySelector'),
          ),
          ListTile(
            title: const Text('PPConfirm'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPConfirm'),
          ),
          ListTile(
            title: const Text('PPConfirmSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPConfirmSheet'),
          ),
          ListTile(
            title: const Text('PPConsole'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPConsole'),
          ),
          ListTile(
            title: const Text('PPCountryCodeSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCountryCodeSheet'),
          ),
          ListTile(
            title: const Text('PPCreditCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPCreditCard'),
          ),
          ListTile(
            title: const Text('PPDateRangePicker'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDateRangePicker'),
          ),
          ListTile(
            title: const Text('PPDateRangePickerAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDateRangePickerAlert'),
          ),
          ListTile(
            title: const Text('PPDateRangePickerSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDateRangePickerSheet'),
          ),
          ListTile(
            title: const Text('PPDivider'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDivider'),
          ),
          ListTile(
            title: const Text('PPDonutChart'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDonutChart'),
          ),
          ListTile(
            title: const Text('PPDraggableGrid'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDraggableGrid'),
          ),
          ListTile(
            title: const Text('PPDrawCanvas'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDrawCanvas'),
          ),
          ListTile(
            title: const Text('PPDropdown'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDropdown'),
          ),
          ListTile(
            title: const Text('PPDynamicIsland'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPDynamicIsland'),
          ),
          ListTile(
            title: const Text('PPEmojiKeyboard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPEmojiKeyboard'),
          ),
          ListTile(
            title: const Text('PPEnglishKeyboard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPEnglishKeyboard'),
          ),
          ListTile(
            title: const Text('PPFab'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFab'),
          ),
          ListTile(
            title: const Text('PPFabAction'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFabAction'),
          ),
          ListTile(
            title: const Text('PPFabList'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFabList'),
          ),
          ListTile(
            title: const Text('PPFeedbackSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFeedbackSheet'),
          ),
          ListTile(
            title: const Text('PPFilePreview'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFilePreview'),
          ),
          ListTile(
            title: const Text('PPFileUpload'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFileUpload'),
          ),
          ListTile(
            title: const Text('PPFilterSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFilterSheet'),
          ),
          ListTile(
            title: const Text('PPFunnelChart'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPFunnelChart'),
          ),
          ListTile(
            title: const Text('PPHeaderBar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPHeaderBar'),
          ),
          ListTile(
            title: const Text('PPHideAppBar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPHideAppBar'),
          ),
          ListTile(
            title: const Text('PPIconButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPIconButton'),
          ),
          ListTile(
            title: const Text('PPImageCropper'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPImageCropper'),
          ),
          ListTile(
            title: const Text('PPImagePreview'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPImagePreview'),
          ),
          ListTile(
            title: const Text('PPImageTransition'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPImageTransition'),
          ),
          ListTile(
            title: const Text('PPInfoCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPInfoCard'),
          ),
          ListTile(
            title: const Text('PPInput'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPInput'),
          ),
          ListTile(
            title: const Text('PPInputDialog'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPInputDialog'),
          ),
          ListTile(
            title: const Text('PPKanbanBoard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPKanbanBoard'),
          ),
          ListTile(
            title: const Text('PPKeypad'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPKeypad'),
          ),
          ListTile(
            title: const Text('PPKhmerCalendar'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPKhmerCalendar'),
          ),
          ListTile(
            title: const Text('PPKhmerCalendarAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPKhmerCalendarAlert'),
          ),
          ListTile(
            title: const Text('PPKhmerCalendarIsland'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPKhmerCalendarIsland'),
          ),
          ListTile(
            title: const Text('PPKhmerCalendarSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPKhmerCalendarSheet'),
          ),
          ListTile(
            title: const Text('PPKhmerKeyboard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPKhmerKeyboard'),
          ),
          ListTile(
            title: const Text('PPLanguageSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPLanguageSheet'),
          ),
          ListTile(
            title: const Text('PPLineChart'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPLineChart'),
          ),
          ListTile(
            title: const Text('PPMagnifier'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMagnifier'),
          ),
          ListTile(
            title: const Text('PPMarquee'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMarquee'),
          ),
          ListTile(
            title: const Text('PPMasonry'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMasonry'),
          ),
          ListTile(
            title: const Text('PPMathEditor'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMathEditor'),
          ),
          ListTile(
            title: const Text('PPMathKeyboard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMathKeyboard'),
          ),
          ListTile(
            title: const Text('PPMathPreview'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMathPreview'),
          ),
          ListTile(
            title: const Text('PPMonthPicker'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMonthPicker'),
          ),
          ListTile(
            title: const Text('PPMonthPickerAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMonthPickerAlert'),
          ),
          ListTile(
            title: const Text('PPMonthPickerIsland'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMonthPickerIsland'),
          ),
          ListTile(
            title: const Text('PPMonthPickerSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPMonthPickerSheet'),
          ),
          ListTile(
            title: const Text('PPNavigationDrawer'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPNavigationDrawer'),
          ),
          ListTile(
            title: const Text('PPNavigationRail'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPNavigationRail'),
          ),
          ListTile(
            title: const Text('PPNoResult'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPNoResult'),
          ),
          ListTile(
            title: const Text('PPNotificationItem'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPNotificationItem'),
          ),
          ListTile(
            title: const Text('PPNumberSpinner'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPNumberSpinner'),
          ),
          ListTile(
            title: const Text('PPOnboard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPOnboard'),
          ),
          ListTile(
            title: const Text('PPOtpInput'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPOtpInput'),
          ),
          ListTile(
            title: const Text('PPPagination'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPagination'),
          ),
          ListTile(
            title: const Text('PPPasswordStrength'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPasswordStrength'),
          ),
          ListTile(
            title: const Text('PPPdfViewer'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPdfViewer'),
          ),
          ListTile(
            title: const Text('PPPhoneInput'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPhoneInput'),
          ),
          ListTile(
            title: const Text('PPPhoneKeyboard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPhoneKeyboard'),
          ),
          ListTile(
            title: const Text('PPPieChart'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPieChart'),
          ),
          ListTile(
            title: const Text('PPPinDots'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPinDots'),
          ),
          ListTile(
            title: const Text('PPProgressGauge'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPProgressGauge'),
          ),
          ListTile(
            title: const Text('PPPullToRefresh'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPPullToRefresh'),
          ),
          ListTile(
            title: const Text('PPQRCode'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPQRCode'),
          ),
          ListTile(
            title: const Text('PPQuarterPicker'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPQuarterPicker'),
          ),
          ListTile(
            title: const Text('PPRadarChart'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRadarChart'),
          ),
          ListTile(
            title: const Text('PPRadio'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRadio'),
          ),
          ListTile(
            title: const Text('PPRadioGroup'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRadioGroup'),
          ),
          ListTile(
            title: const Text('PPRating'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRating'),
          ),
          ListTile(
            title: const Text('PPReactionPicker'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPReactionPicker'),
          ),
          ListTile(
            title: const Text('PPReceiveAmountSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPReceiveAmountSheet'),
          ),
          ListTile(
            title: const Text('PPReceivingAccountSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPReceivingAccountSheet'),
          ),
          ListTile(
            title: const Text('PPRibbon'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRibbon'),
          ),
          ListTile(
            title: const Text('PPRibbonButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRibbonButton'),
          ),
          ListTile(
            title: const Text('PPRibbonGroup'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRibbonGroup'),
          ),
          ListTile(
            title: const Text('PPRibbonTab'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRibbonTab'),
          ),
          ListTile(
            title: const Text('PPRichTextEditor'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPRichTextEditor'),
          ),
          ListTile(
            title: const Text('PPScatterChart'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPScatterChart'),
          ),
          ListTile(
            title: const Text('PPScrollArea'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPScrollArea'),
          ),
          ListTile(
            title: const Text('PPScrollSegment'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPScrollSegment'),
          ),
          ListTile(
            title: const Text('PPScrollSegmentButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPScrollSegmentButton'),
          ),
          ListTile(
            title: const Text('PPSearch'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSearch'),
          ),
          ListTile(
            title: const Text('PPSecureKeyboard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSecureKeyboard'),
          ),
          ListTile(
            title: const Text('PPSecureKeypad'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSecureKeypad'),
          ),
          ListTile(
            title: const Text('PPSegment'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSegment'),
          ),
          ListTile(
            title: const Text('PPSegmentButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSegmentButton'),
          ),
          ListTile(
            title: const Text('PPSelect'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSelect'),
          ),
          ListTile(
            title: const Text('PPSidebarNavigation'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSidebarNavigation'),
          ),
          ListTile(
            title: const Text('PPSignaturePad'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSignaturePad'),
          ),
          ListTile(
            title: const Text('PPSignaturePadAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSignaturePadAlert'),
          ),
          ListTile(
            title: const Text('PPSignaturePadSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSignaturePadSheet'),
          ),
          ListTile(
            title: const Text('PPSkeleton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSkeleton'),
          ),
          ListTile(
            title: const Text('PPSkeletonDetail'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSkeletonDetail'),
          ),
          ListTile(
            title: const Text('PPSkeletonItem'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSkeletonItem'),
          ),
          ListTile(
            title: const Text('PPSkeletonList'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSkeletonList'),
          ),
          ListTile(
            title: const Text('PPSkipButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSkipButton'),
          ),
          ListTile(
            title: const Text('PPSlider'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSlider'),
          ),
          ListTile(
            title: const Text('PPSortSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSortSheet'),
          ),
          ListTile(
            title: const Text('PPSpinWheel'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSpinWheel'),
          ),
          ListTile(
            title: const Text('PPSplitter'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSplitter'),
          ),
          ListTile(
            title: const Text('PPStepper'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPStepper'),
          ),
          ListTile(
            title: const Text('PPSwipeItem'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSwipeItem'),
          ),
          ListTile(
            title: const Text('PPSwitch'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPSwitch'),
          ),
          ListTile(
            title: const Text('PPTab'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTab'),
          ),
          ListTile(
            title: const Text('PPTabList'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTabList'),
          ),
          ListTile(
            title: const Text('PPTabPanel'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTabPanel'),
          ),
          ListTile(
            title: const Text('PPTabPanels'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTabPanels'),
          ),
          ListTile(
            title: const Text('PPTable'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTable'),
          ),
          ListTile(
            title: const Text('PPTabs'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTabs'),
          ),
          ListTile(
            title: const Text('PPTagInput'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTagInput'),
          ),
          ListTile(
            title: const Text('PPTextField'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTextField'),
          ),
          ListTile(
            title: const Text('PPTimePicker'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTimePicker'),
          ),
          ListTile(
            title: const Text('PPTimePickerAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTimePickerAlert'),
          ),
          ListTile(
            title: const Text('PPTimePickerIsland'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTimePickerIsland'),
          ),
          ListTile(
            title: const Text('PPTimePickerSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTimePickerSheet'),
          ),
          ListTile(
            title: const Text('PPTimeline'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTimeline'),
          ),
          ListTile(
            title: const Text('PPTimelineItem'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTimelineItem'),
          ),
          ListTile(
            title: const Text('PPToast'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPToast'),
          ),
          ListTile(
            title: const Text('PPToggleButton'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPToggleButton'),
          ),
          ListTile(
            title: const Text('PPTooltip'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTooltip'),
          ),
          ListTile(
            title: const Text('PPTransferList'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTransferList'),
          ),
          ListTile(
            title: const Text('PPTree'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTree'),
          ),
          ListTile(
            title: const Text('PPTreeNode'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTreeNode'),
          ),
          ListTile(
            title: const Text('PPTreeSelect'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPTreeSelect'),
          ),
          ListTile(
            title: const Text('PPUpgradeCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPUpgradeCard'),
          ),
          ListTile(
            title: const Text('PPUserCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPUserCard'),
          ),
          ListTile(
            title: const Text('PPUserProfile'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPUserProfile'),
          ),
          ListTile(
            title: const Text('PPVerificationCard'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPVerificationCard'),
          ),
          ListTile(
            title: const Text('PPWebToast'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPWebToast'),
          ),
          ListTile(
            title: const Text('PPYearPicker'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPYearPicker'),
          ),
          ListTile(
            title: const Text('PPYearPickerAlert'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPYearPickerAlert'),
          ),
          ListTile(
            title: const Text('PPYearPickerIsland'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPYearPickerIsland'),
          ),
          ListTile(
            title: const Text('PPYearPickerSheet'),
            subtitle: const Text('Boilerplate component'),
            onTap: () => _navigateTo(context, 'PPYearPickerSheet'),
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
              title: const Text('UI Components'),
            ),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.list),
                      label: Text('Components'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _selectedIndex == 0
                      ? _buildComponentList()
                      : const Center(child: Text('Settings Screen Placeholder')),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('UI Components'),
            ),
            body: _selectedIndex == 0
                ? _buildComponentList()
                : const Center(child: Text('Settings Screen Placeholder')),
            bottomNavigationBar: PPBottomNav(
              value: _selectedIndex.toString(),
              onChanged: (String val) {
                setState(() {
                  _selectedIndex = int.parse(val);
                });
              },
              items: const [
                PPBottomNavItem(
                  label: 'Components',
                  value: '0',
                  icon: Icons.list_outlined,
                  activeIcon: Icons.list,
                ),
                PPBottomNavItem(
                  label: 'Settings',
                  value: '1',
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
