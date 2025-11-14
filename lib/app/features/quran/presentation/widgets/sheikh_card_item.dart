import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:islamic_app/app/core/routes/routes.dart';
import 'package:islamic_app/app/features/quran/data/models/sheikh_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/font_style.dart';

class SheikhCardItem extends StatelessWidget {
  const SheikhCardItem({super.key, required this.model});

  final SheikhModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.sheikhSurahsScreen,
          arguments: model,
        );
      },
      child: Container(
        width: 174.w,
        height: 174.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0.r)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0.r),
              child: CachedNetworkImage(
                imageUrl: model.sheikhImage,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.black,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image),
              ),
            ),
            Positioned(
              right: 4.0.w,
              left: 4.0.w,
              bottom: 4.0.h,
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(4.0.r),
                ),
                child: Center(
                  child: Text(
                    model.name,
                    style: AppFontStyle.fontAlmarai14w700White,
                    textAlign: TextAlign.center,
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
