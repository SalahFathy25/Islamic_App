import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';

Widget smallContainer(Widget icon) {
  return Container(
    width: 40.w,
    height: 40.h,
    decoration: BoxDecoration(
      color: AppColors.white.withAlpha(10),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Center(child: icon),
  );
}
