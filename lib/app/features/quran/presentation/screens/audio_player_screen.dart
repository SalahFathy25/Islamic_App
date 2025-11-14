import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/audio_cubit.dart';

class AudioPlayerScreen extends StatelessWidget {
  final String surahName;
  final String? audioUrl;
  final String? filePath;

  const AudioPlayerScreen({
    super.key,
    required this.surahName,
    this.audioUrl,
    this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surahName),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<AudioCubit, AudioState>(
          builder: (context, state) {
            final cubit = context.read<AudioCubit>();
            final isCurrentAudio = _isCurrentAudio(state, audioUrl, filePath);

            return Column(
              children: [
                // صورة الألبوم أو أيقونة
                _buildAlbumArt(),

                const SizedBox(height: 40),

                // اسم السورة
                Text(
                  surahName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // اسم الشيخ (إذا عندك)
                Text(
                  'تلاوة قرآنية',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),

                const SizedBox(height: 40),

                // شريط التقدم
                _buildProgressBar(state, isCurrentAudio),

                const SizedBox(height: 20),

                // وقت التشغيل والوقت المتبقي
                _buildTimeInfo(state, isCurrentAudio),

                const SizedBox(height: 40),

                // أزرار التحكم
                _buildControlButtons(cubit, state, isCurrentAudio),

                const SizedBox(height: 20),

                // حالة التشغيل
                _buildStatusText(state, isCurrentAudio),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Icon(Icons.music_note, size: 80, color: Colors.grey[600]),
    );
  }

  Widget _buildProgressBar(AudioState state, bool isCurrentAudio) {
    return Column(
      children: [
        // شريط التقدم
        Slider(
          value: 0.3, // هنا هتحتاج تحسب النسبة الفعلية
          onChanged: (value) {
            // ممكن نضيف seek functionality
          },
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildTimeInfo(AudioState state, bool isCurrentAudio) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '0:00', // الوقت الحالي
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        Text(
          '5:30', // الوقت الكلي
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildControlButtons(
    AudioCubit cubit,
    AudioState state,
    bool isCurrentAudio,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // زر التكرار
        IconButton(
          icon: Icon(Icons.repeat, color: Colors.grey[600], size: 30),
          onPressed: () {
            // خاصية التكرار
          },
        ),

        const SizedBox(width: 20),

        // زر الرجوع للخلف
        IconButton(
          icon: Icon(Icons.skip_previous, color: Colors.grey[800], size: 40),
          onPressed: () {
            // السورة السابقة
          },
        ),

        const SizedBox(width: 20),

        // زر التشغيل/الإيقاف
        Container(
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
              isCurrentAudio && state is AudioPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {
              if (isCurrentAudio && state is AudioPlaying) {
                cubit.pause();
              } else {
                if (filePath != null) {
                  cubit.playOffline(filePath!);
                } else if (audioUrl != null) {
                  cubit.playOnline(audioUrl!);
                }
              }
            },
          ),
        ),

        const SizedBox(width: 20),

        // زر التقدم للأمام
        IconButton(
          icon: Icon(Icons.skip_next, color: Colors.grey[800], size: 40),
          onPressed: () {
            // السورة التالية
          },
        ),

        const SizedBox(width: 20),

        // زر القائمة
        IconButton(
          icon: Icon(Icons.playlist_play, color: Colors.grey[600], size: 30),
          onPressed: () {
            // قائمة التشغيل
          },
        ),
      ],
    );
  }

  Widget _buildStatusText(AudioState state, bool isCurrentAudio) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _getStatusText(state, isCurrentAudio),
        style: TextStyle(color: Colors.grey[700], fontSize: 14),
      ),
    );
  }

  bool _isCurrentAudio(AudioState state, String? audioUrl, String? filePath) {
    if (state is AudioPlaying) {
      return state.source == audioUrl || state.source == filePath;
    }
    return false;
  }

  String _getStatusText(AudioState state, bool isCurrentAudio) {
    if (!isCurrentAudio) return '🎵 اضغط تشغيل للبدء';

    if (state is AudioPlaying) return '🔊 مشغّل الآن';
    if (state is AudioPaused) return '⏸ متوقف مؤقتاً';
    if (state is AudioStopped) return '⏹ توقف';
    if (state is AudioLoading) return '⏳ جاري تحميل الصوت...';
    return '🎵 اضغط تشغيل';
  }
}
