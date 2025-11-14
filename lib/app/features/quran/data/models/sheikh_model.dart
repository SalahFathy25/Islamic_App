class SheikhModel {
  final String id;
  final String name;
  final String sheikhImage;
  final List<SurahModel> surahs;

  SheikhModel({
    required this.id,
    required this.name,
    required this.sheikhImage,
    required this.surahs,
  });

  factory SheikhModel.fromDoc(String id, Map<String, dynamic> json) {
    final surahsRaw = json['surahs'] as List<dynamic>? ?? [];
    final surahs = surahsRaw
        .map((e) => SurahModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    return SheikhModel(
      id: id,
      name: json['name'] ?? '',
      sheikhImage: json['sheikhImage'] ?? '',
      surahs: surahs,
    );
  }

  factory SheikhModel.fromJson(Map<String, dynamic> json, String docId) {
    return SheikhModel(
      id: docId,
      name: json['name'] ?? '',
      sheikhImage: json['sheikhImage'] ?? '',
      surahs:
          (json['surahs'] as List<dynamic>?)
              ?.map((e) => SurahModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sheikhImage': sheikhImage,
      'surahs': surahs.map((e) => e.toJson()).toList(),
    };
  }
}

class SurahModel {
  final String name;
  final String audio;
  final int number;

  SurahModel({required this.name, required this.audio, required this.number});

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      name: json['name'] ?? '',
      audio: json['audio'] ?? '',
      number: json['number'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'audio': audio, 'number': number};
  }
}
