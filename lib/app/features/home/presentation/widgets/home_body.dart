import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/features/home/data/models/shortcut_item_model.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/daily_task_container.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/doaas_list_view.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/prayer_container.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/shortcuts_list_view.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/section_title.dart';
import 'shortcut_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrayerContainer(),
          SectionTitle(title: AppStrings.shortcuts),
          ShortcutsListView(),
          SectionTitle(title: AppStrings.dailyTaskTitle),
          DailyTaskContainer(),
          SectionTitle(title: AppStrings.doaasTitle),
          DoaasListView(),
          16.isHeight,
        ],
      ),
    );
  }
}
