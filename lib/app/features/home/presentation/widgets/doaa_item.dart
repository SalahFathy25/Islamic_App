import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';

import '../../data/models/shortcut_item_model.dart';

class DoaaItem extends StatelessWidget {
  const DoaaItem({super.key, required this.model});

  final HomeItemModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, model.nextScreen.toString()),
      child: Container(
        width: 170.w,
        height: 111.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0.r),
          color: AppColors.pinkColor2,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned.fill(
              child: FittedBox(fit: BoxFit.cover, child: model.image),
            ),
            Positioned(
              right: 4.0.w,
              left: 4.0.w,
              bottom: 4.0.h,
              child: Container(
                width: double.infinity,
                height: 30.h,
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.9),
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
