 import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/core-module/controllers/localization.core.controller.dart';
import 'package:flytern/core-module/constants/app_routes.core.constant.dart';
import 'package:flytern/core-module/constants/theme_data.core.constant.dart';
 import 'package:flytern/core-module/services/theme_manager.core.constant.dart';
 import 'package:flytern/feature-modules/auth/controllers/login.auth.controller.dart';
import 'package:flytern/feature-modules/auth/controllers/register.auth.controller.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password.auth.controller.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/firebase_options.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/services/notification-services/local_notification.service.dart';
import 'package:flytern/shared-module/services/notification-services/notification_controller_local_notification.dart';
import 'package:get/get.dart';
 import 'package:permission_handler/permission_handler.dart';

import 'shared-module/services/utility-services/widget_properties_generator.shared.service.dart';

 @pragma('vm:entry-point')
 Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
   // If you're going to use other Firebase services in the background, such as Firestore,
   // make sure you call `initializeApp` before using other Firebase services.
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   NotificationService().initNotification();
   NotificationService().handleFcmNotification(message);
   print("Handling a background message: ${message.messageId}");
 }

 Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

   NotificationService().initNotification();
   NotificationController notificationController = NotificationController();
   notificationController.setupInteractedMessage();
   // await NotificationService.initializeNotification();
   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
   await FirebaseMessaging.instance.subscribeToTopic("andriod_flytern_topic");
   //ios_flytern_topic

   await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
    precacheImage(AssetImage(ASSETS_VIDEO_BG), context);

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
