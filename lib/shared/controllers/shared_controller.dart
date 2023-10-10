import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/shared/data/constants/business_constants/available_countries.dart';
import 'package:flytern/shared/data/constants/business_constants/available_languages.dart';
import 'package:flytern/shared/data/models/app_specific/set_device_info_request_body.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/shared_http_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {

  var setDeviceLanguageAndCountrySubmitting = false.obs;
  var sharedHttpService = SharedHttpService();
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

  changeCountry(Country country) async {
    selectedCountry.value = country;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('selectedCountry', country.countryCode);
  }

  Future<void> getInitialInfo() async {
    SupportInfo supportInfo = await sharedHttpService.getInitialSupportInfo();

    languages.value = supportInfo.languages;
    countries.value = supportInfo.countries;
  }

  Future<void> setDeviceLanguageAndCountry() async {

    setDeviceLanguageAndCountrySubmitting.value = true;
    String firebaseToken = await getFirebaseMessagingToken();

    SetDeviceInfoRequestBody setDeviceInfoRequestBody = SetDeviceInfoRequestBody(
        language: selectedLanguage.value.code,
        countryCode: selectedCountry.value.countryCode,
        notificationEnabled: true,
        notificationToken: firebaseToken
    );

    await sharedHttpService.setDeviceInfo(setDeviceInfoRequestBody);
    setDeviceLanguageAndCountrySubmitting.value = false;
    return;
  }


  Future<String> getFirebaseMessagingToken() async {
    // String firebaseMessagingToken = await FirebaseMessaging.instance.getToken()??"";
    // print('fcm : ' + firebaseMessagingToken);
    // return firebaseMessagingToken;
    return "123456896";
  }

}
