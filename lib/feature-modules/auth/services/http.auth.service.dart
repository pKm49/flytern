import 'dart:io';

import 'package:flytern/feature-modules/auth/constants/http_request_endpoints.auth.constant.dart';
import 'package:flytern/feature-modules/auth/models/login_credential.auth.model.dart';
import 'package:flytern/feature-modules/auth/models/register_credential.auth.model.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

class AuthHttpService {
  Future<AuthToken> login(LoginCredential loginCredential) async {
    FlyternHttpResponse response = await postRequest(
        AuthHttpRequestEndpointLogin, loginCredential.toJson());

    print(" response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try {
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
        throw Exception(response.errors[0]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> register(
      RegisterCredential registerCredential, File? file) async {
    FlyternHttpResponse response = await fileUpload(registerCredential.toJson(),
        file ?? null, 'File', AuthHttpRequestEndpointRegister, "POST");

    print(" response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);
    print(response.data);

    try {
      if (response.success && response.data != null) {
        String userId = response.data["userID"] ?? "";
        return userId;
      } else {
        throw Exception(response.errors[0]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> sendOtp(String mobile, String countryCode) async {
    FlyternHttpResponse response = await postRequest(
        AuthHttpRequestEndpointForgetPassword,
        {"mobile": mobile, "countryCode": countryCode});

    print("sendOtp response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try {
      if(response.success && response.statusCode == 100){
        if (response.data.containsKey('userID')) {
          String userId = response.data["userID"] ?? "";
          return userId;
        }
        return "";
      }else{
        throw Exception(response.errors[0]);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(String newPassword) async {
    FlyternHttpResponse response = await patchRequest(
        AuthHttpRequestEndpointChangePassword, {"newPassword": newPassword});

    print("updatePassword response.message ");
    print(response.message);
    print(response.errors);
    print(response.success);

    try {
      if (response.success && response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.errors[0]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
