import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/login_credential.dart';
import 'package:flytern/feature-modules/auth/services/http-services/auth_http_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  Rx<TextEditingController> emailFieldController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  var userId = "".obs;
  var otp = "".obs;
  var errorMessage = "".obs;
  var isSubmitting = false.obs;
  var isPasswordVisible = false.obs;

  var authHttpService = AuthHttpService();

  updatePasswordVisibility(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  submitLoginForm(bool isDirectFlow) async {
  print("submitLoginForm");
  print(isDirectFlow);
    isSubmitting.value = true;

    try{

      LoginCredential loginCredential = LoginCredential(
          email: emailFieldController.value.text,
          password: passwordController.value.text
      );

      AuthToken authToken  = await authHttpService.login(loginCredential);

      if(authToken.accessToken != ""){
        print("accessToken not empty");
        print(isDirectFlow);
        saveAuthTokenToSharedPreference(authToken);
        if(!isDirectFlow){
          Get.back(result: true);
        }else{
          Get.offAllNamed(Approute_landingpage);
        }
      }else{
        userId.value = authToken.refreshToken;
        Get.toNamed(Approute_registerOtp,
            arguments: [Approute_login,
          "your_mobile".tr,userId.value])
            ?.then((value) async {
          print("valueee is");
          print(value);
          if(value is AuthToken){

            if(value.accessToken != ""){
              saveAuthTokenToSharedPreference(value);
              if(!isDirectFlow){
                Get.back(result: true);
              }else{
                Get.offAllNamed(Approute_landingpage);
              }
            }

          }
          print("value");
          print(value.toString());
        });
      }
      isSubmitting.value = false;
    }catch (e){
      showSnackbar(Get.context!, e.toString(),"error");
      isSubmitting.value = false;
    }

  }

  // verifyOtp(String otp) async {
  //
  //   if(userId.value != ""){
  //     isSubmitting.value = true;
  //     try{
  //
  //       AuthToken authToken  = await authHttpService.verifyOtp(userId.value,otp);
  //
  //       if(authToken.accessToken != ""){
  //         saveAuthTokenToSharedPreference(authToken);
  //         Get.offAllNamed(Approute_landingpage);
  //       }
  //       isSubmitting.value = false;
  //     }catch (e){
  //       showSnackbar(Get.context!, e.toString(),"error");
  //       isSubmitting.value = false;
  //     }
  //   }
  //
  // }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }

  // resendOtp( ) async {
  //
  //   if(userId.value !=""){
  //     isSubmitting.value = true;
  //     try{
  //
  //       await authHttpService.resendOtp(userId.value);
  //       showSnackbar(Get.context!,"otp_resend".tr,"info");
  //       isSubmitting.value = false;
  //     }catch (e,t){
  //       print(t);
  //       showSnackbar(Get.context!, e.toString(),"error");
  //       isSubmitting.value = false;
  //     }
  //
  //   }
  //
  // }


}
