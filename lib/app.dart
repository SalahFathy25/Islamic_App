import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/core/localization/generated/l10n.dart';
import 'app/core/routes/app_router.dart';
import 'app/features/home/presentation/screens/home_screen.dart';
import 'app/features/splash/presentation/screens/splash_screen.dart';

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Islamic App',
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: SplashScreen.routeName,
          home: child,
        );
      },
      child: HomeScreen(),
    );
  }
}
