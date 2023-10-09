 import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/core/data/models/app-specific/auth_token.dart';
import 'package:flytern/core/services/http-services/core_http.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreController extends GetxController {

  var selectedLanguage = "".obs;

  @override
  void onInit() {
    super.onInit();
    setAuthToken();
  }

  changeLanguage(newLanguage) async {
    if (newLanguage != Lang_Arabic &&
        newLanguage != Lang_English) {
      newLanguage = Lang_English;
    }
    selectedLanguage.value = newLanguage;
    Get.updateLocale(Locale(newLanguage));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('selectedLanguage', newLanguage);
  }

  Future<void> setAuthToken() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var coreHttpServices = CoreHttpServices();

    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');

    if(accessToken != null && accessToken !='' &&
        refreshToken != null && refreshToken !='' &&
        expiryOnString != null && expiryOnString !=''){

      DateTime expiryOn = DateTime.parse(expiryOnString);

      if(DateTime.now().isAfter(expiryOn)){
        AuthToken authToken = await coreHttpServices.getRefreshedToken(refreshToken);
        if(authToken.accessToken != ""){
          saveAuthTokenToSharedPreference(authToken);
        }
      }

      return;

    }

    AuthToken authToken = await coreHttpServices.getGuestToken();

    if(authToken.accessToken != ""){
      saveAuthTokenToSharedPreference(authToken);
    }

  }

  saveAuthTokenToSharedPreference(AuthToken authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", authToken.accessToken);
    prefs.setString("refreshToken", authToken.refreshToken);
    prefs.setString("expiryOn", authToken.expiryOn.toString());
  }

}
