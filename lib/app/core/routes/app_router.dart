import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/core/routes/routes.dart';
import 'package:islamic_app/app/features/quran/presentation/manager/sheikhs_cubit.dart';
import 'package:islamic_app/app/features/quran/presentation/screens/quran_home_screen.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/quran/data/models/sheikh_model.dart';
import '../../features/audio_player/presentation/manger/audio_cubit.dart';
import '../../features/quran/presentation/manager/download_cubit.dart';
import '../../features/quran/presentation/screens/sheikhs_surahs_screen.dart';
import '../../features/audio_player/presentation/screens/audio_player_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../configurations/di.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //--------------- Splash Screen ---------------
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.azkarScreen:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text("Azkar Screen")),
        );
      case Routes.quranScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SheikhsCubit>(),
            child: const QuranHomeScreen(),
          ),
        );
      // case Routes.sheikhSurahsScreen:
      //   final sheikhsCubit = settings.arguments as SheikhsCubit;
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider.value(
      //       value: sheikhsCubit,
      //       child: const SheikhSurahsScreen(),
      //     ),
      //   );
      case Routes.prayerScreen:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text("Prayer Screen")),
        );
      case Routes.qiblaScreen:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text("Qibla Screen")),
        );
      case Routes.sheikhSurahsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        final sheikh = args['sheikh'] as SheikhModel;
        final typeName = args['typeName'] as String;
        final surahs = args['surahs'] as List<SurahModel>;

        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<DownloadCubit>()),
              // BlocProvider(create: (_) => getIt<AudioPlayerCubit>()),
            ],
            child: SheikhSurahsScreen(
              sheikh: sheikh,
              typeName: typeName,
              surahs: surahs,
            ),
          ),
        );

      case Routes.audioPlayerScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<AudioCubit>(),
            child: AudioPlayerScreen(
              surahName: args['surahName'],
              audioUrl: args['audioUrl'],
              filePath: args['filePath'],
              sheikh: args['sheikh'],
              typeName: args['typeName'],
            ),
          ),
        );
      /*
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => getIt<AuthCubit>(),
                child: const SplashScreen(),
              ),
        );
    case SignUpScreen.routeName:
      final authCubit = settings.arguments as AuthCubit;
      return MaterialPageRoute(
        builder:
            (context) => BlocProvider.value(
              value: authCubit,
              child: const SignUpScreen(),
            ),
      );
    */
      /*
    case VerifyMobileScreen.routeName:
      final authCubit = settings.arguments as AuthCubit;
      return MaterialPageRoute(
        builder:
            (context) => BlocProvider.value(
              value: authCubit,
              child: VerifyMobileScreen(),
            ),
      );
      */

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(child: Text("No route define for ${settings.name}")),
          ),
        );
    }
  }
}
