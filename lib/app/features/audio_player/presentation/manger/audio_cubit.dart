import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/services/audio_player_service.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayerService _audioService;

  String? _currentSource;
  Duration _currentDuration = Duration.zero;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  AudioCubit({required AudioPlayerService audioService})
    : _audioService = audioService,
      super(const AudioInitial());

  Future<void> playAudio({
    required String source,
    required AudioSourceType sourceType,
  }) async {
    if (_currentSource == source && _isAudioReadyToPlay) {
      await _resumeAudio();
      return;
    }

    await _stopSubscriptions();
    _currentSource = source;

    try {
      Duration duration = Duration.zero;

      switch (sourceType) {
        case AudioSourceType.file:
          duration = await _audioService.setFilePath(source);
          break;
      }

      _currentDuration = duration;

      await _startSubscriptions(source);

      await _audioService.play();

      _emitCurrentState(source);
    } catch (error) {
      emit(AudioError(message: 'Failed to play audio: $error', source: source));
      _currentSource = null;
    }
  }

  Future<void> pauseAudio() async {
    if (_currentSource == null) return;

    try {
      await _audioService.pause();
    } catch (error) {
      emit(
        AudioError(
          message: 'Failed to pause audio: $error',
          source: _currentSource,
        ),
      );
    }
  }

  // Future<void> resumeAudio() async {
  //   if (_currentSource == null) return;
  //
  //   try {
  //     await _audioService.play();
  //   } catch (error) {
  //     emit(
  //       AudioError(
  //         message: 'Failed to resume audio: $error',
  //         source: _currentSource,
  //       ),
  //     );
  //   }
  // }

  Future<void> seekAudio(Duration position) async {
    if (_currentSource == null) return;

    try {
      await _audioService.seek(position);
    } catch (error) {
      emit(
        AudioError(
          message: 'Failed to seek audio: $error',
          source: _currentSource,
        ),
      );
    }
  }

  // Future<void> stopAudio() async {
  //   await _stopSubscriptions();
  //   _currentSource = null;
  //   _currentDuration = Duration.zero;
  //
  //   try {
  //     await _audioService.stop();
  //     emit(const AudioStopped());
  //   } catch (error) {
  //     emit(AudioError(message: 'Failed to stop audio: $error'));
  //   }
  // }

  Future<void> _startSubscriptions(String source) async {
    _durationSubscription = _audioService.durationStream.listen((duration) {
      _currentDuration = duration ?? Duration.zero;
      _emitCurrentState(source);
    });

    _positionSubscription = _audioService.positionStream.listen((_) {
      _emitCurrentState(source);
    });

    _playerStateSubscription = _audioService.playerStateStream.listen((state) {
      _handlePlayerStateChange(state, source);
    });
  }

  void _handlePlayerStateChange(PlayerState state, String source) {
    switch (state.processingState) {
      case ProcessingState.completed:
        emit(AudioCompleted(source: source, duration: _currentDuration));
        _currentSource = null;
        _stopSubscriptions();
        break;
      case ProcessingState.ready:
        _emitCurrentState(source);
        break;
      case ProcessingState.idle:
        emit(const AudioStopped());
        _currentSource = null;
        _stopSubscriptions();
        break;
      case ProcessingState.buffering:
        break;
      case ProcessingState.loading:
        break;
    }
  }

  void _emitCurrentState(String source) {
    final position = _audioService.position;
    final isPlaying = _audioService.playerState.playing;

    if (isPlaying) {
      emit(
        AudioPlaying(
          source: source,
          position: position,
          duration: _currentDuration,
          isPlaying: true,
        ),
      );
    } else {
      emit(
        AudioPaused(
          source: source,
          position: position,
          duration: _currentDuration,
          isPlaying: false,
        ),
      );
    }
  }

  Future<void> _resumeAudio() async {
    try {
      await _audioService.play();
    } catch (error) {
      emit(
        AudioError(
          message: 'Failed to resume audio: $error',
          source: _currentSource,
        ),
      );
    }
  }

  bool get _isAudioReadyToPlay {
    final state = _audioService.playerState;
    return state.processingState == ProcessingState.ready && !state.playing;
  }

  Future<void> _stopSubscriptions() async {
    await _positionSubscription?.cancel();
    await _durationSubscription?.cancel();
    await _playerStateSubscription?.cancel();

    _positionSubscription = null;
    _durationSubscription = null;
    _playerStateSubscription = null;
  }

  bool isCurrentAudio(String? audioUrl, String? filePath) {
    return _currentSource == audioUrl || _currentSource == filePath;
  }

  @override
  Future<void> close() async {
    await _stopSubscriptions();
    super.close();
  }
}

enum AudioSourceType { file }
