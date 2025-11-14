class SheikhModel {
  final String id;
  final String name;
  final String sheikhImage;
  final Map<String, RecitationType> types;

  SheikhModel({
    required this.id,
    required this.name,
    required this.sheikhImage,
    required this.types,
  });

  factory SheikhModel.fromDoc(String id, Map<String, dynamic> json) {
    final typesRaw = json['type'] as Map<String, dynamic>? ?? {};
    final types = typesRaw.map((key, value) {
      return MapEntry(key, RecitationType.fromJson(key, value));
    });

    return SheikhModel(
      id: id,
      name: json['name'] ?? '',
      sheikhImage: json['sheikhImage'] ?? '',
      types: types,
    );
  }

  factory SheikhModel.fromJson(Map<String, dynamic> json, String docId) {
    final typesRaw = json['type'] as Map<String, dynamic>? ?? {};
    final types = typesRaw.map((key, value) {
      return MapEntry(key, RecitationType.fromJson(key, value));
    });

    return SheikhModel(
      id: docId,
      name: json['name'] ?? '',
      sheikhImage: json['sheikhImage'] ?? '',
      types: types,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sheikhImage': sheikhImage,
      'type': types.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class RecitationType {
  final String name;
  final List<SurahModel> surahs;

  RecitationType({required this.name, required this.surahs});

  factory RecitationType.fromJson(String typeName, dynamic json) {
    final surahsRaw = json['surahs'] as List<dynamic>? ?? [];
    final surahs = surahsRaw
        .map((e) => SurahModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return RecitationType(name: typeName, surahs: surahs);
  }

  Map<String, dynamic> toJson() {
    return {'surahs': surahs.map((e) => e.toJson()).toList()};
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
      number: json['number'] is int
          ? json['number']
          : int.tryParse(json['number'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'audio': audio, 'number': number};
  }
}
