import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_strings.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';
import 'package:islamic_app/app/core/widgets/small_container.dart';
import 'package:islamic_app/gen/assets.gen.dart';

import '../utils/app_colors.dart';

class TopAppbar extends StatelessWidget {
  final Widget icon;

  const TopAppbar({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Assets.images.icons.appIcon.svg(width: 35.0.w, height: 35.0.h),
                Assets.images.appName.image(width: 90.0.w, height: 36.0.h),
              ],
            ),
            Text(
              AppStrings.welcomeBack,
              style: AppFontStyle.fontAlmarai14w700White.copyWith(
                color: AppColors.white.withAlpha(90),
              ),
            ),
          ],
        ),
        smallContainer(icon),
      ],
    );
  }
}
