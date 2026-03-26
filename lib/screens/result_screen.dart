import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../services/api_service.dart';
import '../services/ai_service.dart';
import '../models/product_model.dart';
import '../providers/app_state.dart';
import 'map_screen.dart';

class ResultScreen extends StatelessWidget {
  final String barcode;

  const ResultScreen({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EcoTrace Analysis"),
        leading: const BackButton(),
      ),
      body: FutureBuilder<ProductModel?>(
        future: ApiService.fetchProduct(barcode),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final p = snapshot.data!;
          context.read<AppState>().addProduct(p);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 🔥 PRODUCT IMAGE
                if (p.image.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(p.image, height: 180),
                  ),

                const SizedBox(height: 10),

                // 🔥 NAME
                Text(
                  p.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                // 🔥 SCORE CIRCLE
                CircularPercentIndicator(
                  radius: 80,
                  lineWidth: 12,
                  percent: p.sustainabilityScore / 100,
                  center: Text(
                    "${p.sustainabilityScore.toInt()}",
                    style: const TextStyle(fontSize: 22),
                  ),
                  progressColor: Colors.green,
                  backgroundColor: Colors.grey.shade300,
                ),

                const SizedBox(height: 15),

                // 🤖 AI INSIGHT
                Text(
                  AIService.generateInsight(p.name, p.co2, p.ecoGrade),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),

                const SizedBox(height: 20),

                // 📊 INFO CARD
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("Eco Grade: ${p.ecoGrade}"),
                      ),
                      ListTile(
                        title: Text(
                            "CO2: ${p.co2.toStringAsFixed(2)} kg"),
                      ),
                      ListTile(
                        title: Text("Authenticity: ${p.authenticity}"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 🔥 FULL TRACE (LIKE YOUR OLD UI)
                _traceStep("Origin", p.origin),
                _traceStep("Manufacturing", p.manufacturing),
                _traceStep("Ingredients", p.ingredients),
                _traceStep("Distribution", p.countries),

                const SizedBox(height: 20),

                // 🗺️ OPTIONAL MAP BUTTON (SAFE)
                ElevatedButton(
                  onPressed: () {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MapScreen()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Map not available")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("View Supply Chain Map"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ✅ TRACE UI (OLD STYLE RESTORED)
  Widget _traceStep(String title, String desc) {
    return ListTile(
      leading: const Icon(Icons.check_circle, color: Colors.green),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(desc),
    );
  }
}