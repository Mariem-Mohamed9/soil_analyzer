import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/soil_result_model.dart';
import '../screens/soil_result_screen.dart';
import '../widgets/app_theme.dart';
import '../widgets/soil_data_form.dart';

class DataManuallyScreen extends StatefulWidget {
  static const String routeName = "/manually";

  @override
  State<DataManuallyScreen> createState() => _DataManuallyScreenState();
}

class _DataManuallyScreenState extends State<DataManuallyScreen> {
  bool isLoading = false;

  Future<void> sendToApi(String color, String moisture, String ph) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse("https://web-production-8bb83c.up.railway.app/predict"),
        body: {
          "color": color,
          "moisture": moisture,
          "ph": ph,
        },
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);


        final finalResult = SoilResultData(
          image: null,
          imageUrl: null,
          soilType: data['soil_type'] ?? "Unknown",
          color: color,
          ph: ph,
          moisture: moisture,
          quality: data['soil_quality'] ?? "N/A",
          bestCrops: [data['crop']?.toString() ?? "N/A"],
          dateTime: DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.now()),
          isExist: (data['source'] != null && data['source']['type'] == 'history') ? true : false,
        );


        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SoilResultScreen(result: finalResult),
          ),
        );
      } else {

        print("Server Error: ${response.body}");
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Analysis Error"),
        content: Text("Make sure the server is online.\nDetails: $message"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.primary, size: 30),
          onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image.asset("assets/images/logo_2.png", height: 50),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Enter Soil Data Manually",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                      SizedBox(height: 30),
                      SoilDataForm(
                        showColor: true,
                        onSubmit: (color, moisture, ph) {
                          sendToApi(color, moisture, ph);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}