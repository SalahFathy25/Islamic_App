import 'package:flutter/material.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/core/utils/app_strings.dart';
import 'package:islamic_app/app/core/utils/font_style.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/search_container.dart';

class SearchHomeAppBar extends StatelessWidget {
  const SearchHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.lookingForWhat,
          style: AppFontStyle.fontAlmarai14w400White.copyWith(
            color: AppColors.white.withAlpha(90),
          ),
        ),
        8.isHeight,
        SearchContainer(),
      ],
    );
  }
}
