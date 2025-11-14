import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:islamic_app/app/core/configurations/di.dart';

import 'app/core/configurations/shared_preferences.dart';
import 'app/core/routes/bloc_observer.dart';
import 'app/features/quran/data/models/downloaded_surah.dart';
import 'firebase_options.dart';

void appServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.initCacheHelper();
  await initGetIt();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(DownloadedSurahAdapter());
  await Hive.openBox<DownloadedSurah>('downloads');
}
