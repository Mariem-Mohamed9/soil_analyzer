import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:soil_analyzer/screens/soil_result_screen.dart';

import '../models/soil_result_model.dart';
import '../widgets/app_theme.dart';
import '../widgets/soil_data_form.dart';

class SoilConfirmationScreen extends StatefulWidget {
  static const String routeName = "/confirm";
  final File image;

  const SoilConfirmationScreen({super.key, required this.image});

  @override
  State<SoilConfirmationScreen> createState() =>
      _SoilConfirmationScreenState();
}

class _SoilConfirmationScreenState extends State<SoilConfirmationScreen> {
  bool isLoading = false;


  void _showInvalidImageDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            SizedBox(width: 10),
            Text("Analysis Error", style: TextStyle(color: Colors.red)),
          ],
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
            child: const Text("Try Another Photo",
                style: TextStyle(fontSize: 16, color: AppTheme.primary)),
          ),
        ],
      ),
    );
  }

  Future<void> sendToApi(String moisture, String ph) async {
    setState(() {
      isLoading = true;
    });

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("https://web-production-8bb83c.up.railway.app/predict"),
      );

      request.fields["moisture"] = moisture;
      request.fields["ph"] = ph;
      request.files
          .add(await http.MultipartFile.fromPath("image", widget.image.path));

      var response = await request.send();
      var result = await response.stream.bytesToString();
      final data = jsonDecode(result);
      print("Full API Response: $data");

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        String detectedType = data['soil_type'] ?? "Unknown";

        String detectedColor;
        if (detectedType == "Clay") {
          detectedColor = "Black";
        } else if (detectedType == "Sand") {
          detectedColor = "Yellow";
        } else {
          detectedColor = "Brown";
        }

        final finalResult = SoilResultData(
          image: widget.image,
          soilType: detectedType,
          color: detectedColor,
          ph: data['ph']?.toString() ?? ph,
          moisture: data['moisture']?.toString() ?? moisture,
          quality: data['soil_quality'] ?? "N/A",
          bestCrops: data['best_crops'] is List
              ? List<String>.from(data['best_crops'])
              : [data['crop']?.toString() ?? "N/A"],
          dateTime: DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.now()),
          isExist: (data['source'] != null && data['source']['type'] == 'history')
              ? true
              : false,
        );

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SoilResultScreen(result: finalResult),
          ),
        );
      }

      else if (response.statusCode == 400) {
        String errorMessage = data['error'] ?? "No matching soil type detected";
        _showInvalidImageDialog(errorMessage);
      }
      else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.primary,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              "assets/images/logo_2.png",
              height: 50,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Confirm Soil Data",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Add pH & moisture for better accuracy",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Text(
                            "Uploaded Image: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              widget.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SoilDataForm(
                  showColor: false,
                  onSubmit: (color, moisture, ph) {
                    sendToApi(moisture, ph);
                  },
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(color: AppTheme.primary),
              ),
            ),
        ],
      ),
    );
  }
}