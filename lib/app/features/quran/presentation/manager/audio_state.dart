part of 'audio_cubit.dart';

abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioLoading extends AudioState {}

class AudioPlaying extends AudioState {
  final String source; // URL أو file path
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  AudioPlaying({
    required this.source,
    required this.position,
    required this.duration,
    required this.isPlaying,
  });
}

class AudioPaused extends AudioState {} // نضيف ده

class AudioStopped extends AudioState {}

class AudioError extends AudioState {
  final String message;
  AudioError(this.message);
}
