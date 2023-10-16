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

class RegisterController extends GetxController {

  Rx<TextEditingController> firsNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailFieldController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;

  var selectedCountry = Country(
      countryName: "India",
      countryCode: "IND",
      countryISOCode: "IN",
      countryName_Ar: "الهند",
      flag: "https://flagcdn.com/48x36/in.png",
      code: "+91").obs;

  var userId = "".obs;
  var profilePicture = "".obs;
  var errorMessage = "".obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isTermsAndPrivacyAgreed = false.obs;
  var isSubscribedToEmail = false.obs;
  var isSubmitting = false.obs;

  var authHttpService = AuthHttpService();

  @override
  void onInit() {
    super.onInit();
  }

  submitRegisterForm(File? file) async {

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

      String userIdFromApi  = await authHttpService.register(registerCredential,file);

      if(userIdFromApi != ""){
        userId.value = userIdFromApi;
        Get.offAllNamed(Approute_registerOtp);
      }else{
        throw Exception("Something Went wrong, Please Try Again");
      }
      isSubmitting.value = false;
    }catch (e,t){
      print(t);
      showSnackbar( e.toString(),"error");
      isSubmitting.value = false;
    }

  }

  void updateSubscriptionAgreement(bool bool) {
    isSubscribedToEmail.value = bool;
  }

  void updateTermsAndPrivacyAgreement(bool bool) {
    isTermsAndPrivacyAgreed.value = bool;
  }

  void updateProfilePicture(String base64encode) {
    profilePicture.value = base64encode;
  }

}
