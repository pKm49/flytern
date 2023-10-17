import 'dart:developer';

import 'package:flytern/core/data/constants/app-spectific/core_http_request_endpoints.dart';
import 'package:flytern/feature-modules/profile/data/constants/app-specific/profile_http_request_endpoints.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-copax.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-travelstory.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/business_models/user_details.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class ProfileHttpServices{

  getUserDetails() async {
  print("getUserDetails");
    FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserDetails,null);

    if(response.success){
      if(response.data != null){
        UserDetails userDetails = mapUserDetails(response.data);
        return userDetails;
      }
    }

    return mapUserDetails({});

  }

  getUserTravelStories() async {
    print("getUserTravelStories");
    FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserTravelStories,null);

    if(response.success){
      if(response.data != null){
        List<UserTravelStory> travelStories = [];
        response.data.forEach((element) {
          travelStories.add(mapUserTravelStory(element));
        });
        return travelStories;
      }
    }

    return [];

  }

  getUserCoPaxs() async {
    print("getUserCoPaxs");
    FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserCoPaxs,null);

    if(response.success){
      if(response.data != null){
        List<UserCoPax> coPaxes = [];
        response.data.forEach((element) {
          coPaxes.add(mapUserCoPax(element));
        });
        return coPaxes;
      }
    }

    return [];

  }
}