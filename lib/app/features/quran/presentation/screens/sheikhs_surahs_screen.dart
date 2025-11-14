import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/features/quran/data/models/sheikh_model.dart';
import 'package:islamic_app/app/features/quran/data/models/downloaded_surah.dart';
import 'package:hive/hive.dart';

import '../../../../core/routes/routes.dart';
import '../manager/download_cubit.dart';

class SheikhSurahsScreen extends StatelessWidget {
  final SheikhModel sheikh;

  const SheikhSurahsScreen({super.key, required this.sheikh});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sheikh.name)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DownloadCubit, DownloadState>(
            listener: (context, state) {
              if (state is DownloadError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
        child: ListView.builder(
          itemCount: sheikh.surahs.length,
          itemBuilder: (context, index) {
            final surah = sheikh.surahs[index];
            return _SurahListItem(surah: surah, sheikh: sheikh);
          },
        ),
      ),
    );
  }
}

class _SurahListItem extends StatelessWidget {
  final SurahModel surah;
  final SheikhModel sheikh;
  late final Box<DownloadedSurah> surahBox;

  _SurahListItem({required this.surah, required this.sheikh}) {
    surahBox = Hive.box<DownloadedSurah>('downloads');
  }

  // دالة علشان نتحقق إذا كانت محملة
  bool isSurahDownloaded() {
    return surahBox.values.any(
      (s) => s.sheikhId == sheikh.id && s.surahNumber == surah.number,
    );
  }

  // دالة علشان نجيب المسار
  String? getFilePath() {
    final downloaded = surahBox.values.firstWhere(
      (s) => s.sheikhId == sheikh.id && s.surahNumber == surah.number,
      // orElse: () => null, // نضيف الـ orElse
    );
    return downloaded.filePath;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadCubit, DownloadState>(
      buildWhen: (previous, current) {
        return current is DownloadProgress &&
                current.surahNumber == surah.number ||
            current is DownloadCompleted && current.surahNumber == surah.number;
      },
      builder: (context, downloadState) {
        final isDownloading =
            downloadState is DownloadProgress &&
            downloadState.surahNumber == surah.number;
        final isDownloaded =
            downloadState is DownloadCompleted &&
            downloadState.surahNumber == surah.number;

        return ListTile(
          leading: CircleAvatar(child: Text('${surah.number}')),
          title: Text(surah.name),
          subtitle: isDownloading
              ? LinearProgressIndicator(value: downloadState.progress / 100)
              : Text(isDownloaded ? '📁 محملة' : '🌐 اونلاين'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isDownloaded && !isDownloading)
                IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    context.read<DownloadCubit>().downloadSurah(
                      sheikhId: sheikh.id,
                      surahNumber: surah.number,
                      surahName: surah.name,
                      url: surah.audio,
                    );
                  },
                ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  final filePath = getFilePath();
                  Navigator.pushNamed(
                    context,
                    Routes.audioPlayerScreen,
                    arguments: {
                      'surahName': surah.name,
                      'audioUrl': surah.audio,
                      'filePath': filePath,
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
