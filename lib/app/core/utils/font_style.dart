import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/generated/assets.dart';

import 'app_colors.dart';

class AppFontStyle {
  static TextStyle fontAlmarai10w400White = TextStyle(
    fontSize: 10.sp,
    fontFamily: Assets.fontsAlmaraiBold,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static TextStyle fontAlmarai14w700White = TextStyle(
    fontSize: 14.sp,
    fontFamily: Assets.fontsAlmaraiBold,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
  static TextStyle fontAlmarai14w400White = TextStyle(
    fontSize: 14.sp,
    fontFamily: Assets.fontsAlmaraiRegular,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );
  static TextStyle fontCairo14w400pink = TextStyle(
    fontSize: 14.sp,
    fontFamily: Assets.fontsCairoRegular,
    fontWeight: FontWeight.w400,
    color: AppColors.pinkColor,
  );
  static TextStyle fontAmiri16w400titleColor = TextStyle(
    fontSize: 16.sp,
    fontFamily: Assets.fontsAmiriQuranRegular,
    fontWeight: FontWeight.w400,
    color: AppColors.textTitleColor,
  );
  static TextStyle fontCairo18w700black = TextStyle(
    fontSize: 18.sp,
    fontFamily: Assets.fontsReemKufiFunBold,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static TextStyle fontReemKafi18w700titleColor = TextStyle(
    fontSize: 18.sp,
    fontFamily: Assets.fontsReemKufiFunBold,
    fontWeight: FontWeight.w700,
    color: AppColors.textTitleColor,
  );
  static TextStyle fontReemKafi20w600titleColor = TextStyle(
    fontSize: 20.sp,
    fontFamily: Assets.fontsReemKufiFunBold,
    fontWeight: FontWeight.w600,
    color: AppColors.textTitleColor.withValues(alpha: 0.9),
  );
}
