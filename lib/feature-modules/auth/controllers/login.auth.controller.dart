import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/models/login_credential.auth.model.dart';
import 'package:flytern/feature-modules/auth/services/http.auth.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/services/utility-services/local_storage_handler.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
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

    isSubmitting.value = true;

    try{

      LoginCredential loginCredential = LoginCredential(
          email: emailFieldController.value.text,
          password: passwordController.value.text
      );

      AuthToken authToken  = await authHttpService.login(loginCredential);

      if(authToken.accessToken != ""){

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
        });
      }
      isSubmitting.value = false;
    }catch (e){
      showSnackbar(Get.context!, e.toString(),"error");
      isSubmitting.value = false;
    }

  }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }


}
