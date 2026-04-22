import 'package:flutter/material.dart';
import '../models/history_item_model.dart';
import '../widgets/app_theme.dart';

class LatestAnalysisItem extends StatelessWidget {
  final HistoryItem item;

  const LatestAnalysisItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // العرض الموصى به للكارت الواحد بناءً على الصورة
    final double cardWidth = MediaQuery.of(context).size.width * 0.70;

    return Container(
      width: cardWidth,
      margin: const EdgeInsets.only(right: 12, bottom: 5, top: 5), // هوامش بسيطة حول الكارت
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // حواف مستديرة للكارت ككل
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08), // ظل خفيف جداً
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        // تأكد من أن أي عنصر داخل الكارت يحترم الحواف المستديرة الـ 15
        borderRadius: BorderRadius.circular(15),
        child: Row(
          children: [

            SizedBox(
              width: cardWidth * 0.40,
              height: double.infinity,
              child: (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                  ? Image.network(
                item.imageUrl!,
                fit: BoxFit.cover,
              )
                  : Container(
                color: Colors.grey,
                child: const Icon(Icons.image, color: Colors.black),
              ),
            ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDataRow("Soil Type", item.soilType),
                    _buildDataRow("Color", item.color ?? "N/A"),
                    _buildDataRow("pH", "${item.ph.toString()} "),
                    _buildDataRow("Moisture", "${item.moisture}%"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت صغيرة لرسم السطر اللي فيه النقطة (Bullet Point)
  Widget _buildDataRow(String label, String value) {
    // استخدام لون أخضر غامق مشابه للـ Mockup
    const Color textColor = Color(0xff155724);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2), // تباعد رأسي بسيط بين السطور
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النقطة والنص
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0), // محاذاة دقيقة للنقطة مع النص
            child: const Icon(Icons.circle, size: 5, color: textColor), // نقطة أصغر
          ),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 11, color: textColor, height: 1.3),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: value,
                  ),
                ],
              ),
              maxLines: 2, // يسمح بسطرين لو القيمة طويلة
              overflow: TextOverflow.ellipsis, // يقص النص لو أطول من سطرين
            ),
          ),
        ],
      ),
    );
  }
}