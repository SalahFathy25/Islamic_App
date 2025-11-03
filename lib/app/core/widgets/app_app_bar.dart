import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import 'top_appbar.dart';

class AppAppBar extends StatelessWidget {
  const AppAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: Stack(
        children: [
          Assets.images.topAppbar.svg(width: double.infinity, fit: BoxFit.fill),
          Padding(
            padding: EdgeInsets.only(top: 60.h, right: 24.w, left: 24.w),
            child: TopAppbar(
              icon: Assets.images.icons.backIcon.svg(),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
