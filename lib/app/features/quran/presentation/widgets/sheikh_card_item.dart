import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/core/routes/routes.dart';
import 'package:islamic_app/app/core/utils/app_strings.dart';
import 'package:islamic_app/app/features/quran/data/models/sheikh_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/font_style.dart';

class SheikhCardItem extends StatelessWidget {
  const SheikhCardItem({
    super.key,
    required this.model,
    required this.typeName,
  });

  final SheikhModel model;
  final String typeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.sheikhSurahsScreen,
          arguments: {
            'sheikh': model,
            'typeName': typeName,
            'surahs': model.types[typeName]?.surahs ?? [],
          },
        );
      },
      child: Container(
        height: 85.h,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0.r),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xffC77800).withAlpha(25),
              blurRadius: 4.0.r,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0.r),
              child: CachedNetworkImage(
                imageUrl: model.sheikhImage,
                width: 75.w,
                height: 75.h,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  color: AppColors.black,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image),
              ),
            ),
            8.isWidth,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.qaree,
                  style: AppFontStyle.fontAlmarai12w700mainColor,
                ),
                8.isHeight,
                Text(
                  model.name,
                  style: AppFontStyle.fontAlmarai12w700mainColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // void _showTypePopup(BuildContext context) {
  //   final availableTypes = model.types.keys.toList();
  //
  //   showDialog(
  //     context: context,
  //     builder: (ctx) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Text(
  //                 "اختر نوع التلاوة",
  //                 style: AppFontStyle.fontAlmarai14w800Black,
  //               ),
  //               const SizedBox(height: 20),
  //
  //               ...availableTypes.map((typeName) {
  //                 return Column(
  //                   children: [
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         minimumSize: const Size(double.infinity, 50),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                       ),
  //                       onPressed: () {
  //                         Navigator.pop(ctx);
  //                         Navigator.pushNamed(
  //                           context,
  //                           Routes.sheikhSurahsScreen,
  //                           arguments: {
  //                             'sheikh': model,
  //                             'typeName': typeName,
  //                             'surahs': model.types[typeName]?.surahs ?? [],
  //                           },
  //                         );
  //                       },
  //                       child: Text(
  //                         typeName,
  //                         style: const TextStyle(fontSize: 16),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 12),
  //                   ],
  //                 );
  //               }),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
