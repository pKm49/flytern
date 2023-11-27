import 'dart:developer';

import 'package:flytern/core-module/constants/http_request_endpoints.core.constant.dart';
import 'package:flytern/core-module/models/notification.core.model.dart';
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