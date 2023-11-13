import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/login_credential.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/register_credential.dart';
import 'package:flytern/feature-modules/auth/services/http-services/auth_http_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {

  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;

  var selectedCountry = Country(
      isDefault: 1,
      countryName: "Kuwait",
      countryCode: "KWT",
      countryISOCode: "KW",
      countryName_Ar: "الكويت",
      flag: "https://flagcdn.com/48x36/kw.png",
      code: "+965").obs;

  var userId = "".obs;
  var otp = "".obs;
  var profilePicture = "".obs;
  var errorMessage = "".obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isSubmitting = false.obs;

  var authHttpService = AuthHttpService();

  @override
  void onInit() {
    super.onInit();
  }

  sendOtp() async {

    isSubmitting.value = true;
    try{

      String userIdFromApi  = await authHttpService.sendOtp(
      mobileController.value.text
      ,selectedCountry.value.code);

      if(userIdFromApi != ""){
        userId.value = userIdFromApi;
        Get.toNamed(Approute_resetPasswordOtp,arguments: [Approute_resetPasswordMobile,
          "${selectedCountry.value.code} ${mobileController.value.text}",userId.value])
            ?.then((value) async {
              print("valueee is");
              print(value);
          if(value is AuthToken){

                  if(value.accessToken != ""){
                    saveAuthTokenToSharedPreference(value);
                    Get.offNamed(Approute_resetPasswordNewpassword);
                  }

          }
          print("value");
          print(value.toString());
        });
      }else{
        throw Exception("Something Went wrong, Please Try Again");
      }
      isSubmitting.value = false;
    }catch (e,t){
      print(t);
      showSnackbar(Get.context!, e.toString(),"error");
      isSubmitting.value = false;
    }

  }

  // resendOtp( ) async {
  //
  //   if(userId.value !=""){
  //     isSubmitting.value = true;
  //     try{
  //
  //       await authHttpService.resendOtp(userId.value);
  //       showSnackbar(Get.context!,"otp_resend".tr,"info");
  //
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
  //
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
  //         Get.offNamed(Approute_resetPasswordNewpassword);
  //       }
  //       isSubmitting.value = false;
  //     }catch (e){
  //       showSnackbar(Get.context!, e.toString(),"error");
  //       isSubmitting.value = false;
  //     }
  //   }
  //
  // }

  updatePassword() async {

    if(userId.value != ""){
      isSubmitting.value = true;
      try{
       await authHttpService.updatePassword(passwordController.value.text);
       showSnackbar(Get.context!,
           "password_updated".tr, "info");
       Get.offAllNamed(Approute_authSelector);
       isSubmitting.value = false;
      }catch (e){
        showSnackbar(Get.context!, e.toString(),"error");
        isSubmitting.value = false;
      }
    }

  }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }

  void updateProfilePicture(String base64encode) {
    profilePicture.value = base64encode;
  }

}
