import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayerService() {
    _setupErrorHandling();
  }

  void _setupErrorHandling() {
    _audioPlayer.playbackEventStream.listen((event) {}, onError: (error) {});
  }

  // Future<void> playFromUrl(String url) async {
  //   try {
  //     await _audioPlayer.setUrl(url);
  //     await _audioPlayer.play();
  //   } catch (error) {
  //     throw AudioServiceException('Failed to play from URL: $error');
  //   }
  // }

  Future<Duration> setFilePath(String filePath) async {
    try {
      final duration = await _audioPlayer.setFilePath(filePath);
      return duration ?? Duration.zero;
    } catch (error) {
      throw AudioServiceException('Failed to set file path: $error');
    }
  }

  Future<void> play() async => await _audioPlayer.play();

  Future<void> pause() async => await _audioPlayer.pause();

  Future<void> stop() async => await _audioPlayer.stop();

  Future<void> seek(Duration position) async =>
      await _audioPlayer.seek(position);

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  Duration get position => _audioPlayer.position;

  PlayerState get playerState => _audioPlayer.playerState;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}

class AudioServiceException implements Exception {
  final String message;

  AudioServiceException(this.message);

  @override
  String toString() => 'AudioServiceException: $message';
}
