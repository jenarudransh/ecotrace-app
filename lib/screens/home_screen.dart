import 'package:flutter/material.dart';
import 'scanner_screen.dart';
import 'dashboard_screen.dart';
import 'compare_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final pages = [
    const ScannerScreen(),
    const DashboardScreen(),
    const CompareScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.qr_code), label: "Scan"),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: "Dashboard"),
          NavigationDestination(icon: Icon(Icons.compare), label: "Compare"),
        ],
      ),
    );
  }
}