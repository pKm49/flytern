import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/shared_http_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {

  var selectedLanguage = "".obs;
  var languages = <Language>[].obs;
  var countries = <Country>[].obs;

  @override
  void onInit() {
    super.onInit();
    getInitialInfo();
  }

  changeLanguage(newLanguage) async {
    if (newLanguage != Lang_Arabic && newLanguage != Lang_English) {
      newLanguage = Lang_English;
    }
    selectedLanguage.value = newLanguage;
    Get.updateLocale(Locale(newLanguage));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('selectedLanguage', newLanguage);
  }

  Future<void> getInitialInfo() async {
    var sharedHttpService = SharedHttpService();

    SupportInfo supportInfo =
        await sharedHttpService.getInitialSupportInfo(
            true,
            "derMddvSkkWOsVGXObg-Wr:APA91bEL2QxF8TPLpH3uPsTaBeBz44LC9XTZhR3htfS1-hyjA5Dss9FJ8PqOLMvmjUK2VO2w8e3JxsyLfoyeUK0rXzbsf1xoCFJUeMUElSac-q3XGPZWpbsQf9IK7AITqafCVjzV5VPD"
        );

    languages.value = supportInfo.languages;
    countries.value = supportInfo.countries;

  }
}
