import 'dart:io';

class SoilResultData {
  final File? image;
  final String? imageUrl;
  final String soilType;
  final String color;
  final String ph;
  final String moisture;
  final String quality;
  final List<String> bestCrops;
  final String dateTime;
  final bool isExist;

  SoilResultData({
    this.image,
    this.imageUrl,
    required this.soilType,
    required this.color,
    required this.ph,
    required this.moisture,
    required this.quality,
    required this.bestCrops,
    required this.dateTime,
    required this.isExist,
  });

  factory SoilResultData.fromJson(Map<String, dynamic> json) {

    String type = json['soil_type'] ?? 'Unknown';
    String color;
    if (type == "Clay") {
      color = "Black";
    } else if (type == "Sand") {
      color = "Yellow";
    } else {
      color = "Brown";
    }


    bool alreadyExist = false;
    if (json['source'] != null && json['source']['type'] == 'history') {
      alreadyExist = true;
    }

    return SoilResultData(
      soilType: type,
      color: color,
      ph: json['ph']?.toString() ?? '0.0',
      moisture: json['moisture']?.toString() ?? '0',
      quality: json['soil_quality'] ?? 'N/A',


      bestCrops: json['crop'] != null
          ? [json['crop'].toString()]
          : (json['best_crops'] != null ? List<String>.from(json['best_crops']) : []),


      dateTime: json['source'] != null ? json['source']['timestamp'] : (json['created_at'] ?? ''),
      imageUrl: json['image_url'],
      isExist: alreadyExist,
    );
  }
}