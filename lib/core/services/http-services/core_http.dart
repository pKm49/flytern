import 'dart:developer';

import 'package:flytern/core/data/constants/app-spectific/http_request_endpoints.dart';
import 'package:flytern/core/data/models/app-specific/auth_token.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';


class CoreHttpServices{

  getGuestToken() async {

    FlyternHttpResponse response = await postRequest(CoreHttpRequestEndpointGetGuestToken,null);

    if(response.success){
      if(response.data != null){
        AuthToken authToken = mapAuthToken(response.data);
        return authToken;
      }
    }

    return mapAuthToken({});

  }

  getRefreshedToken(String refreshToken) async {

    FlyternHttpResponse response = await postRequest(CoreHttpRequestEndpointGetNewAccesToken,
        {refreshToken:refreshToken});

    if(response.success){
      if(response.data != null){
        AuthToken authToken = mapAuthToken(response.data);
        return authToken;
      }
    }

    return mapAuthToken({});

  }

}