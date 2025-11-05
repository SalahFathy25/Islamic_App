import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/core/configurations/shared_preferences.dart';
import 'package:islamic_app/app/core/routes/bloc_observer.dart';

import 'app.dart';

void main() async {
  services();
  // runApp(const IslamicApp());
  runApp(
    DevicePreview(enabled: false, builder: (context) => const IslamicApp()),
  );
}

void services() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.initCacheHelper();
}
