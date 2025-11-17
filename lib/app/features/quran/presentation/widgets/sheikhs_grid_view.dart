import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/sheikh_card_item.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/sheikh_category_title.dart';

import '../manager/sheikhs_cubit.dart';

class SheikhsGridView extends StatelessWidget {
  const SheikhsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheikhsCubit, SheikhsState>(
      builder: (context, state) {
        if (state is SheikhsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SheikhsLoaded) {
          final sheikhs = state.sheikhs;
          final grouped = context.read<SheikhsCubit>().groupSheikhsByType(
            sheikhs,
          );

          return ListView(
            padding: const EdgeInsets.all(16),
            children: grouped.entries.map((entry) {
              final typeName = entry.key;
              final sheikhsList = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SheikhCategoryTitle(title: typeName),
                  SizedBox(
                    height: 85.h,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: sheikhsList.length,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (_, _) => 8.isWidth,
                      itemBuilder: (_, index) {
                        return SheikhCardItem(
                          model: sheikhsList[index],
                          typeName: typeName,
                        );
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        }
        if (state is SheikhsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
