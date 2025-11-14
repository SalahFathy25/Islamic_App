import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import '../models/downloaded_surah.dart';

class DownloadService {
  final Dio _dio = Dio();
  final Box<DownloadedSurah> box = Hive.box<DownloadedSurah>('downloads');

  Future<String> _getSheikhDir(String sheikhId) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$sheikhId';
    final folder = Directory(path);
    if (!await folder.exists()) await folder.create(recursive: true);
    return path;
  }

  Future<DownloadedSurah?> getDownloaded(
    int surahNumber,
    String sheikhId,
  ) async {
    return box.get('$sheikhId-$surahNumber');
  }

  Future<String> downloadSurah({
    required String sheikhId,
    required int surahNumber,
    required String surahName,
    required String url,
    required void Function(int received, int total) onProgress,
  }) async {
    final dirPath = await _getSheikhDir(sheikhId);
    final filePath = '$dirPath/${surahNumber.toString().padLeft(3, '0')}.mp3';
    final file = File(filePath);

    if (await file.exists()) {
      return filePath; // نرجع المسار إذا الملف موجود
    }

    await _dio.download(url, filePath, onReceiveProgress: onProgress);

    final downloaded = DownloadedSurah(
      sheikhId: sheikhId,
      surahNumber: surahNumber,
      surahName: surahName,
      filePath: filePath,
    );
    await box.put('$sheikhId-$surahNumber', downloaded);

    return filePath; // نرجع المسار بعد التحميل
  }

  List<DownloadedSurah> getAllDownloadsForSheikh(String sheikhId) {
    return box.values.where((d) => d.sheikhId == sheikhId).toList();
  }
}
