import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayerService() {
    _setupErrorHandling();
  }

  void _setupErrorHandling() {
    _audioPlayer.playbackEventStream.listen(
      (event) {},
      onError: (error) {
        // Handle player errors
      },
    );
  }

  // Play from URL
  Future<void> playFromUrl(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (error) {
      throw AudioServiceException('Failed to play from URL: $error');
    }
  }

  // Play from file
  Future<void> playFromFile(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
    } catch (error) {
      throw AudioServiceException('Failed to play from file: $error');
    }
  }

  // Control methods
  Future<void> play() async => await _audioPlayer.play();

  Future<void> pause() async => await _audioPlayer.pause();

  Future<void> stop() async => await _audioPlayer.stop();

  Future<void> seek(Duration position) async =>
      await _audioPlayer.seek(position);

  // Streams
  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  // Getters
  Duration get position => _audioPlayer.position;

  PlayerState get playerState => _audioPlayer.playerState;

  // Dispose
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
