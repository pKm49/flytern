import 'dart:io';
import 'package:flytern/feature-modules/profile/data/constants/app-specific/profile_http_request_endpoints.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-copax.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-travelstory.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/business_models/user_details.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class ProfileHttpServices{

  Future<bool> updateUserDetails(UserDetails userDetails ) async {
    print("createTravelStory");

    try{
      FlyternHttpResponse response = await postRequest(
          ProfileHttpRequestEndpointUpdateUserDetails,userDetails.toJson() );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        throw Exception(response.errors[0]);
      }

    }catch (e){
      rethrow;
    }

  }

  getUserDetails() async {

    FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserDetails,null);

    if(response.success){
      if(response.data != null){
        UserDetails userDetails =  mapUserDetails(response.data);
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

 Future<bool> createTravelStory(UserTravelStory travelStory,  File? file) async {
    print("createTravelStory");

    try{
      FlyternHttpResponse response = await fileUpload(
        travelStory.toJson(),
        file??null,'File',
        ProfileHttpRequestEndpointCreateUserTravelStory, );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        throw Exception(response.errors[0]);
      }

    }catch (e){
      rethrow;
    }

  }

  Future<bool> createCoPax(UserCoPax userCoPax ) async {
    print("createTravelStory");

    try{
      FlyternHttpResponse response = await postRequest(
          ProfileHttpRequestEndpointGetUserCreateCoPaxs,userCoPax.toJson() );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        throw Exception(response.errors[0]);
      }

    }catch (e){
      rethrow;
    }

  }

  Future<bool> updateCoPax(UserCoPax userCoPax ) async {
    print("createTravelStory");

    try{
      FlyternHttpResponse response = await postRequest(
          ProfileHttpRequestEndpointGetUserUpdateCoPaxs,userCoPax.toJson() );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        throw Exception(response.errors[0]);
      }

    }catch (e){
      rethrow;
    }

  }

  Future<bool> deleteCoPax(int id ) async {
    print("createTravelStory");

    try{
      FlyternHttpResponse response = await postRequest(
          "$ProfileHttpRequestEndpointGetUserDeleteCoPaxs$id",null );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        throw Exception(response.errors[0]);
      }

    }catch (e){
      rethrow;
    }

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