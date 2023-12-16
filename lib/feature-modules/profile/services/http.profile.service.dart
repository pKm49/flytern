import 'dart:io';
import 'package:flytern/feature-modules/profile/constants/http_request_endpoints.profile.constant.dart';
import 'package:flytern/feature-modules/profile/models/my_booking_response.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/user-copax.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/user-travelstory.profile.model.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/user_details.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

class ProfileHttpServices{

  Future<bool> updateUserDetails(UserDetails userDetails, File? file ) async {
    print("updateUserDetails called");
    try{
      FlyternHttpResponse response = await fileUpload(
        userDetails.toJson(),
        file,'File',
        ProfileHttpRequestEndpointUpdateUserDetails,"PUT" );

      if(response.success && response.statusCode == 200){
        return true;
      }else{
        return false;
      }

    }catch (e){
      return false;
    }

  }

  Future<bool> updatePassword(String newPassword) async {

    try{
      FlyternHttpResponse response = await patchRequest(ProfileHttpRequestEndpointUpdateUserPassword,
          {
            "newPassword":newPassword
          });


      if(response.success && response.statusCode == 200){
        return true;
      }else{
        return false;
      }

    }catch (e){
      return false;
    }

  }

  Future<String> changeMobile(String countryCode,String mobile) async {


    try{
      FlyternHttpResponse response = await postRequest(ProfileHttpRequestEndpointUpdateUserMobile,
          {
            "countryCode":countryCode,
            "mobile":mobile,
          });


      if(response.success && response.statusCode == 100){
        if (response.data.containsKey('userID')) {
          String userId = response.data["userID"] ?? "";
          return userId;
        }
        return "";
      }else{
        return "";
      }

    }catch (e){
      return "";
    }

  }

  Future<String> changeEmail(String email) async {

    try{
      FlyternHttpResponse response = await postRequest(ProfileHttpRequestEndpointUpdateUserEmail,
          {
            "email":email
          });


      if(response.success && response.statusCode == 100){
        if (response.data.containsKey('userID')) {
          String userId = response.data["userID"] ?? "";
          return userId;
        }
        return "";
      }else{
        return "";
      }

    }catch (e){
      return "";
    }

  }

  Future<UserDetails> getUserDetails() async {

    try{
      FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserDetails,null);

      if(response.success){
        if(response.data != null){
          UserDetails userDetails =  mapUserDetails(response.data,false);
          return userDetails;
        }
      }

      return mapUserDetails({},true);
    }catch (e){
      return mapUserDetails({},true);
    }



  }

  Future<List<UserTravelStory>> getUserTravelStories() async {
    try{

      FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserTravelStories,null);

      if(response.success){
        if(response.data != null){
          List<UserTravelStory> travelStories = [];
          response.data.forEach((element) {
            if(element !=null){
              travelStories.add(mapUserTravelStory(element));
            }

          });
          return travelStories;
        }
      }

      return [];
    }catch (e){
      return [];
    }

  }

 Future<bool> createTravelStory(UserTravelStory travelStory,  File? file) async {

    try{
      FlyternHttpResponse response = await fileUpload(
        travelStory.toJson(),
        file??null,'File',
        ProfileHttpRequestEndpointCreateUserTravelStory,"POST" );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        return true;
      }

    }catch (e){
      return true;
    }

  }

  Future<bool> createCoPax(UserCoPax userCoPax ) async {

    try{
      FlyternHttpResponse response = await postRequest(
          ProfileHttpRequestEndpointGetUserCreateCoPaxs,userCoPax.toJson() );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        return false;
      }

    }catch (e){
      return false;
    }

  }

  Future<bool> updateCoPax(UserCoPax userCoPax ) async {


    try{
      FlyternHttpResponse response = await postRequest(
          ProfileHttpRequestEndpointGetUserUpdateCoPaxs,userCoPax.toJson() );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        return false;
      }

    }catch (e){
      return false;
    }

  }

  Future<bool> deleteCoPax(int id ) async {


    try{
      FlyternHttpResponse response = await postRequest(
          "$ProfileHttpRequestEndpointGetUserDeleteCoPaxs$id",null );
      if(response.success && response.statusCode == 200){
        return true;
      }else{
        return false;
      }

    }catch (e){
      return false;
    }

  }

  Future<List<UserCoPax>> getUserCoPaxs() async {

    try{
      FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserCoPaxs,null);

      if(response.success){
        if(response.data != null){
          List<UserCoPax> coPaxes = [];
          response.data.forEach((element) {
            if(element !=null){
              coPaxes.add(mapUserCoPax(element));
            }

          });
          return coPaxes;
        }
      }

      return [];
    }catch (e){
      return [];
    }


  }

  Future<MyBookingResponse> getMyBookings(int pageId,String servicetype) async {


    try{

      FlyternHttpResponse response = await getRequest(ProfileHttpRequestEndpointGetUserBookings,
          {
            "pageid":pageId.toString(),
            "servicetype":servicetype,
          });

      if(response.success){
        if(response.data != null){
          MyBookingResponse myBookingResponse = mapMyBookingResponse(response.data);
          return myBookingResponse;
        }
      }

      return mapMyBookingResponse({});
    }catch (e){
      return mapMyBookingResponse({});
    }

  }

}