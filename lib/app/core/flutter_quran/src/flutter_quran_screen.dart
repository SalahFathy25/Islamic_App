import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:islamic_app/app/core/flutter_quran/src/models/ayah.dart';
import 'package:islamic_app/app/core/flutter_quran/src/models/bookmark.dart';
import 'package:islamic_app/app/core/flutter_quran/src/utils/flutter_quran_utils.dart';
import 'package:islamic_app/app/core/extensions/string_extensions.dart';
import 'package:islamic_app/app/core/utils/app_colors.dart';

import 'app_bloc.dart';
import 'controllers/bookmarks_controller.dart';
import 'controllers/quran_controller.dart';
import 'models/quran_constants.dart';
import 'models/quran_page.dart';

part 'utils/images.dart';

part 'utils/toast_utils.dart';

part 'widgets/bsmallah_widget.dart';

part 'widgets/quran_line.dart';

part 'widgets/quran_page_bottom_info.dart';

part 'widgets/surah_header_widget.dart';

part 'widgets/default_drawer.dart';

part 'widgets/ayah_long_click_dialog.dart';

class FlutterQuranScreen extends StatelessWidget {
  const FlutterQuranScreen({
    this.showBottomWidget = true,
    this.useDefaultAppBar = true,
    this.bottomWidget,
    this.appBar,
    this.onPageChanged,
    this.initialSurah,
    super.key,
  });

  ///[showBottomWidget] is a bool to disable or enable the default bottom widget
  final bool showBottomWidget;

  ///[showBottomWidget] is a bool to disable or enable the default bottom widget
  final bool useDefaultAppBar;

  ///[bottomWidget] if if provided it will replace the default bottom widget
  final Widget? bottomWidget;

  ///[appBar] if if provided it will replace the default app bar
  final PreferredSizeWidget? appBar;

  ///[onPageChanged] if provided it will be called when a quran page changed
  final Function(int)? onPageChanged;

  final int? initialSurah;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar:
                appBar ??
                (useDefaultAppBar
                    ? AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        iconTheme: const IconThemeData(color: Colors.black),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const FlutterQuranSearchScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : null),
            drawer: appBar == null && useDefaultAppBar
                ? const DefaultDrawer()
                : null,
            body: BlocBuilder<QuranCubit, List<QuranPage>>(
              builder: (ctx, pages) {
                if (pages.isNotEmpty && initialSurah != null) {
                  final int targetPage =
                      AppBloc.quranCubit.surahsStart[initialSurah! - 1];
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    AppBloc.quranCubit.pageController.jumpToPage(targetPage);
                  });
                }

                return pages.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SafeArea(
                        child: PageView.builder(
                          itemCount: pages.length,
                          controller: AppBloc.quranCubit.pageController,
                          onPageChanged: (page) {
                            if (onPageChanged != null) onPageChanged!(page);
                            AppBloc.quranCubit.saveLastPage(page + 1);
                          },
                          pageSnapping: true,
                          itemBuilder: (ctx, index) {
                            List<String> newSurahs = [];
                            return Container(
                              height: deviceSize.height * 0.8,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: index == 0 || index == 1
                                        /// This is for first 2 pages of Quran: Al-Fatihah and Al-Baqarah
                                        ? Center(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SurahHeaderWidget(
                                                    pages[index]
                                                        .ayahs[0]
                                                        .surahNameAr,
                                                  ),
                                                  if (index == 1)
                                                    BasmallahWidget(
                                                      pages[index]
                                                          .ayahs[0]
                                                          .surahNumber,
                                                    ),
                                                  ...pages[index].lines.map((
                                                    line,
                                                  ) {
                                                    return BlocBuilder<
                                                      BookmarksCubit,
                                                      List<Bookmark>
                                                    >(
                                                      builder: (context, bookmarks) {
                                                        final bookmarksAyahs =
                                                            bookmarks
                                                                .map(
                                                                  (
                                                                    bookmark,
                                                                  ) => bookmark
                                                                      .ayahId,
                                                                )
                                                                .toList();
                                                        return Column(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  deviceSize
                                                                      .width -
                                                                  32,
                                                              child: QuranLine(
                                                                line,
                                                                bookmarksAyahs,
                                                                bookmarks,
                                                                boxFit: BoxFit
                                                                    .scaleDown,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }),
                                                ],
                                              ),
                                            ),
                                          )
                                        /// Other Quran pages
                                        : LayoutBuilder(
                                            builder: (context, constraints) {
                                              return ListView(
                                                physics:
                                                    currentOrientation ==
                                                        Orientation.portrait
                                                    ? const NeverScrollableScrollPhysics()
                                                    : null,
                                                children: [
                                                  ...pages[index].lines.map((
                                                    line,
                                                  ) {
                                                    bool firstAyah = false;
                                                    if (line
                                                                .ayahs[0]
                                                                .ayahNumber ==
                                                            1 &&
                                                        !newSurahs.contains(
                                                          line
                                                              .ayahs[0]
                                                              .surahNameAr,
                                                        )) {
                                                      newSurahs.add(
                                                        line
                                                            .ayahs[0]
                                                            .surahNameAr,
                                                      );
                                                      firstAyah = true;
                                                    }
                                                    return BlocBuilder<
                                                      BookmarksCubit,
                                                      List<Bookmark>
                                                    >(
                                                      builder: (context, bookmarks) {
                                                        final bookmarksAyahs =
                                                            bookmarks
                                                                .map(
                                                                  (
                                                                    bookmark,
                                                                  ) => bookmark
                                                                      .ayahId,
                                                                )
                                                                .toList();
                                                        return Column(
                                                          children: [
                                                            if (firstAyah)
                                                              SurahHeaderWidget(
                                                                line
                                                                    .ayahs[0]
                                                                    .surahNameAr,
                                                              ),
                                                            if (firstAyah &&
                                                                (line
                                                                        .ayahs[0]
                                                                        .surahNumber !=
                                                                    9))
                                                              BasmallahWidget(
                                                                line
                                                                    .ayahs[0]
                                                                    .surahNumber,
                                                              ),
                                                            SizedBox(
                                                              width:
                                                                  deviceSize
                                                                      .width -
                                                                  30,
                                                              height:
                                                                  ((currentOrientation ==
                                                                              Orientation.portrait
                                                                          ? constraints.maxHeight
                                                                          : deviceSize.width) -
                                                                      (pages[index]
                                                                              .numberOfNewSurahs *
                                                                          (line.ayahs[0].surahNumber !=
                                                                                  9
                                                                              ? 110
                                                                              : 80))) *
                                                                  0.95 /
                                                                  pages[index]
                                                                      .lines
                                                                      .length,
                                                              child: QuranLine(
                                                                line,
                                                                bookmarksAyahs,
                                                                bookmarks,
                                                                boxFit:
                                                                    line
                                                                        .ayahs
                                                                        .last
                                                                        .centered
                                                                    ? BoxFit
                                                                          .scaleDown
                                                                    : BoxFit
                                                                          .fill,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }),
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                  bottomWidget ??
                                      (showBottomWidget
                                          ? QuranPageBottomInfoWidget(
                                              page: index + 1,
                                              hizb: pages[index].hizb,
                                              surahName: pages[index]
                                                  .ayahs
                                                  .last
                                                  .surahNameAr,
                                            )
                                          : Container()),
                                ],
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FlutterQuranSearchScreen extends StatefulWidget {
  const FlutterQuranSearchScreen({super.key});

  @override
  State<FlutterQuranSearchScreen> createState() =>
      FlutterQuranSearchScreenState();
}

class FlutterQuranSearchScreenState extends State<FlutterQuranSearchScreen> {
  List<Ayah> ayahs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'بحث في القرآن',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // حقل البحث بشكل أنيق
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (txt) {
                      final searchResult = FlutterQuran().search(txt);
                      setState(() {
                        ayahs = [...searchResult];
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'ابحث عن كلمة أو آية...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // عرض النتائج
                Expanded(
                  child: ayahs.isEmpty
                      ? Center(
                          child: Text(
                            _searchController.text.isEmpty
                                ? 'ابدأ بالبحث عن كلمة...'
                                : 'لا توجد نتائج مطابقة',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: ayahs.length,
                          separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                            color: Colors.grey,
                            height: 12,
                          ),
                          itemBuilder: (context, index) {
                            final ayah = ayahs[index];
                            return ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              tileColor: AppColors.mainColor.withAlpha(30),
                              title: Text(
                                ayah.ayah.replaceAll('\n', ' '),
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                ayah.surahNameAr,
                                style: TextStyle(
                                  color: AppColors.mainColor.withAlpha(80),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                FlutterQuran().navigateToAyah(ayah);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
