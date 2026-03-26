import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: Column(
        children: [
          Text("Total CO2: ${state.totalCO2().toStringAsFixed(2)} kg"),
          Expanded(
            child: BarChart(
              BarChartData(
                barGroups: state.history.asMap().entries.map((e) {
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [BarChartRodData(toY: e.value.co2)],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}