import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/history_item_model.dart';

class HistoryService {

  static const String baseUrl = "https://web-production-8bb83c.up.railway.app";


  Future<List<HistoryItem>> fetchHistory() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/history"));

      if (response.statusCode == 200) {

        List<dynamic> data = jsonDecode(response.body);

        return data.map((json) => HistoryItem.fromJson(json)).toList().reversed.toList();
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
    return [];
  }
}