import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _player = AudioPlayer();

  // تشغيل من URL
  Future<void> playFromUrl(String url) async {
    await _player.setUrl(url);
    await _player.play();
  }

  // تشغيل من ملف
  Future<void> playFromFile(String filePath) async {
    await _player.setFilePath(filePath);
    await _player.play();
  }

  // تشغيل (resume)
  Future<void> play() async => _player.play();

  // إيقاف مؤقت
  Future<void> pause() async => _player.pause();

  // Stop
  Future<void> stop() async => _player.stop();

  // getter للحالة الحالية
  PlayerState get playerState => _player.playerState;

  // stream لحالات المشغل
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  // stream للـ position
  Stream<Duration> get positionStream => _player.positionStream;

  // stream لمدة الملف
  Stream<Duration?> get durationStream => _player.durationStream;

  void dispose() => _player.dispose();
}
