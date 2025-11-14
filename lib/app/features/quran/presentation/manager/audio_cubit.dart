import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../data/services/audio_player_service.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayerService _playerService;

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  Duration _duration = Duration.zero;

  AudioCubit(this._playerService) : super(AudioInitial());

  Future<void> _listenToPlayer(String src) async {
    // Cancel old listeners
    await _positionSub?.cancel();
    await _durationSub?.cancel();
    await _playerStateSub?.cancel();

    // listen to duration
    _durationSub = _playerService.durationStream.listen((d) {
      if (d != null) _duration = d;
    });

    // position updates
    _positionSub = _playerService.positionStream.listen((pos) {
      final playing = _playerService.playerState.playing;

      emit(
        AudioPlaying(
          source: src,
          position: pos,
          duration: _duration,
          isPlaying: playing,
        ),
      );
    });

    // play/pause listener
    _playerStateSub = _playerService.playerStateStream.listen((state) {
      final processing = state.processingState;
      final playing = state.playing;

      if (processing == ProcessingState.completed) {
        emit(AudioStopped());
      } else if (!playing) {
        emit(AudioPaused());
      }
    });
  }

  // ----- play online -----
  Future<void> playOnline(String url) async {
    emit(AudioLoading());
    try {
      await _playerService.playFromUrl(url);
      await _listenToPlayer(url);
    } catch (e) {
      emit(AudioError("فشل التشغيل: $e"));
    }
  }

  // ----- play offline -----
  Future<void> playOffline(String file) async {
    emit(AudioLoading());
    try {
      await _playerService.playFromFile(file);
      await _listenToPlayer(file);
    } catch (e) {
      emit(AudioError("فشل التشغيل: $e"));
    }
  }

  Future<void> pause() async {
    await _playerService.pause();
  }

  Future<void> resume() async {
    await _playerService.play(); // JustAudio resume
  }

  Future<void> stop() async {
    await _playerService.stop();
    emit(AudioStopped());
  }

  @override
  Future<void> close() async {
    await _positionSub?.cancel();
    await _durationSub?.cancel();
    await _playerStateSub?.cancel();
    _playerService.dispose();
    return super.close();
  }
}
