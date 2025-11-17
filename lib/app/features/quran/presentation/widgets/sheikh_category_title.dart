import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';

class SheikhCategoryTitle extends StatelessWidget {
  final String title;

  const SheikhCategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 11.0.h),
      child: Text(title, style: AppFontStyle.fontAlmarai18w700black),
    );
  }
}
