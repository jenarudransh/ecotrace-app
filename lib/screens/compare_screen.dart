import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<AppState>().history;

    return Scaffold(
      appBar: AppBar(title: const Text("Compare")),
      body: ListView(
        children: items.map((p) {
          return Card(
            child: ListTile(
              title: Text(p.name),
              subtitle: Text(
                  "CO2: ${p.co2} | Score: ${p.sustainabilityScore}"),
            ),
          );
        }).toList(),
      ),
    );
  }
}