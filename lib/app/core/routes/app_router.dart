import 'package:flutter/material.dart';
import 'package:islamic_app/app/core/routes/routes.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

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
          builder: (context) => const Center(child: Text("Quran Screen")),
        );
      case Routes.prayerScreen:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text("Prayer Screen")),
        );
      case Routes.qiblaScreen:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text("Qibla Screen")),
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
