import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPChartsDemo extends StatelessWidget {
  const _PPChartsDemo();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const Text(
          'Charts & Graphs',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'A comprehensive collection of charts powered by fl_chart.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 32),

        // Line Chart
        _buildSectionTitle('Line Chart'),
        Card(
          child: PPLineChart(
            labels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            series: const [
              PPLineChartSeries(
                title: 'Revenue',
                values: [20, 35, 25, 45, 60, 50],
                color: Colors.blue,
              ),
              PPLineChartSeries(
                title: 'Expenses',
                values: [15, 25, 20, 30, 45, 40],
                color: Colors.red,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Bar Chart
        _buildSectionTitle('Bar Chart (Grouped)'),
        Card(
          child: PPBarChart(
            labels: const ['Q1', 'Q2', 'Q3', 'Q4'],
            series: const [
              PPBarChartSeries(title: 'Product A', values: [100, 150, 200, 180], color: Colors.blue),
              PPBarChartSeries(title: 'Product B', values: [80, 120, 160, 210], color: Colors.green),
            ],
            stacked: false,
          ),
        ),
        const SizedBox(height: 32),
        
        _buildSectionTitle('Bar Chart (Stacked)'),
        Card(
          child: PPBarChart(
            labels: const ['Q1', 'Q2', 'Q3', 'Q4'],
            series: const [
              PPBarChartSeries(title: 'Product A', values: [100, 150, 200, 180], color: Colors.blue),
              PPBarChartSeries(title: 'Product B', values: [80, 120, 160, 210], color: Colors.green),
            ],
            stacked: true,
          ),
        ),
        const SizedBox(height: 32),

        // Pie Chart
        _buildSectionTitle('Pie Chart'),
        Card(
          child: PPPieChart(
            data: [
              PPPieChartDataItem(title: 'Direct', value: 40, color: Colors.blue),
              PPPieChartDataItem(title: 'Social', value: 30, color: Colors.purple),
              PPPieChartDataItem(title: 'Search', value: 20, color: Colors.orange),
              PPPieChartDataItem(title: 'Referral', value: 10, color: Colors.green),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Donut Chart
        _buildSectionTitle('Donut Chart'),
        Card(
          child: PPDonutChart(
            donutHoleRadius: 60,
            data: [
              PPPieChartDataItem(title: 'Direct', value: 40, color: Colors.blue),
              PPPieChartDataItem(title: 'Social', value: 30, color: Colors.purple),
              PPPieChartDataItem(title: 'Search', value: 20, color: Colors.orange),
              PPPieChartDataItem(title: 'Referral', value: 10, color: Colors.green),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Radar Chart
        _buildSectionTitle('Radar Chart'),
        Card(
          child: PPRadarChart(
            features: ['Speed', 'Power', 'Durability', 'Agility', 'Cost'],
            series: [
              PPRadarChartSeries(
                title: 'Model X',
                values: [8, 9, 6, 7, 5],
                color: Colors.blue,
              ),
              PPRadarChartSeries(
                title: 'Model Y',
                values: [6, 7, 9, 5, 8],
                color: Colors.orange,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Scatter Chart
        _buildSectionTitle('Scatter Chart'),
        Card(
          child: PPScatterChart(
            data: [
              PPScatterChartDataPoint(x: 1, y: 3, color: Colors.blue, radius: 8),
              PPScatterChartDataPoint(x: 2, y: 5, color: Colors.blue, radius: 8),
              PPScatterChartDataPoint(x: 3, y: 2, color: Colors.blue, radius: 8),
              PPScatterChartDataPoint(x: 4, y: 7, color: Colors.blue, radius: 8),
              
              PPScatterChartDataPoint(x: 1.5, y: 4, color: Colors.red, radius: 6),
              PPScatterChartDataPoint(x: 2.5, y: 6, color: Colors.red, radius: 6),
              PPScatterChartDataPoint(x: 3.5, y: 3, color: Colors.red, radius: 6),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Funnel Chart
        _buildSectionTitle('Funnel Chart (Custom)'),
        Card(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: PPFunnelChart(
              height: 350,
              data: [
                PPFunnelChartDataItem(title: 'Visits', value: 10000, color: Colors.blue),
                PPFunnelChartDataItem(title: 'Signups', value: 5000, color: Colors.lightBlue),
                PPFunnelChartDataItem(title: 'Active Users', value: 2500, color: Colors.cyan),
                PPFunnelChartDataItem(title: 'Subscribers', value: 1000, color: Colors.teal),
                PPFunnelChartDataItem(title: 'Retained', value: 500, color: Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

final ComponentItem ppChartsData = ComponentItem(
  name: 'Charts & Graphs',
  description: 'Line, Bar, Pie, Donut, Radar, Scatter, and Funnel charts',
  demoBuilder: (context) => const _PPChartsDemo(),
);
