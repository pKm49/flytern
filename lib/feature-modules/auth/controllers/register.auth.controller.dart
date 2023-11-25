import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/models/register_credential.auth.model.dart';
import 'package:flytern/feature-modules/auth/services/http.auth.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/local_storage_handler.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {

  Rx<TextEditingController> firsNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailFieldController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;

  var isPasswordVisible = false.obs;
  var isProfilePictureSelected = false.obs;
  var isConfirmPasswordVisible = false.obs;

  late File profilePictureFile;

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
  var isTermsAndPrivacyAgreed = false.obs;
  var isSubscribedToEmail = false.obs;
  var isSubmitting = false.obs;

  var authHttpService = AuthHttpService();

  @override
  void onInit() {
    super.onInit();
  }

  submitRegisterForm(bool isDirectFlow ) async {

    isSubmitting.value = true;
    try{

      RegisterCredential registerCredential = RegisterCredential(
          Email: emailFieldController.value.text,
          Password: passwordController.value.text,
          FirstName: firsNameController.value.text,
          LastName: lastNameController.value.text,
          PhoneNumber: mobileController.value.text,
          CountryCode: selectedCountry.value.code,
          IsEmailSubscription:isSubscribedToEmail.value
      );

      String userIdFromApi  = await authHttpService.register(registerCredential,isProfilePictureSelected.value?
      profilePictureFile:null);

      if(userIdFromApi != ""){
        userId.value = userIdFromApi;
        Get.toNamed(Approute_registerOtp,arguments: [Approute_registerPersonalData,
          "${emailFieldController.value.text}",userId.value])
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

  updatePasswordVisibility(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  updateConfirmPasswordVisibility(){
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }

  void updateSubscriptionAgreement(bool bool) {
    isSubscribedToEmail.value = bool;
  }

  void updateTermsAndPrivacyAgreement(bool bool) {
    isTermsAndPrivacyAgreed.value = bool;
  }

  void updateProfilePicture(String base64encode, File pictureFile) {
    profilePicture.value = base64encode;
    profilePictureFile = pictureFile;
    isProfilePictureSelected.value = true;
  }

}
