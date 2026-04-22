class HistoryItem {
  final int id;
  final String soilType;
  final String color;
  final double ph;
  final double moisture;
  final String? imageUrl;
  final String quality;
  final String crop;
  final String date;


  HistoryItem({
    required this.id,
    required this.soilType,
    required this.color,
    required this.ph,
    required this.moisture,
    this.imageUrl,
    required this.quality,
    required this.crop,
    required this.date,


  });


  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'] ?? 0,

      soilType: json['soil_type'] ?? "Unknown",
      color: json['color'] ?? "N/A",
      ph: (json['ph'] ?? 0).toDouble(),
      moisture: (json['moisture'] ?? 0).toDouble(),
      imageUrl: json['image_url'],
      quality: json['soil_quality'] ?? "Normal",
      crop: json['crop'] ?? "Unknown",
      date: json['created_at'] ?? "",
    );
  }
}