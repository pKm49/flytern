import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/core-module/controllers/localization.core.controller.dart';
import 'package:flytern/core-module/constants/app_routes.core.constant.dart';
import 'package:flytern/core-module/constants/theme_data.core.constant.dart';
import 'package:flytern/core-module/services/theme_manager.core.constant.dart';
import 'package:flytern/feature-modules/auth/controllers/login_controller.dart';
import 'package:flytern/feature-modules/auth/controllers/register_controller.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password_controller.dart';
import 'package:flytern/shared-module/controllers/shared_controller.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    Get.put(RegisterController());
    Get.put(LoginController());
    Get.put(ResetPasswordController());
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