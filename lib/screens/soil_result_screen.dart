import 'package:flutter/material.dart';

import '../models/soil_result_model.dart';
import '../widgets/app_theme.dart';

class SoilResultScreen extends StatelessWidget {
  final SoilResultData result;
  const SoilResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Soil Analysis Result",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primary)),
            ),
            SizedBox(height: 30),

            // عرض الصورة
            Row(
              children: [
                Text("• Uploaded Image: ", style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 18)),
                SizedBox(width: 10),
                if (result.image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(result.image!, width: 80, height: 80, fit: BoxFit.cover),
                  )
                else
                  Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
              ],
            ),

            SizedBox(height: 30),

            // عرض البيانات بشكل قائمة (Bullet Points)
            _buildResultRow("Soil Type", result.soilType),
            _buildResultRow("Color", result.color),
            _buildResultRow("pH", result.ph),
            _buildResultRow("Moisture", result.moisture),
            _buildResultRow("Soil Quality", result.quality),
            _buildResultRow("Best Crops", result.bestCrops.join(" , ")),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                result.dateTime,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),

            SizedBox(height: 40),

            // الأزرار
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                minimumSize: Size(double.infinity, 55),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Back to Home", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

            SizedBox(height: 15),

            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, "/history"),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 55),
                side: BorderSide(color: AppTheme.primary),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Back to History", style: TextStyle(color: AppTheme.primary, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  // ويدجت مساعدة لرسم الأسطر
  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: [
            TextSpan(text: "• $label: ", style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}





