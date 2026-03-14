import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/perfume.dart';

class PerfumeService {
  static Future<List<Perfume>> loadPerfumes() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/perfumes.json');

    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.map((item) => Perfume.fromJson(item)).toList();
  }
}