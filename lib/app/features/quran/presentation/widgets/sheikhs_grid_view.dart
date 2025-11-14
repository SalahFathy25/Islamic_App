import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/sheikh_card_item.dart';

import '../manager/sheikhs_cubit.dart';

class SheikhsGridView extends StatelessWidget {
  const SheikhsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheikhsCubit, SheikhsState>(
      builder: (context, state) {
        if (state is SheikhsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SheikhsLoaded) {
          final sheikhs = state.sheikhs;

          return GridView.builder(
            padding: EdgeInsets.all(24.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: sheikhs.length,
            itemBuilder: (BuildContext context, int index) {
              return SheikhCardItem(model: sheikhs[index]);
            },
          );
        } else if (state is SheikhsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
