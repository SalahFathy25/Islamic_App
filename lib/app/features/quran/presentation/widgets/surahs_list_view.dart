import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import '../../data/models/surah_item_model.dart';

import '../../data/repos/surah_services.dart';
import 'surah_item.dart';

class SurahsListView extends StatefulWidget {
  const SurahsListView({super.key});

  @override
  State<SurahsListView> createState() => _SurahsListViewState();
}

class _SurahsListViewState extends State<SurahsListView> {
  List<SurahItemModel> surahs = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await SurahRepo.loadSurahs();
    setState(() {
      surahs = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: surahs.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return 8.isHeight;
        },
        itemBuilder: (context, index) {
          final surah = surahs[index];
          return SurahItem(
            surahNumber: surah.surahNumber,
            surahName: surah.surahName,
            type: surah.type,
            ayahNumbers: surah.ayahNumbers,
          );
        },
      ),
    );
  }
}
