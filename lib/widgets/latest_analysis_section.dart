import 'package:flutter/material.dart';
import '../models/history_item_model.dart';
import 'latest_analysis_item.dart';

class LatestAnalysisSection extends StatelessWidget {
  final List<HistoryItem> historyList;

  const LatestAnalysisSection({super.key, required this.historyList});

  @override
  Widget build(BuildContext context) {
    // استخدمنا ارتفاع ثابت ومحدد لمنع مشاكل الـ Overflow (Render pixels)
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        // إضافة الـ Shadow الخفيف للسيكشن بالكامل بدل الخلفية الخضراء
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        // أضفنا Physics لجعل السكرول أنعم
        physics: const BouncingScrollPhysics(),
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          return LatestAnalysisItem(item: historyList[index]);
        },
      ),
    );
  }
}