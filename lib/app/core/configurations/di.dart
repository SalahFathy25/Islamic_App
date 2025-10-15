import 'package:get_it/get_it.dart';

import 'shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  await CacheHelper.initCacheHelper();
  // Dio dio = DioFactory.getDio();
  // getIt.registerLazySingleton<SignUpRepo>(() => SignUpRepo(dio));
  // getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(dio));
  // getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
}
