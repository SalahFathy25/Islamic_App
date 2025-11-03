import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';

import '../../data/models/home_item_model.dart';
import 'doaa_item.dart';

class DoaasListView extends StatelessWidget {
  const DoaasListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 111.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => DoaaItem(model: doaasItems[index]),
        separatorBuilder: (BuildContext context, int index) => 8.isWidth,
        itemCount: doaasItems.length,
      ),
    );
  }
}
