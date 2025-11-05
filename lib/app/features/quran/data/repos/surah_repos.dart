import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surah_item_model.dart';

class SurahRepo {
  static Future<List<SurahItemModel>> loadSurahs() async {
    final String response = await rootBundle.loadString(
      'assets/jsons/surahs.json',
    );
    final List data = json.decode(response);
    return data
        .map(
          (e) => SurahItemModel(
            surahNumber: e['surahNumber'],
            surahName: e['surahName'],
            type: e['type'],
            ayahNumbers: e['ayahNumbers'],
          ),
        )
        .toList();
  }
}
