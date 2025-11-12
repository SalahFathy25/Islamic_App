import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/core/configurations/shared_preferences.dart';
import 'app/core/routes/bloc_observer.dart';
import 'firebase_options.dart';

void appServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.initCacheHelper();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
