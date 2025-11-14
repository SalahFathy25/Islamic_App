import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/download_service.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final DownloadService _downloadService;

  DownloadCubit(this._downloadService) : super(DownloadInitial());

  Future<void> downloadSurah({
    required String sheikhId,
    required int surahNumber,
    required String surahName,
    required String url,
    required String typeName,
  }) async {
    emit(DownloadProgress(surahNumber, 0, typeName: typeName));

    try {
      final filePath = await _downloadService.downloadSurah(
        sheikhId: sheikhId,
        surahNumber: surahNumber,
        surahName: surahName,
        url: url,
        typeName: typeName,
        onProgress: (received, total) {
          final progress = total > 0 ? (received / total * 100).toInt() : 0;
          emit(DownloadProgress(surahNumber, progress, typeName: typeName));
        },
      );

      emit(DownloadCompleted(surahNumber, filePath, typeName: typeName));
    } catch (e) {
      emit(DownloadError('فشل تحميل السورة: $e'));
    }
  }
}
