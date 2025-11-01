import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/features/home/presentation/widgets/shortcut_item.dart';

import '../../data/models/shortcut_item_model.dart';

class ShortcutsListView extends StatelessWidget {
  const ShortcutsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 168.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            ShortcutItem(model: shortcutItems[index]),
        separatorBuilder: (BuildContext context, int index) => 8.isWidth,
        itemCount: shortcutItems.length,
      ),
    );
  }
}
