import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../misc.dart';

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
    this.onGenerateRoute,
  })  : _routerMode = false,
        routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        super(key: key);

  const PlatformApp.router({
    Key? key,
    this.debugShowCheckedModeBanner = true,
    required this.theme,
    required this.darkTheme,
    this.themeMode,
    required this.localizationsDelegates,
    this.locale,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.routeInformationProvider,
    required RouteInformationParser<Object> this.routeInformationParser,
    required RouterDelegate<Object> this.routerDelegate,
  })  : _routerMode = true,
        navigatorKey = null,
        home = null,
        onGenerateRoute = null,
        super(key: key);

  final bool debugShowCheckedModeBanner;
  final Widget? home;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode? themeMode;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final Locale? locale;
  final Iterable<Locale> supportedLocales;
  final RouteFactory? onGenerateRoute;
  final bool _routerMode;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final RouteInformationProvider? routeInformationProvider;

  @override
  Widget build(BuildContext context) {
    if (isCupertino) {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      final isDark = themeMode == ThemeMode.dark ||
          (themeMode == ThemeMode.system && brightness == Brightness.dark);

      return Theme(
        data: isDark ? darkTheme : theme,
        child: _routerMode
            ? CupertinoApp.router(
                routeInformationParser: routeInformationParser!,
                routerDelegate: routerDelegate!,
                routeInformationProvider: routeInformationProvider,
                locale: locale,
                supportedLocales: supportedLocales,
                localizationsDelegates: localizationsDelegates,
                debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                theme: MaterialBasedCupertinoThemeData(
                  materialTheme: isDark ? darkTheme : theme,
                ),
              )
            : CupertinoApp(
                navigatorKey: navigatorKey,
                locale: locale,
                supportedLocales: supportedLocales,
                localizationsDelegates: localizationsDelegates,
                debugShowCheckedModeBanner: debugShowCheckedModeBanner,
                home: home,
                theme: MaterialBasedCupertinoThemeData(
                  materialTheme: isDark ? darkTheme : theme,
                ),
                onGenerateRoute: onGenerateRoute,
              ),
      );
    } else {
      return _routerMode
          ? MaterialApp.router(
              routeInformationParser: routeInformationParser!,
              routerDelegate: routerDelegate!,
              routeInformationProvider: routeInformationProvider,
              debugShowCheckedModeBanner: debugShowCheckedModeBanner,
              localizationsDelegates: localizationsDelegates,
              themeMode: themeMode,
              theme: theme,
              darkTheme: darkTheme,
              supportedLocales: supportedLocales,
              locale: locale,
            )
          : MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: debugShowCheckedModeBanner,
              localizationsDelegates: localizationsDelegates,
              home: home,
              themeMode: themeMode,
              theme: theme,
              darkTheme: darkTheme,
              supportedLocales: supportedLocales,
              locale: locale,
              onGenerateRoute: onGenerateRoute,
            );
    }
  }
}
