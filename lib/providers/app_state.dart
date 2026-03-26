import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/product_model.dart';

class AppState extends ChangeNotifier {
  List<ProductModel> history = [];

  AppState() {
    loadData();
  }

  void addProduct(ProductModel product) {
    history.removeWhere((p) => p.name == product.name);
    history.insert(0, product);
    saveData();
    notifyListeners();
  }

  double totalCO2() {
    return history.fold(0, (sum, p) => sum + p.co2);
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = history.map((p) => jsonEncode(p.toJson())).toList();
    prefs.setStringList("history", data);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList("history") ?? [];
    history = data.map((e) => ProductModel.fromJson(jsonDecode(e))).toList();
    notifyListeners();
  }
}