import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'result_screen.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool scanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Product")),
      body: MobileScanner(
        onDetect: (capture) {
          if (scanned) return;

          final code = capture.barcodes.first.rawValue;

          if (code != null) {
            scanned = true;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResultScreen(barcode: code),
              ),
            );
          }
        },
      ),
    );
  }
}