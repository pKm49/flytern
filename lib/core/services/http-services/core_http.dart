import 'dart:developer';

import 'package:flytern/core/data/constants/app-spectific/http_request_endpoints.dart';
import 'package:flytern/core/data/models/app-specific/auth_token.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';


class CoreHttpServices{

  getGuestToken() async {

    FlyternHttpResponse response = await getRequest(CoreHttpRequestEndpointGetGuestToken,null);
    if(response.success){
      if(response.data != null){
        AuthToken authToken = mapAuthToken(response.data);
        return authToken;
      }
    }
    return null;

  }

  Future<FlyternHttpResponse> updateFirebaseToken(flavor,userId,String firebaseToken) async {
    FlyternHttpResponse response = await patchRequest(
        flavor.toLowerCase().split(" ").join('-')+'/'+userId  ,
        {"firebaseToken":firebaseToken});

    return response;
  }

}