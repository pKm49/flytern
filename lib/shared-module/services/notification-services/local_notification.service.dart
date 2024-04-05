import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
as flutter_local_notifications;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/service_types.core.constant.dart';
import 'package:get/get.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  ) ;

  Future<void> initNotification() async {

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {

              debugPrint("onDidReceiveNotificationResponse triggered");
              debugPrint("payload is " + notificationResponse.payload.toString());

              final List<String> str =
              notificationResponse.payload!.replaceAll('{', '').replaceAll('}', '').split(',');
              final Map<String, dynamic> result = <String, dynamic>{};
              for (int i = 0; i < str.length; i++) {
                final List<String> s = str[i].split(':');
                result.putIfAbsent(s[0].trim(), () => s[1].trim());
              }

              onActionReceivedImplementationMethod(result);
            });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

  }

  Future<void> onActionReceivedImplementationMethod(
      Map<String, dynamic> data
      ) async {

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
          }else if(serviceType == ServiceType.INSURANCE.name){
            final insuranceBookingController = Get.find<InsuranceBookingController>();
            insuranceBookingController.getConfirmationData(bookingRef,true );
          }
        }


        break;
      }
      case "WEBVIEWURL":{

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


  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future handleFcmNotification(RemoteMessage? message) async {
    debugPrint("FirebaseMessaging onMessage triggered");
    debugPrint("payload is " + message!.data.toString());

    final RemoteNotification? notification = message.notification;
    final Map<String, dynamic> data = message.data;
    final AndroidNotification? android = message.notification?.android;
    final AppleNotification? apple = message.notification?.apple;
    String logoPath =
        "https://lh3.googleusercontent.com/4h2XkERxolE4FL97S1AwPucH48MwqbrLc63B5PvunkPoVHd_X1bKPfILsmzy-ZHTEuQ";
    String imageUrl = logoPath;

    if(android != null){
      if(android.imageUrl != null){
        imageUrl = android.imageUrl??logoPath;
      }
    }
    if(apple != null){
      if(apple.imageUrl != null){
        imageUrl = apple.imageUrl??logoPath;
      }
    }

    String bigPicturePath = "";
    try {
      bigPicturePath = await _downloadAndSaveFile(
          imageUrl, 'bigPicture');
    } catch (e) {
      bigPicturePath =
      await _downloadAndSaveFile(logoPath ?? "", 'bigPicture');
    }

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));
    // If `onMessage` is triggered with a notification, construct our own
// local notification to show to users using the created channel.

    if(notification != null){
      notificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        flutter_local_notifications.NotificationDetails(
          android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@mipmap/ic_launcher',
              styleInformation: bigPictureStyleInformation),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data.toString(),
      );
    }

    if(Platform.isAndroid){
      if (notification != null && android != null) {
        // final http.Response response = await http.get(Uri.parse(URL));

        String logoPath =
            "https://lh3.googleusercontent.com/4h2XkERxolE4FL97S1AwPucH48MwqbrLc63B5PvunkPoVHd_X1bKPfILsmzy-ZHTEuQ";

        String bigPicturePath = "";
        try {
          bigPicturePath = await _downloadAndSaveFile(
              android.imageUrl ?? "", 'bigPicture');
        } catch (e) {
          bigPicturePath =
          await _downloadAndSaveFile(logoPath ?? "", 'bigPicture');
        }

        final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));
        // final http.Response response = await http.get(Uri.parse(imageUrl));
        // bigPictureStyleInformation = BigPictureStyleInformation(
        //     ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)));


      }
    }
    if(Platform.isIOS){
      if (notification != null && apple != null) {
        // final http.Response response = await http.get(Uri.parse(URL));

        String logoPath =
            "https://lh3.googleusercontent.com/4h2XkERxolE4FL97S1AwPucH48MwqbrLc63B5PvunkPoVHd_X1bKPfILsmzy-ZHTEuQ";
        String bigPicturePath = "";
        try {
          bigPicturePath = await _downloadAndSaveFile(
              apple.imageUrl ?? "", 'bigPicture');
        } catch (e) {
          bigPicturePath =
          await _downloadAndSaveFile(logoPath ?? "", 'bigPicture');
        }

        final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));
        // final http.Response response = await http.get(Uri.parse(imageUrl));
        // bigPictureStyleInformation = BigPictureStyleInformation(
        //     ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)));

        notificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          flutter_local_notifications.NotificationDetails(
            android: AndroidNotificationDetails(
                channel.id,
                channel.name,),
            iOS: const DarwinNotificationDetails(),
          ),
          payload: message.data.toString(),
        );
      }
    }

  }


}