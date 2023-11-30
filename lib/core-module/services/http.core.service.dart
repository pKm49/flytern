import 'dart:developer';

import 'package:flytern/core-module/constants/http_request_endpoints.core.constant.dart';
import 'package:flytern/core-module/models/notification.core.model.dart';
import 'package:flytern/core-module/models/service_booking_status.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

class CoreHttpServices{

  Future<List<Notification>> getNotifications() async {

    List<Notification> notifications = [];

    FlyternHttpResponse response = await getRequest(CoreHttpRequestEndpoint_GetNotifications,null);

    if(response.success && response.statusCode == 200){
      if(response.data != null){

        if(response.data["notification"] !=null){
          response.data["notification"].forEach((element) {
            notifications.add(mapNotification(element));
          });
        }
      }
    }

    return notifications;

  }

  Future<ServiceBookingStatus> checkSmartPayment(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        CoreBookingHttpRequestEndpointSmartPayment,
        {"bookingRef": bookingRef});

    bool isSuccess = false;
    String servicetype = "FLIGHT";

    print("getPaymentGateways");
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isSuccess"] != null) {
          isSuccess =response.data["isSuccess"];
        }
        if (response.data["servicetype"] != null) {
          servicetype =response.data["servicetype"];
        }
      }
    }

    return ServiceBookingStatus(isSuccess: isSuccess, servicetype: servicetype);
  }

  getGuestToken() async {

    FlyternHttpResponse response = await getRequest(CoreHttpRequestEndpoint_GetGuestToken,null);

    if(response.success){
      if(response.data != null){
        AuthToken authToken = mapAuthToken(response.data, true);
        return authToken;
      }
    }

    return mapAuthToken({},true);

  }

  getRefreshedToken() async {

    FlyternHttpResponse response = await getRequest(CoreHttpRequestEndpoint_GetNewAccesToken,null);

    if(response.success){
      if(response.data != null){
        AuthToken authToken = mapAuthToken(response.data,false);
        return authToken;
      }
    }

    return mapAuthToken({},true);

  }

}