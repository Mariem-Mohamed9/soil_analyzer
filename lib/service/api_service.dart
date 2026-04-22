import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:soil_analyzer/models/soil_result_model.dart';

class ApiService {
  static const String baseUrl = "https://web-production-8bb83c.up.railway.app";

  static Future<SoilResultData> predictSoil({
    required double ph,
    required double moisture,
    required String color,
    File? imageFile,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/predict"),
      body: {
        "ph": ph.toString(),
        "moisture": moisture.toString(),
        "color": color,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return SoilResultData(
        image: imageFile,
        soilType: data['soil_type'] ?? "clay",
        color: color,
        ph: "$ph (Optimal)",
        moisture: "$moisture% (Good)",
        quality: data['quality'] ?? "Good",
        bestCrops: List<String>.from(data['best_crops'] ?? []),
        dateTime: DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.now()),
        isExist: (data['source']?['type'] == 'history'),
      );
    } else {
      throw Exception("Error: ${response.body}");
    }
  }
}