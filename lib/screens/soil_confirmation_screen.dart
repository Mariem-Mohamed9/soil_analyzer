import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  /// 🚀 API CALL (Image Mode)
  Future<void> sendToApi(String moisture, String ph) async {
    setState(() {
      isLoading = true;
    });

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("https://web-production-a55511.up.railway.app/predict"),
      );

      request.fields["moisture"] = moisture;
      request.fields["ph"] = ph;

      request.files.add(
        await http.MultipartFile.fromPath(
          "image",
          widget.image.path,
        ),
      );

      var response = await request.send();
      var result = await response.stream.bytesToString();

      final data = jsonDecode(result);

      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Result"),
          content: Text(
            "Soil Type: ${data['soil_type']}\n"
                "Quality: ${data['soil_quality']}\n"
                "Crop: ${data['crop']}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            )
          ],
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.primary,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/camera");
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
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

                      /// 📸 عرض الصورة
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

                /// 🔥 الفورم بدون Color
                SoilDataForm(
                  showColor: false, // لازم تكوني ضفتيها في الفورم
                  onSubmit: (color, moisture, ph) {
                    sendToApi(moisture, ph);
                  },
                ),
              ],
            ),
          ),

          /// 🔥 Loading Overlay
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}