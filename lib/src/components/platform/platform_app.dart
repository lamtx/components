import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformApp extends StatelessWidget {
  const PlatformApp({
    Key? key,
    this.debugShowCheckedModeBanner = true,
    this.home,
    required this.theme,
    required this.darkTheme,
    this.themeMode,
    required this.localizationsDelegates,
    this.navigatorKey,
    this.locale,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
  }) : super(key: key);

  final bool debugShowCheckedModeBanner;
  final Widget? home;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode? themeMode;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Locale? locale;
  final Iterable<Locale> supportedLocales;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      final brightness = WidgetsBinding.instance!.window.platformBrightness;
      final isDark = themeMode == ThemeMode.dark ||
          (themeMode == ThemeMode.system && brightness == Brightness.dark);

      return Theme(
        data: isDark ? darkTheme : theme,
        child: CupertinoApp(
          navigatorKey: navigatorKey,
          locale: locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: localizationsDelegates,
          debugShowCheckedModeBanner: debugShowCheckedModeBanner,
          home: home,
          theme: MaterialBasedCupertinoThemeData(
            materialTheme: isDark ? darkTheme : theme,
          ),
        ),
      );
    } else {
      return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        localizationsDelegates: localizationsDelegates,
        home: home,
        themeMode: themeMode,
        theme: theme,
        darkTheme: darkTheme,
        supportedLocales: supportedLocales,
        locale: locale,
      );
    }
  }
}
