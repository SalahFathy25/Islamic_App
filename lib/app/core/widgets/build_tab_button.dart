import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';

Widget buildTabButton({
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      padding: const EdgeInsets.all(10),
      height: 40.h,
      decoration: BoxDecoration(
        color: isSelected
            ? Color(0xff03184D).withValues(alpha: 0.8)
            : AppColors.mainColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.0.r),
        boxShadow: [
          if (isSelected)
            BoxShadow(blurRadius: 8.0, offset: Offset(0, 2), spreadRadius: 0),
        ],
      ),
      child: Center(
        child: Text(
          title,
          style: isSelected
              ? AppFontStyle.fontAlmarai14w800White
              : AppFontStyle.fontAlmarai14w800Black,
        ),
      ),
    ),
  );
}
