import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/download_service.dart';

part 'download_state.dart';

// download_cubit.dart

class DownloadCubit extends Cubit<DownloadState> {
  final DownloadService _downloadService;

  DownloadCubit(this._downloadService) : super(DownloadInitial());

  Future<void> downloadSurah({
    required String sheikhId,
    required int surahNumber,
    required String surahName,
    required String url,
  }) async {
    emit(DownloadProgress(surahNumber, 0));

    try {
      final filePath = await _downloadService.downloadSurah(
        sheikhId: sheikhId,
        surahNumber: surahNumber,
        surahName: surahName,
        url: url,
        onProgress: (received, total) {
          final progress = total > 0 ? (received / total * 100).toInt() : 0;
          emit(DownloadProgress(surahNumber, progress));
        },
      );

      emit(DownloadCompleted(surahNumber, filePath));
    } catch (e) {
      emit(DownloadError('فشل تحميل السورة: $e'));
    }
  }
}
