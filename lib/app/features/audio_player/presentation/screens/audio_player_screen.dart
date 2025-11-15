import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../quran/data/models/sheikh_model.dart';
import '../manger/audio_cubit.dart';
import '../widgets/audio_controls.dart';

class AudioPlayerScreen extends StatelessWidget {
  final String surahName;
  final String? audioUrl;
  final String? filePath;
  final SheikhModel sheikh;
  final String typeName;

  const AudioPlayerScreen({
    super.key,
    required this.surahName,
    this.audioUrl,
    this.filePath,
    required this.sheikh,
    required this.typeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'القرآن الكريم',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildAlbumArt(),
              const SizedBox(height: 40),
              _buildSurahInfo(),
              const SizedBox(height: 40),
              Expanded(child: _buildAudioPlayer(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2E3192), Color(0xFF1B1464)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Icon(Icons.menu_book, size: 80, color: Colors.white),
      ),
    );
  }

  Widget _buildSurahInfo() {
    return Column(
      children: [
        Text(
          surahName,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "${sheikh.name} - $typeName",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAudioPlayer(BuildContext context) {
    return BlocConsumer<AudioPlayerCubit, AudioState>(
      listener: (context, state) {
        // Handle any side effects here
      },
      builder: (context, state) {
        final cubit = context.read<AudioPlayerCubit>();
        final isCurrentAudio = cubit.isCurrentAudio(audioUrl, filePath);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress Slider
            _buildProgressSlider(state, isCurrentAudio, cubit),
            const SizedBox(height: 16),

            // Time Display
            _buildTimeDisplay(state),
            const SizedBox(height: 40),

            // Error Message
            if (state is AudioError &&
                (state.source == audioUrl || state.source == filePath))
              _buildErrorMessage(state),

            // Audio Controls
            _buildAudioControls(state, isCurrentAudio, cubit, context),
          ],
        );
      },
    );
  }

  Widget _buildProgressSlider(
    AudioState state,
    bool isCurrentAudio,
    AudioPlayerCubit cubit,
  ) {
    double progress = 0.0;
    Duration duration = Duration.zero;

    if (state is AudioPlaying) {
      progress = state.progress;
      duration = state.duration;
    } else if (state is AudioPaused) {
      progress = state.progress;
      duration = state.duration;
    } else if (state is AudioCompleted) {
      progress = 1.0;
      duration = state.duration;
    }

    final canSeek =
        duration.inMilliseconds > 0 &&
        isCurrentAudio &&
        state is! AudioCompleted;

    return Slider(
      value: progress,
      activeColor: Colors.blue,
      inactiveColor: Colors.grey[800],
      onChanged: canSeek
          ? (value) {
              final newPosition = Duration(
                milliseconds: (duration.inMilliseconds * value).round(),
              );
              cubit.seekAudio(newPosition);
            }
          : null,
    );
  }

  Widget _buildTimeDisplay(AudioState state) {
    Duration position = Duration.zero;
    Duration duration = Duration.zero;

    if (state is AudioPlaying) {
      position = state.position;
      duration = state.duration;
    } else if (state is AudioPaused) {
      position = state.position;
      duration = state.duration;
    } else if (state is AudioCompleted) {
      position = state.duration;
      duration = state.duration;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDuration(position),
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          _formatDuration(duration),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(AudioError state) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: Colors.red, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioControls(
    AudioState state,
    bool isCurrentAudio,
    AudioPlayerCubit cubit,
    BuildContext context,
  ) {
    final isLoading =
        state is AudioLoading &&
        (state.source == audioUrl || state.source == filePath);

    final hasError =
        state is AudioError &&
        (state.source == audioUrl || state.source == filePath);

    final isPlaying = state is AudioPlaying && isCurrentAudio;
    final isCompleted =
        state is AudioCompleted &&
        (state.source == audioUrl || state.source == filePath);

    return Center(
      child: AudioControls(
        isPlaying: isPlaying,
        isLoading: isLoading,
        hasError: hasError,
        onPlay: () {
          if (isCompleted) {
            // Restart completed audio
            _playAudio(cubit, context);
          } else if (isCurrentAudio) {
            // Resume current audio
            cubit.resumeAudio();
          } else {
            // Play new audio
            _playAudio(cubit, context);
          }
        },
        onPause: () => cubit.pauseAudio(),
        onReplay: () => _playAudio(cubit, context),
      ),
    );
  }

  void _playAudio(AudioPlayerCubit cubit, BuildContext context) {
    final sourceType = filePath != null
        ? AudioSourceType.file
        : AudioSourceType.network;
    final source = filePath ?? audioUrl;

    if (source != null) {
      cubit.playAudio(source: source, sourceType: sourceType);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    } else {
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
  }
}
