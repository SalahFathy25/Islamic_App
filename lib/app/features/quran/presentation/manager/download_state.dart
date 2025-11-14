part of 'download_cubit.dart';

abstract class DownloadState {}

class DownloadInitial extends DownloadState {}

class DownloadProgress extends DownloadState {
  final int surahNumber;
  final int progress;
  final String typeName;

  DownloadProgress(this.surahNumber, this.progress, {required this.typeName});
}

class DownloadCompleted extends DownloadState {
  final int surahNumber;
  final String filePath;
  final String typeName;

  DownloadCompleted(this.surahNumber, this.filePath, {required this.typeName});
}

class DownloadError extends DownloadState {
  final String message;

  DownloadError(this.message);
}
