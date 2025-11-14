import 'package:get_it/get_it.dart';
import 'package:islamic_app/app/features/quran/presentation/manager/audio_cubit.dart';
import 'package:islamic_app/app/features/quran/presentation/manager/sheikhs_cubit.dart';

import '../../features/quran/data/services/audio_player_service.dart';
import '../../features/quran/data/services/download_service.dart';
import '../../features/quran/presentation/manager/download_cubit.dart';
import 'shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  await CacheHelper.initCacheHelper();
  // Dio dio = DioFactory.getDio();
  // Services
  getIt.registerLazySingleton<DownloadService>(() => DownloadService());
  getIt.registerLazySingleton<AudioPlayerService>(() => AudioPlayerService());

  // Cubits
  getIt.registerLazySingleton<SheikhsCubit>(() => SheikhsCubit());
  getIt.registerFactory<AudioCubit>(() => AudioCubit(getIt()));
  getIt.registerFactory<DownloadCubit>(() => DownloadCubit(getIt()));
}
