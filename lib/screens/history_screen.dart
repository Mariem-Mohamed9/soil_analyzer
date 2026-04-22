import 'package:flutter/material.dart';
import '../models/history_item_model.dart';
import '../service/history_service.dart';
import '../widgets/app_theme.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = "/history";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.primary, size: 28),
          onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
        ),
        title: const Text(
          "History",
          style: TextStyle(
            color: AppTheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset("assets/images/logo_2.png", height: 40),
          ),
        ],
      ),

      body: FutureBuilder<List<HistoryItem>>(
        future: HistoryService().fetchHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No history found yet."));
          }

          final historyList = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: historyList.length,
            itemBuilder: (context, index) {
              return HistoryCard(item: historyList[index]);
            },
          );
        },
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final HistoryItem item;
  const HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                  ? Image.network(
                item.imageUrl!,
                width: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 110,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              )
                  : Container(
                width: 110,
                color: Colors.grey,
                child: const Icon(Icons.image_outlined, size: 45, color: Colors.black26),
              ),
            ),


            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        item.date,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 4),


                    _buildInfoRow("Type", item.soilType),
                    _buildInfoRow("pH", item.ph.toString()),
                    _buildInfoRow("Moisture", "${item.moisture}%"),
                    _buildInfoRow("Quality", item.quality),
                    _buildInfoRow("Best Crop", item.crop),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• $label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}