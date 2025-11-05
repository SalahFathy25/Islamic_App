import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/features/quran/data/models/shiekh_model.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/sheikh_card_item.dart';

class SheikhsGridView extends StatelessWidget {
  const SheikhsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(24.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),

      itemCount: shiekhList.length,
      itemBuilder: (BuildContext context, int index) {
        return SheikhCardItem(model: shiekhList[index]);
      },
    );
  }
}
