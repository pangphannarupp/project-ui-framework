import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transactions_screen.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E293B), // Slate color
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const MainNavigationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  String _currentValue = 'home';

  final Map<String, Widget> _screens = {
    'home': const DashboardScreen(),
    'activity': const TransactionsScreen(),
    'transfer': const Center(child: Text('Transfer')),
    'profile': const Center(child: Text('Profile')),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentValue]!,
      bottomNavigationBar: PPBottomNav(
        value: _currentValue,
        onChanged: (value) {
          setState(() {
            _currentValue = value;
          });
        },
        items: const [
          PPBottomNavItem(value: 'home', icon: Icons.dashboard_outlined, activeIcon: Icons.dashboard, label: 'Home'),
          PPBottomNavItem(value: 'activity', icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long, label: 'Activity'),
          PPBottomNavItem(value: 'transfer', icon: Icons.swap_horiz_outlined, activeIcon: Icons.swap_horiz, label: 'Transfer'),
          PPBottomNavItem(value: 'profile', icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
        ],
      ),
    );
  }
}
