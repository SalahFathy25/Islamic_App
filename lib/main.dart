import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/core/configurations/shared_preferences.dart';
import 'package:islamic_app/app/core/routes/bloc_observer.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.initCacheHelper();
  runApp(const MyApp());
}
