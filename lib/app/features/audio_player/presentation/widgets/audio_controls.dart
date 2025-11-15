// lib/features/audio_player/presentation/widgets/audio_controls.dart
import 'package:flutter/material.dart';

class AudioControls extends StatelessWidget {
  final bool isPlaying;
  final bool isLoading;
  final bool hasError;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onReplay;

  const AudioControls({
    super.key,
    required this.isPlaying,
    required this.isLoading,
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: Icon(_getIcon(), color: Colors.white, size: 50),
            onPressed: isLoading ? null : _getOnPressed(),
          ),
          if (isLoading)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    if (hasError) return Icons.error;
    if (isLoading) return Icons.music_note;
    return isPlaying ? Icons.pause : Icons.play_arrow;
  }

  VoidCallback? _getOnPressed() {
    if (hasError) return onReplay;
    return isPlaying ? onPause : onPlay;
  }
}
