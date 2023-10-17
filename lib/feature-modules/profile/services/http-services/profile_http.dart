import 'dart:developer';

import 'package:flytern/core/data/constants/app-spectific/core_http_request_endpoints.dart';
import 'package:flytern/feature-modules/profile/data/constants/app-specific/profile_http_request_endpoints.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class ProfileHttpServices{

  getUserDetails() async {

    FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserDetails,null);

    if(response.success){
      if(response.data != null){
        AuthToken authToken = mapAuthToken(response.data,false);
        return authToken;
      }
    }

    return mapAuthToken({},true);

  }

}