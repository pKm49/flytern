import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flytern/core/controllers/core_controller.dart';
import 'package:flytern/core/controllers/localization_controller.dart';
import 'package:flytern/core/data/constants/app-spectific/app_routes.dart';
import 'package:flytern/core/data/constants/ui-specific/theme_data.dart';
import 'package:flytern/core/data/constants/ui-specific/theme_manager.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {

    Get.put(CoreController());
    Get.put(SharedController());
    CoreTranslationController.initLanguages();
    _themeManager.addListener(themeListener);

    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: MyApp.navigatorKey,
      locale: Get.deviceLocale,
      supportedLocales: const [
        Locale('en'), // English, no country code
        Locale('ar'), // Spanish, no country code
      ],
      fallbackLocale: const Locale('en', 'Us'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      translations: CoreTranslationController(),
      debugShowCheckedModeBanner: false,
      title: 'Flytern',
      theme: getThemeData('light', Get.deviceLocale?.languageCode ?? 'en'),
      darkTheme: getThemeData('dark', Get.deviceLocale?.languageCode ?? 'en'),
      initialRoute: Approute_langaugeSelector,
      getPages: getAppRoutes(),
    );
  }
}