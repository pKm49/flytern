import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
as flutter_local_notifications;
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/firebase_options.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/service_types.core.constant.dart';
import 'package:get/get.dart';

class NotificationController {
  Future<void> setupInteractedMessage() async {
    print("setupInteractedMessage");
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );


// This function is called when ios app is opened, for android case `onDidReceiveNotificationResponse` function is called
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
            onActionReceivedImplementationMethod(message.data);
      },
    );
    enableIOSNotifications();
    await registerNotificationListeners();
  }

  static Future<void> onActionReceivedImplementationMethod(
      Map<String, dynamic> data
      ) async {


    print("onActionReceivedImplementationMethod");

    print(data);
    print(data["Redirection"]);
    print(data["ServiceType"]);
    print(data["BookingRef"]);
    print(data["Imageurl"]);
    print(data["WebviewURL"]);

    String redirection = "NONE";
    String serviceType = "";
    String bookingRef = "";
    String imageurl = "";
    String webviewUrl = "";

    redirection = data["Redirection"]??"NONE";
    serviceType = data["ServiceType"]??"";
    bookingRef = data["BookingRef"]??"";
    imageurl = data["Imageurl"]??"";
    webviewUrl = data["WebviewURL"]??"";

    switch(redirection){
      case "PAYMENT":{
        if(bookingRef !=""){
          if(serviceType == ServiceType.FLIGHT.name){
            final flightBookingController = Get.find<FlightBookingController>();
            flightBookingController.getPaymentGateways(true,bookingRef);
          }else if(serviceType == ServiceType.HOTEL.name){
            final hotelBookingController = Get.find<HotelBookingController>();
            hotelBookingController.getPaymentGateways(true,bookingRef);
          }else if(serviceType == ServiceType.ACTIVITY.name){
            final activityBookingController = Get.find<ActivityBookingController>();
            activityBookingController.getPaymentGateways(true,bookingRef);
          }else if(serviceType == ServiceType.INSURANCE.name){
            final insuranceBookingController = Get.find<InsuranceBookingController>();
            insuranceBookingController.getPaymentGateways(true,bookingRef);
          }
        }

        break;
      }
      case "CONFIRMATION":{
        if(bookingRef !=""){
          if(serviceType == ServiceType.FLIGHT.name){
            final flightBookingController = Get.find<FlightBookingController>();
            flightBookingController.getConfirmationData(bookingRef,true );
          }else if(serviceType == ServiceType.HOTEL.name){
            final hotelBookingController = Get.find<HotelBookingController>();
            hotelBookingController.getConfirmationData(bookingRef,true );
          }else if(serviceType == ServiceType.ACTIVITY.name){
            final activityBookingController = Get.find<ActivityBookingController>();
            activityBookingController.getConfirmationData(bookingRef,true );
          }else if(serviceType == ServiceType.INSURANCE.name){
            final insuranceBookingController = Get.find<InsuranceBookingController>();
            insuranceBookingController.getConfirmationData(bookingRef,true );
          }
        }


        break;
      }
      case "WEBVIEWURL":{
        print("is WEBVIEWURL");
        print(webviewUrl);
        if(webviewUrl !=""){
          Get.offAllNamed(Approute_landingpage,arguments: [
            webviewUrl
          ]);
        }else{
          Get.offAllNamed(Approute_landingpage);
        }

        break;
      }
      default:{
        Get.offAllNamed(Approute_landingpage);
        break;
      }
    }

  }


  Future<void> registerNotificationListeners() async {
    final AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOSSettings =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
// We're receiving the payload as string that looks like this
// {buttontext: Button Text, subtitle: Subtitle, imageurl: , typevalue: 14, type: course_details}
// So the code below is used to convert string to map and read whatever property you want
        final List<String> str =
        details.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
        final Map<String, dynamic> result = <String, dynamic>{};
        for (int i = 0; i < str.length; i++) {
          final List<String> s = str[i].split(':');
          result.putIfAbsent(s[0].trim(), () => s[1].trim());
        }
       print("onDidReceiveNotificationResponse");
       print(details);
       print(result);
         onActionReceivedImplementationMethod(result);
      },
    );
// onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      print('firebase_message');
      if(message != null){
        print(message);
      }
      final RemoteNotification? notification = message!.notification;
      final AndroidNotification? android = message.notification?.android;
// If `onMessage` is triggered with a notification, construct our own
// local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          flutter_local_notifications.NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: android.smallIcon,
            ),
          ),
          payload: message.data.toString(),
        );
      }
    });
  }
  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
  AndroidNotificationChannel androidNotificationChannel() =>
      const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
        'This channel is used for important notifications.', // description
        importance: Importance.max,
      );
}