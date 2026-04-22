import 'package:flutter/material.dart';
import '../models/soil_result_model.dart';
import '../widgets/app_theme.dart';

class SoilResultScreen extends StatefulWidget {
  final SoilResultData result;
  const SoilResultScreen({super.key, required this.result});

  @override
  State<SoilResultScreen> createState() => _SoilResultScreenState();
}

class _SoilResultScreenState extends State<SoilResultScreen> {

  @override
  void initState() {
    super.initState();
    // ✅ أول ما الصفحة تفتح، بنشوف لو السيرفر قال إنها موجودة قبل كدة
    if (widget.result.isExist) {
      // بنستخدم Future.delayed عشان نضمن إن الـ UI اترسم قبل ما نطلع الـ SnackBar
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This analysis already exists in your history!"),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.primary),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Soil Analysis Result",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary),
              ),
            ),
            const SizedBox(height: 30),

            // عرض الصورة
            if (widget.result.image != null || (widget.result.imageUrl != null && widget.result.imageUrl!.isNotEmpty))
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    const Text("• Soil Image: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                            fontSize: 18)),
                    const SizedBox(width: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: widget.result.image != null
                          ? Image.file(widget.result.image!,
                          width: 100, height: 100, fit: BoxFit.cover)
                          : Image.network(
                        widget.result.imageUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ],
                ),
              ),

            _buildResultRow("Soil Type", widget.result.soilType),
            _buildResultRow("Color", widget.result.color),
            _buildResultRow("pH", widget.result.ph),
            _buildResultRow("Moisture", widget.result.moisture.contains('%') ? widget.result.moisture : "${widget.result.moisture}%"),
            _buildResultRow("Soil Quality", widget.result.quality),
            _buildResultRow("Best Crops", widget.result.bestCrops.join(" , ")),

            const SizedBox(height: 15),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                widget.result.dateTime,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),

            const SizedBox(height: 40),

            // زرار الرجوع للهوم
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => false),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Back to Home",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

            const SizedBox(height: 15),

            // ✅ زرار الحفظ المعدل
            OutlinedButton(
              onPressed: widget.result.isExist
                  ? null // يتطفي لو موجودة فعلاً
                  : () {
                // كود الحفظ لو محتاجة تنادي API معين، بس حالياً السيرفر حفظها تلقائي
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Saved to history successfully!")),
                );
                Navigator.pushNamed(context, "/history");
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                side: BorderSide(color: widget.result.isExist ? Colors.grey : AppTheme.primary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                  widget.result.isExist ? "Already Saved in history" : "Save to History",
                  style: TextStyle(
                      color: widget.result.isExist ? Colors.grey : AppTheme.primary,
                      fontSize: 18
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 18),
          children: [
            TextSpan(
                text: "• $label: ",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppTheme.primary)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}