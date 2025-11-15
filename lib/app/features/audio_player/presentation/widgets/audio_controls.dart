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
    return GestureDetector(
      onTap: () {
        if (hasError) {
          onReplay();
        } else {
          isPlaying ? onPause() : onPlay();
        }
      },
      child: Container(
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
        child: Center(
          child: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
