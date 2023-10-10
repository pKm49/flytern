import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/shared/data/constants/business_constants/available_countries.dart';
import 'package:flytern/shared/data/constants/business_constants/available_languages.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/shared_http_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {

  var selectedLanguage = Language(name: "English", code: "en").obs;
  var selectedCountry = Country(
      countryName: "India",
      countryCode: "IND",
      countryISOCode: "IN",
      countryName_Ar: "الهند",
      flag: "https://flagcdn.com/48x36/in.png",
      code: "+91").obs;

  var languages = <Language>[].obs;
  var countries = <Country>[].obs;

  @override
  void onInit() {
    super.onInit();

    languages.value = availableLanguages;
    countries.value = availableCountries;


  }

  changeLanguage(Language language) async {

    selectedLanguage.value = language;
    Get.updateLocale(Locale(language.code));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('selectedLanguage', language.code);
  }

  Future<void> getInitialInfo() async {
    print("shared getInitialInfo");

    var sharedHttpService = SharedHttpService();

    SupportInfo supportInfo = await sharedHttpService.getInitialSupportInfo();

    languages.value = supportInfo.languages;
    countries.value = supportInfo.countries;

    print("languages.value");
    print(languages.length);
    print(countries.length);
  }
}
