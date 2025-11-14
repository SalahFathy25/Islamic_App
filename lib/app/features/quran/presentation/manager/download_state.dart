part of 'download_cubit.dart';

abstract class DownloadState {}

class DownloadInitial extends DownloadState {}

class DownloadProgress extends DownloadState {
  final int surahNumber;
  final int progress;

  DownloadProgress(this.surahNumber, this.progress);
}

class DownloadCompleted extends DownloadState {
  final int surahNumber;
  final String filePath;

  DownloadCompleted(this.surahNumber, this.filePath);
}

class DownloadError extends DownloadState {
  final String message;

  DownloadError(this.message);
}
