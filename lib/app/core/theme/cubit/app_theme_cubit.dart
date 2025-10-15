import 'package:flutter_bloc/flutter_bloc.dart';
import '../../configurations/shared_preferences.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial());

  void changeTheme(ThemeState state) {
    switch (state) {
      case ThemeState.initial:
        if (CacheHelper.getData(key: MyCashKey.theme) != null) {
          if (CacheHelper.getData(key: MyCashKey.theme) == 'light') {
            emit(LightAppTheme());
          } else {
            emit(DarkAppTheme());
          }
        }
        break;
      case ThemeState.light:
        CacheHelper.saveData(key: MyCashKey.theme, value: 'light');
        emit(LightAppTheme());
        break;
      case ThemeState.dark:
        CacheHelper.saveData(key: MyCashKey.theme, value: 'dark');
        emit(DarkAppTheme());
        break;
    }
  }
}
