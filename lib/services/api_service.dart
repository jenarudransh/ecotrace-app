import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static Future<ProductModel?> fetchProduct(String barcode) async {
    try {
      final res = await http.get(
        Uri.parse('https://world.openfoodfacts.org/api/v2/product/$barcode.json'),
      );

      final data = jsonDecode(res.body);
      if (data['status'] != 1) return null;

      final p = data['product'];

      String name = p['product_name'] ?? "Unknown";
      String image = p['image_front_url'] ?? "";
      String origin = p['origins'] ?? "Unknown";
      String manufacturing = p['manufacturing_places'] ?? "Unknown";
      String ingredients = p['ingredients_text'] ?? "No data";
      String countries = p['countries'] ?? "Unknown";
      String eco = (p['ecoscore_grade'] ?? "b").toUpperCase();

      double co2 = _estimateCO2(origin);
      String auth = _auth(p);
      double score = _score(p, co2);

      return ProductModel(
        name: name,
        image: image,
        origin: origin,
        manufacturing: manufacturing,
        ingredients: ingredients,
        countries: countries,
        ecoGrade: eco,
        co2: co2,
        authenticity: auth,
        sustainabilityScore: score,
      );
    } catch (e) {
      return null;
    }
  }

  static double _estimateCO2(String origin) {
    double distance = origin != "Unknown" ? 2000 : 500;
    return distance * 0.0002;
  }

  static String _auth(Map p) {
    if ((p['labels'] ?? "").toString().toLowerCase().contains("organic")) {
      return "High";
    }
    if (p['brands'] != null) return "Moderate";
    return "Low";
  }

  static double _score(Map p, double co2) {
    double s = 100;
    if ((p['ecoscore_grade'] ?? "") == 'e') s -= 40;
    if (co2 > 2) s -= 30;
    if (!(p['labels'] ?? "").toString().contains("organic")) s -= 20;
    return s.clamp(0, 100);
  }
}