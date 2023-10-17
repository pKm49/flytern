 import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/core/services/http-services/core_http.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {

  var isAuthTokenSet = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  Future<void> getUserDetails() async {

    isAuthTokenSet.value = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var coreHttpServices = CoreHttpServices();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');

    if(accessToken != null && accessToken !='' &&
        refreshToken != null && refreshToken !='' &&
        expiryOnString != null && expiryOnString !='' &&
        !isGuest!){

      DateTime expiryOn = DateTime.parse(expiryOnString);

      if(DateTime.now().isAfter(expiryOn)){
        AuthToken authToken = await coreHttpServices.getRefreshedToken();
        if(authToken.accessToken != ""){
          saveAuthTokenToSharedPreference(authToken);
        }
      }
      Get.offAllNamed(Approute_landingpage);

    }else{
      AuthToken authToken = await coreHttpServices.getGuestToken();

      if(authToken.accessToken != ""){
        saveAuthTokenToSharedPreference(authToken);
      }
    }


    isAuthTokenSet.value = true;
    final sharedController = Get.find<SharedController>();
    sharedController.getInitialInfo();
    sharedController.getPreRegisterInfo();
  }



}
