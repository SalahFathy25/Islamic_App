// lib/features/audio_player/presentation/widgets/audio_controls.dart
import 'package:flutter/material.dart';

class AudioControls extends StatelessWidget {
  final bool isPlaying;
  final bool hasError;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onReplay;

  const AudioControls({
    super.key,
    required this.isPlaying,
    required this.hasError,
    required this.onPlay,
    required this.onPause,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
          size: 50,
        ),
        onPressed: () {
          if (hasError) {
            onReplay();
          } else {
            isPlaying ? onPause() : onPlay();
          }
        },
      ),
    );
  }
}
