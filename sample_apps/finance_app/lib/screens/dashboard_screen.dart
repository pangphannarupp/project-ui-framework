import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PPIconButton(
            icon: Icons.notifications_outlined,
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E293B), Color(0xFF334155)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 8),
                  const Text('\$12,450.00', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: PPButton(
                          label: 'Deposit',
                          onPressed: () {},
                          variant: PPButtonVariant.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PPButton(
                          label: 'Send',
                          onPressed: () {},
                          variant: PPButtonVariant.outline,
                          // Outline button on dark background might need custom styling, assuming the framework handles it or we can pass colors if needed.
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Activity Chart
            const Text('Monthly Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PPLineChart(
                  height: 200,
                  labels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                  series: const [
                    PPLineChartSeries(
                      title: 'Income',
                      values: [4000, 3000, 5000, 4500, 6000, 5500],
                      color: Colors.green,
                    ),
                    PPLineChartSeries(
                      title: 'Expense',
                      values: [2000, 2500, 1500, 3000, 2800, 2200],
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Quick Actions
            const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionItem(Icons.send_outlined, 'Transfer'),
                _buildActionItem(Icons.account_balance_wallet_outlined, 'Top Up'),
                _buildActionItem(Icons.qr_code_scanner_outlined, 'Scan'),
                _buildActionItem(Icons.more_horiz, 'More'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
