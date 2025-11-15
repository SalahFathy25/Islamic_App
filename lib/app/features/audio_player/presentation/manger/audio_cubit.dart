// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:just_audio/just_audio.dart';
//
// import '../../data/services/audio_player_service.dart';
//
// part 'audio_state.dart';
//
// class AudioCubit extends Cubit<AudioState> {
//   final AudioPlayerService _playerService;
//   String? _currentSource;
//   String? _lastCompletedSource;
//
//   StreamSubscription<Duration>? _positionSub;
//   StreamSubscription<Duration?>? _durationSub;
//   StreamSubscription<PlayerState>? _playerStateSub;
//
//   Duration _currentDuration = Duration.zero;
//   bool _isOperationInProgress = false;
//
//   AudioCubit(this._playerService) : super(AudioInitial());
//
//   Future<void> _listenToPlayer(String source) async {
//     await _cancelSubscriptions();
//
//     _currentSource = source;
//
//     // Duration stream
//     _durationSub = _playerService.durationStream.listen((d) {
//       _currentDuration = d ?? Duration.zero;
//       _emitStateForCurrentSource();
//     });
//
//     // Position stream
//     _positionSub = _playerService.positionStream.listen((pos) {
//       _emitStateForCurrentSource();
//     });
//
//     // Player state stream
//     _playerStateSub = _playerService.playerStateStream.listen((state) {
//       final processing = state.processingState;
//       final playing = state.playing;
//
//       if (processing == ProcessingState.completed) {
//         _handleCompletion();
//       } else if (processing == ProcessingState.ready) {
//         _emitStateForCurrentSource();
//       } else if (processing == ProcessingState.idle) {
//         emit(AudioStopped());
//         _currentSource = null;
//       }
//     });
//
//     _emitStateForCurrentSource();
//   }
//
//   void _handleCompletion() {
//     _lastCompletedSource = _currentSource;
//     emit(
//       AudioStoppedWithPosition(
//         lastSource: _currentSource ?? '',
//         duration: _currentDuration,
//       ),
//     );
//     _currentSource = null;
//     _cancelSubscriptions();
//   }
//
//   void _emitStateForCurrentSource() {
//     final src = _currentSource;
//     if (src == null) return;
//
//     final playing = _playerService.playerState.playing;
//     final pos = _playerService.position;
//     final dur = _currentDuration;
//
//     if (playing) {
//       emit(
//         AudioPlaying(
//           source: src,
//           position: pos,
//           duration: dur,
//           isPlaying: true,
//         ),
//       );
//     } else {
//       emit(
//         AudioPaused(
//           source: src,
//           position: pos,
//           duration: dur,
//           isPlaying: false,
//         ),
//       );
//     }
//   }
//
//   Future<void> _cancelSubscriptions() async {
//     await _positionSub?.cancel();
//     await _durationSub?.cancel();
//     await _playerStateSub?.cancel();
//
//     _positionSub = null;
//     _durationSub = null;
//     _playerStateSub = null;
//   }
//
//   Future<void> _stopAndReset() async {
//     await _cancelSubscriptions();
//     _currentSource = null;
//     _currentDuration = Duration.zero;
//     await _playerService.stop();
//   }
//
//   Future<void> playOnline(String url) async {
//     if (_isOperationInProgress) return;
//     _isOperationInProgress = true;
//
//     try {
//       // If same source is paused, resume it
//       if (_currentSource == url &&
//           _playerService.playerState.processingState == ProcessingState.ready &&
//           !_playerService.playerState.playing) {
//         await resume();
//         return;
//       }
//
//       // Reset completion state if replaying
//       if (_lastCompletedSource == url) {
//         _lastCompletedSource = null;
//       }
//
//       emit(AudioLoading(source: url));
//       await _stopAndReset();
//       await _playerService.playFromUrl(url);
//       await _listenToPlayer(url);
//     } catch (e) {
//       await _cancelSubscriptions();
//       emit(AudioError("فشل التشغيل: $e", source: url));
//       _currentSource = null;
//     } finally {
//       _isOperationInProgress = false;
//     }
//   }
//
//   Future<void> playOffline(String file) async {
//     if (_isOperationInProgress) return;
//     _isOperationInProgress = true;
//
//     try {
//       if (_currentSource == file &&
//           _playerService.playerState.processingState == ProcessingState.ready &&
//           !_playerService.playerState.playing) {
//         await resume();
//         return;
//       }
//
//       if (_lastCompletedSource == file) {
//         _lastCompletedSource = null;
//       }
//
//       emit(AudioLoading(source: file));
//       await _stopAndReset();
//       await _playerService.playFromFile(file);
//       await _listenToPlayer(file);
//     } catch (e) {
//       await _cancelSubscriptions();
//       emit(AudioError("فشل التشغيل: $e", source: file));
//       _currentSource = null;
//     } finally {
//       _isOperationInProgress = false;
//     }
//   }
//
//   Future<void> pause() async {
//     try {
//       await _playerService.pause();
//       // State will be updated via stream listeners
//     } catch (e) {
//       emit(AudioError("فشل في الإيقاف المؤقت: $e", source: _currentSource));
//     }
//   }
//
//   Future<void> resume() async {
//     try {
//       await _playerService.play();
//       // State will be updated via stream listeners
//     } catch (e) {
//       emit(AudioError("فشل في استئناف التشغيل: $e", source: _currentSource));
//     }
//   }
//
//   Future<void> stop() async {
//     try {
//       await _stopAndReset();
//       emit(AudioStopped());
//     } catch (e) {
//       emit(AudioError("فشل في الإيقاف: $e"));
//     }
//   }
//
//   Future<void> seek(Duration position) async {
//     try {
//       await _playerService.seek(position);
//       // State will be updated via stream listeners
//     } catch (e) {
//       emit(
//         AudioError(
//           "فشل في الانتقال إلى الوقت المحدد: $e",
//           source: _currentSource,
//         ),
//       );
//     }
//   }
//
//   bool isCurrentAudio(String? audioUrl, String? filePath) {
//     return _currentSource == audioUrl || _currentSource == filePath;
//   }
//
//   bool hasCompleted(String? audioUrl, String? filePath) {
//     return _lastCompletedSource == audioUrl || _lastCompletedSource == filePath;
//   }
//
//   String? get currentSource => _currentSource;
//   String? get lastCompletedSource => _lastCompletedSource;
//
//   @override
//   Future<void> close() async {
//     await _cancelSubscriptions();
//     return super.close();
//   }
// }

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../data/services/audio_player_service.dart';

part 'audio_state.dart';

class AudioPlayerCubit extends Cubit<AudioState> {
  final AudioPlayerService _audioService;

  String? _currentSource;
  Duration _currentDuration = Duration.zero;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;

  AudioPlayerCubit({required AudioPlayerService audioService})
    : _audioService = audioService,
      super(const AudioInitial());

  // Public methods
  Future<void> playAudio({
    required String source,
    required AudioSourceType sourceType,
  }) async {
    if (_currentSource == source && _isAudioReadyToPlay) {
      await _resumeAudio();
      return;
    }

    await _stopSubscriptions();
    emit(AudioLoading(source: source));
    _currentSource = source;

    try {
      switch (sourceType) {
        case AudioSourceType.network:
          await _audioService.playFromUrl(source);
          break;
        case AudioSourceType.file:
          await _audioService.playFromFile(source);
          break;
      }

      await _startSubscriptions(source);
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

  Future<void> resumeAudio() async {
    if (_currentSource == null) return;

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

  Future<void> stopAudio() async {
    await _stopSubscriptions();
    _currentSource = null;
    _currentDuration = Duration.zero;

    try {
      await _audioService.stop();
      emit(const AudioStopped());
    } catch (error) {
      emit(AudioError(message: 'Failed to stop audio: $error'));
    }
  }

  // Helper methods
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
        // Handle buffering if needed
        break;
      case ProcessingState.loading:
        // Handle loading if needed
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

  // Getters
  bool isCurrentAudio(String? audioUrl, String? filePath) {
    return _currentSource == audioUrl || _currentSource == filePath;
  }

  @override
  Future<void> close() async {
    await _stopSubscriptions();
    super.close();
  }
}

enum AudioSourceType { network, file }
