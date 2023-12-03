import 'dart:developer';

import 'package:flytern/core-module/constants/http_request_endpoints.core.constant.dart';
import 'package:flytern/shared-module/constants/service_types.core.constant.dart';
import 'package:flytern/core-module/models/notification.core.model.dart';
import 'package:flytern/core-module/models/service_booking_status.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

class CoreHttpServices {

  Future<List<Notification>> getNotifications() async {
    List<Notification> notifications = [];

    try {
      FlyternHttpResponse response =
          await getRequest(CoreHttpRequestEndpoint_GetNotifications, null);

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["notification"] != null) {
            response.data["notification"].forEach((element) {
              notifications.add(mapNotification(element));
            });
          }
        }
      }

      return notifications;
    } catch (e) {
      return notifications;
    }
  }

  Future<ServiceBookingStatus> checkSmartPayment(String bookingRef) async {
    bool isSuccess = false;
    String servicetype = ServiceType.FLIGHT.name;

    try {
      FlyternHttpResponse response = await postRequest(
          CoreBookingHttpRequestEndpointSmartPayment,
          {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isSuccess"] != null) {
            isSuccess = response.data["isSuccess"];
          }
          if (response.data["servicetype"] != null) {
            servicetype = response.data["servicetype"];
          }
        }
      }

      return ServiceBookingStatus(
          isSuccess: isSuccess, servicetype: servicetype);
    } catch (e) {
      return ServiceBookingStatus(
          isSuccess: isSuccess, servicetype: servicetype);
    }
  }

  Future<ServiceBookingStatus> findBooking(
      String bookingRef, String email) async {
    bool isSuccess = false;
    String servicetype = "FLIGHT";

    try {
      FlyternHttpResponse response =
          await postRequest(CoreBookingHttpRequestEndpointViewBooking, {
        "bookingRef": bookingRef,
        "email": email,
        "mobileNumber": "",
        "mobileCountryCode": ""
      });

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isSuccess"] != null) {
            isSuccess = response.data["isSuccess"];
          }
          if (response.data["servicetype"] != null) {
            servicetype = response.data["servicetype"];
          }
        }
      }

      return ServiceBookingStatus(
          isSuccess: isSuccess, servicetype: servicetype);
    } catch (e) {
      return ServiceBookingStatus(
          isSuccess: isSuccess, servicetype: servicetype);
    }
  }


}
