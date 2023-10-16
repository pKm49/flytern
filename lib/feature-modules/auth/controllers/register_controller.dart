import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/login_credential.dart';
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

  var profilePicture = "".obs;
  var errorMessage = "".obs;
  var isSubmitting = false.obs;

  var authHttpService = AuthHttpService();

  @override
  void onInit() {
    super.onInit();
  }

  submitLoginForm() async {

    isSubmitting.value = true;
    try{

      LoginCredential loginCredential = LoginCredential(
          email: emailFieldController.value.text,
          password: passwordController.value.text
      );

      AuthToken authToken  = await authHttpService.login(loginCredential);

      if(authToken.accessToken != ""){
        saveAuthTokenToSharedPreference(authToken);
        Get.offAllNamed(Approute_landingpage);
      }
      isSubmitting.value = false;
    }catch (e){
      showSnackbar( e.toString(),"error");
      isSubmitting.value = false;
    }

  }

}
