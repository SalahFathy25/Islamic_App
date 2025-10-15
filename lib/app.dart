import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/core/localization/generated/l10n.dart';
import 'app/core/routes/app_router.dart';
import 'app/features/splash/presentation/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Scaffold(),
    );
  }
}
