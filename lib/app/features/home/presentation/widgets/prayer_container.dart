import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/core/helper/size_config_helper.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/app_strings.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';
import 'package:islamic_app/gen/assets.gen.dart';

class PrayerContainer extends StatelessWidget {
  const PrayerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 32.h,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.prayerContainer,
        borderRadius: BorderRadius.circular(4.0.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.icons.homePrayerTimesIcon.svg(),
          8.isWidth,
          Text(
            AppStrings.timeForNextPrayer,
            style: AppFontStyle.fontCairo14w400pink,
          ),
        ],
      ),
    );
  }
}
