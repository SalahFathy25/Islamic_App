import 'package:hive/hive.dart';

part 'downloaded_surah.g.dart';

@HiveType(typeId: 0)
class DownloadedSurah extends HiveObject {
  @HiveField(0)
  String sheikhId;

  @HiveField(1)
  int surahNumber;

  @HiveField(2)
  String surahName;

  @HiveField(3)
  String filePath;

  @HiveField(4)
  String typeName;

  DownloadedSurah({
    required this.sheikhId,
    required this.surahNumber,
    required this.surahName,
    required this.filePath,
    required this.typeName,
  });

  DownloadedSurah copyWith({
    String? sheikhId,
    int? surahNumber,
    String? surahName,
    String? filePath,
    String? typeName,
  }) {
    return DownloadedSurah(
      sheikhId: sheikhId ?? this.sheikhId,
      surahNumber: surahNumber ?? this.surahNumber,
      surahName: surahName ?? this.surahName,
      filePath: filePath ?? this.filePath,
      typeName: typeName ?? this.typeName,
    );
  }
}
