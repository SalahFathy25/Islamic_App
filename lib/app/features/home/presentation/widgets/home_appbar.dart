import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/search_home_app_bar.dart';
import 'package:islamic_app/gen/assets.gen.dart';

import '../../../../core/widgets/top_appbar.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h,
      child: Stack(
        children: [
          Assets.images.topHomeAppbar.svg(
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h, right: 24.w, left: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TopAppbar(
                  icon: Assets.images.icons.notificationIcon.svg(),
                  onTap: () {},
                ),
                16.isHeight,
                SearchHomeAppBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
