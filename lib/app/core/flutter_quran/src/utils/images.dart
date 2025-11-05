part of '../flutter_quran_screen.dart';

class Images {
  final surahHeader =
      'lib/app/core/flutter_quran/assets/images/surah_header.png';

  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
