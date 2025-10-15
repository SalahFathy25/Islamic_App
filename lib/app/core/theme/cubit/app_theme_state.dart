part of 'app_theme_cubit.dart';

enum ThemeState { initial, light, dark }

sealed class AppThemeState {}

final class AppThemeInitial extends AppThemeState {}

final class LightAppTheme extends AppThemeState {}

final class DarkAppTheme extends AppThemeState {}
