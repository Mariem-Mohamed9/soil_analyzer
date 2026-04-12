import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://web-production-a55511.up.railway.app";

  static Future<Map<String, dynamic>> predictSoil({
    required double ph,
    required double moisture,
    required String color,
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
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: ${response.body}");
    }
  }
}