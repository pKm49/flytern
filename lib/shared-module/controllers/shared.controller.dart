import 'dart:ui';

import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/business_specific/available_countries.shared.constant.dart';
import 'package:flytern/shared-module/constants/business_specific/available_genders.shared.constant.dart';
import 'package:flytern/shared-module/constants/business_specific/available_languages.shared.constant.dart';
import 'package:flytern/shared-module/constants/business_specific/info_types.shared.constant.dart';
import 'package:flytern/shared-module/models/set_device_info_request_body.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/models/business_doc.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/models/info_response_data.dart';
import 'package:flytern/shared-module/models/language.dart';
import 'package:flytern/shared-module/models/support_info.dart';
import 'package:flytern/shared-module/services/http-services/http.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {
  var otp = "".obs;
  var isOtpSubmitting = false.obs;
  var isInfoLoading = false.obs;

  var isSetDeviceLanguageAndCountrySubmitting = false.obs;
  var sharedHttpService = SharedHttpService();
  var selectedLanguage = Language(name: "English", code: "en").obs;
  var selectedCountry = Country(
          isDefault: 1,
          countryName: "Kuwait",
          countryCode: "KWT",
          countryISOCode: "KW",
          countryName_Ar: "الكويت",
          flag: "https://flagcdn.com/48x36/kw.png",
          code: "+965")
      .obs;

  var selectedMobileCountry = Country(
      isDefault: 1,
      countryName: "Kuwait",
      countryCode: "KWT",
      countryISOCode: "KW",
      countryName_Ar: "الكويت",
      flag: "https://flagcdn.com/48x36/kw.png",
      code: "+965")
      .obs;
   var genders = <Gender>[].obs;
  var languages = <Language>[].obs;
  var countries = <Country>[].obs;
  var mobileCountries = <Country>[].obs;
  var countriesToShow = <Country>[].obs;
  var mobileCountriesToShow = <Country>[].obs;

  var termsHtml = "".obs;
  var privacyHtml = "".obs;
  var aboutHtml = "".obs;
  var contactHtml = "".obs;
  var twitterLink = "".obs;
  var facebookLink = "".obs;
  var instagramLink = "".obs;
  var currentInfoTitle = "About Us".obs;
  var currentInfoType = InfoType.ABOUTUS.obs;

  @override
  void onInit() {
    super.onInit();
    genders.value = availableGenders;
    languages.value = availableLanguages;
    countries.value = availableCountries;
    countriesToShow.value = availableCountries;
  }

  changeLanguage(Language language) async {
    selectedLanguage.value = language;
    Get.updateLocale(Locale(language.code));
  }

  changeCountry(Country country) async {
    selectedCountry.value = country;
    updateCountryListByQuery("",false);
  }

  changeMobileCountry(Country country) async {
    selectedMobileCountry.value = country;
    updateCountryListByQuery("",true);
  }

  updateGenders(List<Gender> newGendersList) {
    genders.value = newGendersList;
  }

  updateCountryListByQuery(String query, bool isMobile) {
    print("updateCountryListByQuery");
    print(query);
    if (query == "") {
      countriesToShow.value = countries.value;
      mobileCountriesToShow.value = mobileCountries.value;
    } else {
      List<Country> tempCountries =  [];

      if(isMobile){
        tempCountries = mobileCountries.value
            .where((element) =>
        element.countryName.toLowerCase().contains(query.toLowerCase()) ||
            element.countryName_Ar
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.code.toLowerCase().contains(query.toLowerCase()) ||
            element.countryISOCode
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.countryCode.toLowerCase().contains(query.toLowerCase()))
            .toList();
        mobileCountriesToShow.value = tempCountries;
      }else{
        tempCountries = countries.value
            .where((element) =>
        element.countryName.toLowerCase().contains(query.toLowerCase()) ||
            element.countryName_Ar
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.code.toLowerCase().contains(query.toLowerCase()) ||
            element.countryISOCode
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.countryCode.toLowerCase().contains(query.toLowerCase()))
            .toList();
        countriesToShow.value = tempCountries;
      }


    }
  }

  Future<void> getInitialInfo() async {
    SupportInfo supportInfo = await sharedHttpService.getInitialSupportInfo();

    languages.value = supportInfo.languages;
    updateMobileCountryList(supportInfo.countries);
  }

  Future<void> getPreRegisterInfo() async {
    BusinessDoc businessDoc =
        await sharedHttpService.getPreRegisterSupportInfo();

    termsHtml.value = businessDoc.terms;
    privacyHtml.value = businessDoc.privacy;
  }

  Future<void> setDeviceLanguageAndCountry() async {
    isSetDeviceLanguageAndCountrySubmitting.value = true;
    String firebaseToken = await getFirebaseMessagingToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString('selectedLanguage', selectedLanguage.value.code);
    await sharedPreferences.setString('selectedCountry', selectedCountry.value.countryCode);

    SetDeviceInfoRequestBody setDeviceInfoRequestBody =
        SetDeviceInfoRequestBody(
            language: selectedLanguage.value.code,
            countryCode: selectedCountry.value.countryCode,
            notificationEnabled: true,
            notificationToken: firebaseToken);

    await sharedHttpService.setDeviceInfo(setDeviceInfoRequestBody);
    isSetDeviceLanguageAndCountrySubmitting.value = false;
    showSnackbar(Get.context!, "settings_updated".tr, "info");

    return;
  }

  Future<String> getFirebaseMessagingToken() async {
    // String firebaseMessagingToken = await FirebaseMessaging.instance.getToken()??"";
    // print('fcm : ' + firebaseMessagingToken);
    // return firebaseMessagingToken;
    return "123456896";
  }

  resendOtp(String userId) async {
    if (userId != "") {
      isOtpSubmitting.value = true;
      try {
        await sharedHttpService.resendOtp(userId);
        showSnackbar(Get.context!, "otp_resend".tr, "info");
        isOtpSubmitting.value = false;
      } catch (e, t) {
        print(t);
        showSnackbar(Get.context!, e.toString(), "error");
        isOtpSubmitting.value = false;
      }
    }
  }

  verifyOtp(String otp, String userId) async {
    if (userId != "") {
      isOtpSubmitting.value = true;
      try {
        AuthToken authToken = await sharedHttpService.verifyOtp(userId, otp);

        if (authToken.accessToken != "") {
          Get.back(result: authToken);
          isOtpSubmitting.value = false;
        }
      } catch (e, stack) {
        print("stack");
        print(stack);
        showSnackbar(Get.context!, e.toString(), "error");
        isOtpSubmitting.value = false;
      }
    }
  }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }

  getBusinessInfo(InfoType infoType) async {
    print("getBusinessInfo");
    print(isInfoLoading.value);

    if (!isInfoLoading.value) {
      currentInfoType.value = infoType;

      switch (infoType) {
        case InfoType.ABOUTUS:
          {
            currentInfoTitle.value = "about_us".tr;
            break;
          }
        case InfoType.TERMS:
          {
            currentInfoTitle.value = "terms_n_conditions".tr;

            break;
          }
        case InfoType.PRIVACY:
          {
            currentInfoTitle.value = "privacy_policy".tr;

            break;
          }
        case InfoType.CONTACTUS:
          {
            currentInfoTitle.value = "contact_us".tr;
            break;
          }
        case InfoType.SOCIAL:
          {
            currentInfoTitle.value = "social_account".tr;

            break;
          }
      }
      isInfoLoading.value = true;
      if (infoType != InfoType.SOCIAL) {
        Get.toNamed(Approute_coreInfoDoc);
      }

      InfoResponseData infoResponseData =
          await sharedHttpService.getInfo(infoType.name);

      print("content");
      print(infoResponseData.content);
      switch (infoType) {
        case InfoType.ABOUTUS:
          {
            aboutHtml.value = infoResponseData.content;
            currentInfoTitle.value = "about_us".tr;
            break;
          }
        case InfoType.TERMS:
          {
            termsHtml.value = infoResponseData.content;
            currentInfoTitle.value = "terms_n_conditions".tr;

            break;
          }
        case InfoType.PRIVACY:
          {
            privacyHtml.value = infoResponseData.content;
            currentInfoTitle.value = "privacy_policy".tr;

            break;
          }
        case InfoType.CONTACTUS:
          {
            contactHtml.value = infoResponseData.content;
            currentInfoTitle.value = "contact_us".tr;
            break;
          }
        case InfoType.SOCIAL:
          {
            twitterLink.value = infoResponseData.twitter;
            facebookLink.value = infoResponseData.facebook;
            instagramLink.value = infoResponseData.instagram;
            currentInfoTitle.value = "social_account".tr;

            break;
          }
      }

      isInfoLoading.value = false;
    }
  }

  Future<void> updateMobileCountryList(List<Country> mobileCountryList) async {

    mobileCountries.value = mobileCountryList;
    mobileCountriesToShow.value = mobileCountryList;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tSelectedCountry = prefs.getString('selectedMobileCountry');

    if ( tSelectedCountry != ''  ) {
      List<Country> tCountriesList = mobileCountryList.where((element) =>
      tSelectedCountry == element.countryCode).toList();

      if(tCountriesList.isNotEmpty){
        changeMobileCountry(tCountriesList[0]);
      }
    }else{

      List<Country> defaultCountry = countries.value.where((element) => element.isDefault==1).toList();
      if(defaultCountry.isNotEmpty){
        changeMobileCountry(defaultCountry[0]);
      }
    }
  }

  Future<void> updateCountryList(List<Country> countriesList) async {

    countries.value = countriesList;
    countriesToShow.value = countriesList;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
     final String? tSelectedCountry = prefs.getString('selectedCountry');

    if ( tSelectedCountry != ''  ) {
      List<Country> tCountriesList = countriesList.where((element) =>
      tSelectedCountry == element.countryCode).toList();

      if(tCountriesList.isNotEmpty){
        changeCountry(tCountriesList[0]);
      }
    }else{

      List<Country> defaultCountry = countries.value.where((element) => element.isDefault==1).toList();
      if(defaultCountry.isNotEmpty){
        changeCountry(defaultCountry[0]);
      }
    }


  }

}