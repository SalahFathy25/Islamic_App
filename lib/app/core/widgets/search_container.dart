import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/app_strings.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';
import 'package:islamic_app/gen/assets.gen.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40.h,
      padding: EdgeInsets.all(8.0.w),
      decoration: BoxDecoration(
        color: AppColors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.lookingFor,
            style: AppFontStyle.fontAlmarai14w400White.copyWith(
              color: AppColors.white.withAlpha(60),
            ),
          ),
          Assets.images.icons.searchIcon.svg(),
        ],
      ),
    );
  }
}
