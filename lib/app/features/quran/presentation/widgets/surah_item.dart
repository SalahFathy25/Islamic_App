import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';
import 'package:quran_library/quran_library.dart';

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
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuranLibraryScreen(parentContext: context),
            // QuranPagesScreen(
            //   parentContext: context,
            //   surahNumber: surahNumber,
            // ),
          ),
        );
      },
      child: Container(
        height: 70.h,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FBFF),
          border: Border.all(color: const Color(0xFFBBD6FF)),
          borderRadius: BorderRadius.circular(8.0.r),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.1),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: '$surahNumber'.toArabic(),
                    style: AppFontStyle.fontReemKafi20w400titleColor,
                    children: [
                      TextSpan(
                        text: ' - $surahName',
                        style: AppFontStyle.fontReemKafi20w400titleColor,
                      ),
                    ],
                  ),
                ),
                Text(
                  type,
                  style: AppFontStyle.fontAlmarai14w400White.copyWith(
                    color: AppColors.surahStatusColor,
                  ),
                ),
              ],
            ),
            Spacer(flex: 1),
            Text(
              "عدد آياتها ( $ayahNumbers آية )".toArabic(),
              style: AppFontStyle.fontAlmarai12w400mainColor.copyWith(
                color: AppColors.mainColor.withValues(alpha: 0.6),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
