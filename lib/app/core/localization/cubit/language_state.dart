part of 'language_cubit.dart';

enum Languages { initial, en, ar }

sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageChanged extends LanguageState {
  final String? languageCode;
  LanguageChanged({this.languageCode});
}
