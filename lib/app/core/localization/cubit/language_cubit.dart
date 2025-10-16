import 'package:flutter_bloc/flutter_bloc.dart';

import '../../configurations/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  Future<void> initialize() async {
    final savedLanguage = CacheHelper.getData(key: MyCashKey.lang);
    final language = savedLanguage;
    emit(LanguageChanged(languageCode: language));
  }

  void changeLanguage(Languages languages) async {
    if (state is LanguageInitial) {
      await initialize();
    }
    switch (languages) {
      case Languages.initial:
        initialize();
        break;
      case Languages.en:
        CacheHelper.saveData(key: MyCashKey.lang, value: 'en');
        emit(LanguageChanged(languageCode: 'en'));
        break;
      case Languages.ar:
        CacheHelper.saveData(key: MyCashKey.lang, value: 'ar');
        emit(LanguageChanged(languageCode: 'ar'));
        break;
    }
  }
}
