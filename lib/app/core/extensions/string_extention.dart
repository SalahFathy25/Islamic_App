extension StringExtension on String? {
  // null or empty
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);

}