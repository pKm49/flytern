 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/core-module/controllers/localization.core.controller.dart';
import 'package:flytern/core-module/constants/app_routes.core.constant.dart';
import 'package:flytern/core-module/constants/theme_data.core.constant.dart';
import 'package:flytern/core-module/services/notification_controller.dart';
import 'package:flytern/core-module/services/theme_manager.core.constant.dart';
 import 'package:flytern/feature-modules/auth/controllers/login.auth.controller.dart';
import 'package:flytern/feature-modules/auth/controllers/register.auth.controller.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password.auth.controller.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:get/get.dart';
 import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  NotificationController notificationController = NotificationController();
  notificationController.setupInteractedMessage( );
  // await NotificationController.initializeRemoteNotifications(debug: true);
  // await NotificationController.initializeIsolateReceivePort();
  // await NotificationController.getInitialNotificationAction();



  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  // await Permission.notification.isDenied.then(
  //       (bool value) {
  //     if (value) {
  //       Permission.notification.request();
  //     }
  //   },
  // );

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

    Get.put(FlightBookingController());
    Get.put(PackageBookingController());
    Get.put(InsuranceBookingController());
    Get.put(HotelBookingController());

    CoreTranslationController.initLanguages();
    _themeManager.addListener(themeListener);
    // NotificationController.startListeningNotificationEvents();
    // NotificationController.requestFirebaseToken();
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
