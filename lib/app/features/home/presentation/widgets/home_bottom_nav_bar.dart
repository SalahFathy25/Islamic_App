import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/core/routes/navigation.dart';
import 'package:islamic_app/app/core/routes/routes.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';
import '../../../../../gen/assets.gen.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 24.0.w),
      margin: EdgeInsets.only(right: 24.0.w, left: 24.0.w, bottom: 24.0.h),
      height: 95.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0.r),
        color: AppColors.mainColor.withValues(alpha: 0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            offset: const Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          titles.length,
          (index) => GestureDetector(
            onTap: () {
              CustomNavigator.instance.pushNamed(screens[index]);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icons[index],
                8.isHeight,
                Text(titles[index], style: AppFontStyle.fontAlmarai10w400White),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final List<String> screens = [
  Routes.quranScreen,
  Routes.prayerScreen,
  Routes.azkarScreen,
  Routes.qiblaScreen,
];

final List<String> titles = ["المصحف", "الصلاة", "الأذكار", "القبلة"];

final List<Widget> icons = [
  Assets.images.icons.quranIcon.svg(width: 40.w, height: 40.h),
  Assets.images.icons.prayerIcon.svg(width: 40.w, height: 40.h),
  Assets.images.icons.azkaarIcon.svg(width: 40.w, height: 40.h),
  Assets.images.icons.qiblaIcon.svg(width: 40.w, height: 40.h),
];
