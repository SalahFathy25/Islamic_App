import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/core/utils/app_strings.dart';
import '../../../../core/widgets/build_tab_button.dart';

class QuranTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const QuranTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Row(
        children: [
          Expanded(
            child: buildTabButton(
              title: AppStrings.quranFirstTab,
              isSelected: selectedIndex == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          16.isWidth,
          Expanded(
            child: buildTabButton(
              title: AppStrings.quranSecondTab,
              isSelected: selectedIndex == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}
