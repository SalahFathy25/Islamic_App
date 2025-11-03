import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/extensions/distance_extension.dart';
import 'package:islamic_app/app/core/widgets/app_app_bar.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/quran_tab_bar.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/surah_item.dart';
import 'package:islamic_app/app/features/quran/presentation/widgets/surahs_list_view.dart';
import 'package:quran_library/quran.dart';

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
    QuranLibrary.init();
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
              children: [
                SurahsListView(),
                Center(
                  child: Text(
                    'محتوى مشايخ التلاوة',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
