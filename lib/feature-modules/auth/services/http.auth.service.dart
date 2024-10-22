import 'dart:io';

import 'package:flytern/feature-modules/auth/constants/http_request_endpoints.auth.constant.dart';
import 'package:flytern/feature-modules/auth/models/login_credential.auth.model.dart';
import 'package:flytern/feature-modules/auth/models/register_credential.auth.model.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';
import 'package:get/get.dart';

class AuthHttpService {
  Future<AuthToken> login(LoginCredential loginCredential) async {
    try {
      FlyternHttpResponse response = await postRequest(
          AuthHttpRequestEndpointLogin, loginCredential.toJson());

      if (response.success && response.data != null) {
        if (response.data.containsKey('userID')) {
          String userId = response.data["userID"] ?? "";
          AuthToken authToken = AuthToken(
              accessToken: "",
              refreshToken: userId,
              expiryOn: DateTime.now(),
              isGuest: false);
          return authToken;
        } else {
          AuthToken authToken = mapAuthToken(response.data, false);
          return authToken;
        }
      } else {
         throw (response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr);
      }
    } catch (e) {

      rethrow;

    }
  }

  Future<String> register(
      RegisterCredential registerCredential, File? file) async {
    try {
      FlyternHttpResponse response = await fileUpload(
          registerCredential.toJson(),
          file ?? null,
          'File',
          AuthHttpRequestEndpointRegister,
          "POST");

      if (response.success && response.data != null) {
        String userId = response.data["userID"] ?? "";
        if(userId !=""){
          return userId;
        }else{
          throw (response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr);
        }
      } else {
        throw (response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> sendOtp(String mobile, String countryCode) async {

    try {
      FlyternHttpResponse response = await postRequest(
          AuthHttpRequestEndpointForgetPassword,
          {"mobile": mobile, "countryCode": countryCode});

      if (response.success && response.statusCode == 100) {
        if (response.data.containsKey('userID')) {
          String userId = response.data["userID"] ?? "";
          return userId;
        }
        throw (response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr);
      } else {
        throw (response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePassword(String newPassword) async {
    try {
    FlyternHttpResponse response = await patchRequest(
        AuthHttpRequestEndpointChangePassword, {"newPassword": newPassword});

      if (response.success && response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
