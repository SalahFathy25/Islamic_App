import 'package:hive/hive.dart';
part 'downloaded_surah.g.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs


@HiveType(typeId: 0)
class DownloadedSurah extends HiveObject {
  @HiveField(0)
  String sheikhId;

  @HiveField(1)
  int surahNumber;

  @HiveField(2)
  String surahName;

  @HiveField(3)
  String filePath; // local path

  DownloadedSurah({
    required this.sheikhId,
    required this.surahNumber,
    required this.surahName,
    required this.filePath,
  });
}
