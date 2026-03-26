import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const EcoTraceApp(),
    ),
  );
}

class EcoTraceApp extends StatelessWidget {
  const EcoTraceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "EcoTrace",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}