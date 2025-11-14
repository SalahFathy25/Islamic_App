import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/features/quran/data/models/sheikh_model.dart';
import 'package:islamic_app/app/features/quran/data/models/downloaded_surah.dart';
import 'package:hive/hive.dart';

import '../../../../core/routes/routes.dart';
import '../manager/download_cubit.dart';

class SheikhSurahsScreen extends StatelessWidget {
  final SheikhModel sheikh;
  final String typeName;
  final List<SurahModel> surahs;

  const SheikhSurahsScreen({
    super.key,
    required this.sheikh,
    required this.typeName,
    required this.surahs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$typeName - ${sheikh.name}"),
        centerTitle: true,
      ),
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
          padding: const EdgeInsets.all(12),
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];
            return _SurahCard(surah: surah, sheikh: sheikh, typeName: typeName);
          },
        ),
      ),
    );
  }
}

class _SurahCard extends StatelessWidget {
  final SurahModel surah;
  final SheikhModel sheikh;
  final String typeName;
  late final Box<DownloadedSurah> surahBox;

  _SurahCard({
    required this.surah,
    required this.sheikh,
    required this.typeName,
  }) {
    surahBox = Hive.box<DownloadedSurah>('downloads');
  }

  bool isSurahDownloaded() {
    return surahBox.values.any(
      (s) =>
          s.sheikhId == sheikh.id &&
          s.surahNumber == surah.number &&
          s.typeName == typeName,
    );
  }

  String? getFilePath() {
    final downloaded = surahBox.values.firstWhere(
      (s) =>
          s.sheikhId == sheikh.id &&
          s.surahNumber == surah.number &&
          s.typeName == typeName,
      orElse: () => DownloadedSurah(
        sheikhId: sheikh.id,
        surahNumber: surah.number,
        filePath: '',
        surahName: surah.name,
        typeName: typeName,
      ),
    );
    return downloaded.filePath.isEmpty ? null : downloaded.filePath;
  }

  @override
  Widget build(BuildContext context) {
    final downloaded = isSurahDownloaded();

    return BlocBuilder<DownloadCubit, DownloadState>(
      buildWhen: (previous, current) {
        return (current is DownloadProgress &&
                current.surahNumber == surah.number &&
                current.typeName == typeName) ||
            (current is DownloadCompleted &&
                current.surahNumber == surah.number &&
                current.typeName == typeName);
      },
      builder: (context, downloadState) {
        final isDownloading =
            downloadState is DownloadProgress &&
            downloadState.surahNumber == surah.number &&
            downloadState.typeName == typeName;

        final isDownloaded =
            downloadState is DownloadCompleted &&
            downloadState.surahNumber == surah.number &&
            downloadState.typeName == typeName;

        final showPlayButton = downloaded || isDownloaded;

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue.shade100,
              child: Text(
                '${surah.number}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            title: Text(
              surah.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: isDownloading
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: downloadState.progress / 100,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent,
                        ),
                      ),
                    ),
                  )
                : Text(showPlayButton ? '📁 محملة' : '🌐 اونلاين'),
            trailing: isDownloading
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  )
                : IconButton(
                    icon: Icon(
                      showPlayButton ? Icons.play_arrow : Icons.download,
                      color: showPlayButton ? Colors.green : Colors.blue,
                      size: 28,
                    ),
                    onPressed: () {
                      if (showPlayButton) {
                        final filePath = getFilePath();
                        Navigator.pushNamed(
                          context,
                          Routes.audioPlayerScreen,
                          arguments: {
                            'surahName': surah.name,
                            'audioUrl': surah.audio,
                            'filePath': filePath,
                            'typeName': typeName,
                          },
                        );
                      } else {
                        context.read<DownloadCubit>().downloadSurah(
                          sheikhId: sheikh.id,
                          surahNumber: surah.number,
                          surahName: surah.name,
                          url: surah.audio,
                          typeName: typeName,
                        );
                      }
                    },
                  ),
          ),
        );
      },
    );
  }
}
