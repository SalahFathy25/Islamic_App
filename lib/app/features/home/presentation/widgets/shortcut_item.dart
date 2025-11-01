import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/app_strings.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';
import 'package:islamic_app/gen/assets.gen.dart';

import '../../data/models/shortcut_item_model.dart';

class ShortcutItem extends StatelessWidget {
  const ShortcutItem({super.key, required this.model});

  final HomeItemModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, model.nextScreen.toString()),
      child: Container(
        width: 112.w,
        height: 168.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0.r)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0.r),
              child: model.image,
            ),
            Positioned(
              right: 4.0.w,
              left: 4.0.w,
              bottom: 4.0.h,
              child: Container(
                width: double.infinity,
                height: 30.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                child: Center(
                  child: Text(
                    model.title,
                    style: AppFontStyle.fontAlmarai14w700White,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
