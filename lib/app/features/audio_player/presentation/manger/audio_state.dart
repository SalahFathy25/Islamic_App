part of 'audio_cubit.dart';

abstract class AudioState {
  const AudioState();
}

class AudioInitial extends AudioState {
  const AudioInitial();
}

// class AudioLoading extends AudioState {
//   final String source;
//   const AudioLoading({required this.source});
// }

class AudioPlaying extends AudioState {
  final String source;
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  const AudioPlaying({
    required this.source,
    required this.position,
    required this.duration,
    required this.isPlaying,
  });

  double get progress {
    if (duration.inMilliseconds == 0) return 0.0;
    return (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
  }
}

class AudioPaused extends AudioState {
  final String source;
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  const AudioPaused({
    required this.source,
    required this.position,
    required this.duration,
    required this.isPlaying,
  });

  double get progress {
    if (duration.inMilliseconds == 0) return 0.0;
    return (position.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
  }
}

class AudioCompleted extends AudioState {
  final String source;
  final Duration duration;

  const AudioCompleted({required this.source, required this.duration});
}

class AudioError extends AudioState {
  final String message;
  final String? source;

  const AudioError({required this.message, this.source});
}

class AudioStopped extends AudioState {
  const AudioStopped();
}
