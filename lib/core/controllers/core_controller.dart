 import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreController extends GetxController {

  var selectedLanguage = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAuthToken();
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

  Future<void> getAuthToken() async {
    print("checkAuthStatusAndHandleRedirection");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');

    if(accessToken != null && accessToken !=''){

    }else{

    }

  }

}
