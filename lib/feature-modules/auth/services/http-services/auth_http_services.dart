import 'dart:io';

import 'package:flytern/feature-modules/auth/data/constants/app_specific/auth_http_request_endpoints.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/login_credential.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/register_credential.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class AuthHttpService {

  Future<AuthToken > login(LoginCredential loginCredential ) async {
    FlyternHttpResponse response = await postRequest(
        AuthHttpRequestEndpointLogin, loginCredential.toJson());

    print(" response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

   try{
     if(response.success && response.data != null){
       AuthToken authToken = mapAuthToken(response.data, false);
       return authToken;
     }else{
       throw Exception(response.errors[0]);
     }
   }catch (e){
     rethrow;
   }

  }

  Future<String > register(RegisterCredential registerCredential, File? file ) async {
    FlyternHttpResponse response = await fileUpload(
      registerCredential.toJson(),
      file??null,'File',
        AuthHttpRequestEndpointRegister, );

    print(" response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);
    print(response.data);

    try{
      if(response.success && response.data != null){
        String userId = response.data["userID"]??"";
        return userId;
      }else{
        throw Exception(response.errors[0]);
      }
    }catch (e){
      rethrow;
    }

  }

  Future<String > sendOtp(String mobile, String countryCode ) async {
    FlyternHttpResponse response = await postRequest(
        AuthHttpRequestEndpointForgetPassword, {"mobile":mobile,"countryCode":countryCode});

    print("sendOtp response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);


    try{
      if(response.success && response.data != null){
        String userId = response.data["userID"]??"";
        return userId;
      }else{
        throw Exception(response.errors[0]);
      }
    }catch (e){
      rethrow;
    }
  }

  Future<void > resendOtp(String userId ) async {
    FlyternHttpResponse response = await postRequest(
        AuthHttpRequestEndpointResendOTP, {"userID":userId});

    print("resendOtp response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try{
      if(response.success && response.data != null){
        return;
      }else{
        throw Exception(response.errors[0]);
      }
    }catch (e){
      rethrow;
    }

  }

  Future<AuthToken > verifyOtp( String userId, String otp  ) async {
    print("verifyOtp");
    print(otp);
    print(userId);
    FlyternHttpResponse response = await postRequest(
        AuthHttpRequestEndpointVerifyOTP, {"otp":otp,"userID":userId});

    print(" response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try{
      if(response.success && response.data != null){
        AuthToken authToken = mapAuthToken(response.data, false);
        return authToken;
      }else{
        throw Exception(response.errors[0]);
      }
    }catch (e){
      rethrow;
    }

  }

  Future<void > updatePassword(  String newPassword ) async {
    FlyternHttpResponse response = await patchRequest(
        AuthHttpRequestEndpointChangePassword, {"newPassword":newPassword });

    print("updatePassword response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try{
      if(response.success && response.statusCode == 200){
        return;
      }else{
        throw Exception(response.errors[0]);
      }
    }catch (e){
      rethrow;
    }

  }
}
