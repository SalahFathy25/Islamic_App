import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';

class DailyTaskContainer extends StatelessWidget {
  const DailyTaskContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160.h,
      padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 8.0.w),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: SingleChildScrollView(
        child: Text(
          'الٓمٓ (1) ٱللَّهُ لَآ إِلَٰهَ إِلَّا هُوَ ٱلۡحَيُّ ٱلۡقَيُّومُ (2) نَزَّلَ عَلَيۡكَ ٱلۡكِتَٰبَ بِٱلۡحَقِّ مُصَدِّقٗا لِّمَا بَيۡنَ يَدَيۡهِ وَأَنزَلَ ٱلتَّوۡرَىٰةَ وَٱلۡإِنجِيلَ (3) مِن قَبۡلُ هُدٗى لِّلنَّاسِ وَأَنزَلَ ٱلۡفُرۡقَانَۗ إِنَّ ٱلَّذِينَ كَفَرُواْ بِـَٔايَٰتِ ٱللَّهِ لَهُمۡ عَذَابٞ شَدِيدٞۗ وَٱللَّهُ عَزِيزٞ ذُو ٱنتِقَامٍ (4) إِنَّ ٱللَّهَ لَا يَخۡفَىٰ عَلَيۡهِ شَيۡءٞ فِي ٱلۡأَرۡضِ وَلَا فِي ٱلسَّمَآءِ (5)',
          style: AppFontStyle.fontAmiri16w400titleColor.copyWith(
            color: AppColors.mainColor.withValues(alpha: 0.9),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
