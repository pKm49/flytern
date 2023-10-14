import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/data/models/business_models/login_credential.dart';
import 'package:flytern/feature-modules/auth/services/http-services/auth_http_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  Rx<TextEditingController> emailFieldController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  var errorMessage = "".obs;
  var isSubmitting = false.obs;

  var authHttpService = AuthHttpService();

  @override
  void onInit() {
    super.onInit();
  }

  submitLoginForm() async {

    LoginCredential loginCredential = LoginCredential(
        email: emailFieldController.value.text,
        password: passwordController.value.text
    );

    AuthToken authToken  = await authHttpService.login(loginCredential);
    if(authToken.accessToken != ""){
      saveAuthTokenToSharedPreference(authToken);
    }

    Get.offAllNamed(Approute_landingpage);
  }


}
