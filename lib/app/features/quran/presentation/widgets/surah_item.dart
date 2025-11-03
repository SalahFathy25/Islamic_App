import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';

class SurahItem extends StatelessWidget {
  final int surahNumber;
  final String surahName;
  final String type;
  final int ayahNumbers;

  const SurahItem({
    super.key,
    required this.surahNumber,
    required this.surahName,
    required this.type,
    required this.ayahNumbers,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: ()=> ,
      child: Container(
        height: 70.h,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.lightBlueColor.withValues(alpha: 0.01),
          border: Border.all(
            color: AppColors.lightBlueBorderColor.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(8.0.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xff064BFF).withValues(alpha: 0.25),
              blurRadius: 4.0.r,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: SizedBox(
          height: 50.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$surahNumber - $surahName",
                    style: AppFontStyle.fontReemKafi20w400titleColor,
                  ),
                  Text(
                    type,
                    style: AppFontStyle.fontAlmarai14w400White.copyWith(
                      color: AppColors.surahStatusColor,
                    ),
                  ),
                ],
              ),
              Text(
                "عدد آياتها ( $ayahNumbers آية )",
                style: AppFontStyle.fontAlmarai12w400mainColor.copyWith(
                  color: AppColors.mainColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
