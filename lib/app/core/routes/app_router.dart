import 'package:flutter/material.dart';

import '../../features/splash/presentation/screens/splash_screen.dart';

abstract class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      //--------------- Splash Screen ---------------
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
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
