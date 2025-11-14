import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/core/flutter_quran/src/utils/flutter_quran_utils.dart';
import 'package:islamic_app/app/core/widgets/app_app_bar.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/quran_tab_bar.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/sheikhs_grid_view.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/surahs_list_view.dart';

import '../manager/sheikhs_cubit.dart';

class QuranHomeScreen extends StatefulWidget {
  const QuranHomeScreen({super.key});

  @override
  State<QuranHomeScreen> createState() => _QuranHomeScreenState();
}

class _QuranHomeScreenState extends State<QuranHomeScreen> {
  int selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    FlutterQuran().init();
    context.read<SheikhsCubit>().getSheikhs();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppAppBar(),
          8.isHeight,
          QuranTabBar(
            selectedIndex: selectedIndex,
            onTabChanged: (index) {
              setState(() => selectedIndex = index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          // 16.isHeight,
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => selectedIndex = index);
              },
              children: [SurahsListView(), SheikhsGridView()],
            ),
          ),
        ],
      ),
    );
  }
}
