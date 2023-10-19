import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/shared/data/constants/business_constants/available_countries.dart';
import 'package:flytern/shared/data/constants/business_constants/available_genders.dart';
import 'package:flytern/shared/data/constants/business_constants/available_languages.dart';
import 'package:flytern/shared/data/models/app_specific/set_device_info_request_body.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/shared/data/models/business_models/business_doc.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/shared_http_services.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {

  var otp = "".obs;
  var isOtpSubmitting = false.obs;

  var isSetDeviceLanguageAndCountrySubmitting = false.obs;
  var sharedHttpService = SharedHttpService();
  var selectedLanguage = Language(name: "English", code: "en").obs;
  var selectedCountry = Country(
      countryName: "India",
      countryCode: "IND",
      countryISOCode: "IN",
      countryName_Ar: "الهند",
      flag: "https://flagcdn.com/48x36/in.png",
      code: "+91").obs;

  var genders = <Gender>[].obs;
  var languages = <Language>[].obs;
  var countries = <Country>[].obs;

  var termsHtml = "".obs;
  var privacyHtml = "".obs;

  @override
  void onInit() {
    super.onInit();
    genders.value = availableGenders;
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

  updateGenders(List<Gender> newGendersList){
    genders.value = newGendersList;
  }

  Future<void> getInitialInfo() async {
    SupportInfo supportInfo = await sharedHttpService.getInitialSupportInfo();

    languages.value = supportInfo.languages;
    countries.value = supportInfo.countries;
  }

  Future<void> getPreRegisterInfo() async {
    BusinessDoc businessDoc  = await sharedHttpService.getPreRegisterSupportInfo();

    termsHtml.value = businessDoc.terms;
    privacyHtml.value = businessDoc.privacy;

  }

  Future<void> setDeviceLanguageAndCountry() async {

    isSetDeviceLanguageAndCountrySubmitting.value = true;
    String firebaseToken = await getFirebaseMessagingToken();

    SetDeviceInfoRequestBody setDeviceInfoRequestBody = SetDeviceInfoRequestBody(
        language: selectedLanguage.value.code,
        countryCode: selectedCountry.value.countryCode,
        notificationEnabled: true,
        notificationToken: firebaseToken
    );

    await sharedHttpService.setDeviceInfo(setDeviceInfoRequestBody);
    isSetDeviceLanguageAndCountrySubmitting.value = false;
    return;
  }

  Future<String> getFirebaseMessagingToken() async {
    // String firebaseMessagingToken = await FirebaseMessaging.instance.getToken()??"";
    // print('fcm : ' + firebaseMessagingToken);
    // return firebaseMessagingToken;
    return "123456896";
  }

  resendOtp(String userId) async {

    if(userId !=""){
      isOtpSubmitting.value = true;
      try{

        await sharedHttpService.resendOtp(userId);
        showSnackbar("otp_resend".tr,"info");
        isOtpSubmitting.value = false;
      }catch (e,t){
        print(t);
        showSnackbar( e.toString(),"error");
        isOtpSubmitting.value = false;
      }

    }

  }

  verifyOtp(String otp, String userId) async {

    if(userId != ""){
      isOtpSubmitting.value = true;
      try{

        AuthToken authToken  = await sharedHttpService.verifyOtp(userId,otp);

        if(authToken.accessToken != ""){
          Get.back(result: authToken);
          isOtpSubmitting.value = false;
        }

      }catch (e,stack){
        print( "stack");
        print( stack);
        showSnackbar( e.toString(),"error");
        isOtpSubmitting.value = false;
      }
    }

  }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }

}
