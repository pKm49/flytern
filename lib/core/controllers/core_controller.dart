 import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreController extends GetxController {

  var selectedLanguage = "".obs;
  var isLoading = true.obs;
  var themes = [].obs;

  int loggedInUserCallCount = 0;

  @override
  void onInit() {
    super.onInit();
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

}
