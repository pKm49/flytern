import 'dart:developer';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
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
import 'package:flytern/shared-module/services/utility-services/local_storage_handler.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedController extends GetxController {

  var isAuthTokenSet = false.obs;

  var otp = "".obs;
  var otpResendCount = 0.obs;
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
  var genderList = <Gender>[].obs;
  var titleList = <Gender>[].obs;

  var termsHtml = "".obs;
  var privacyHtml = "".obs;
  var aboutHtml = "".obs;
  var contactHtml = "".obs;
  var twitterLink = "".obs;
  var facebookLink = "".obs;
  var instagramLink = "".obs;
  var currentInfoTitle = "About Us".obs;
  var currentInfoType = InfoType.ABOUTUS.obs;


  var paymentGatewayIsLoading = true.obs;
  var paymentGatewayIsBackConfirmed = false.obs;

  @override
  void onInit() {
    super.onInit();
    setAuthToken();
    genders.value = availableGenders;
    languages.value = availableLanguages;
    countries.value = availableCountries;
    countriesToShow.value = availableCountries;
  }

  Future<void> setAuthToken() async {
    isAuthTokenSet.value = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var sharedHttpService = SharedHttpService();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');
    final String? selectedLanguage = prefs.getString('selectedLanguage');
    final String? selectedMobileCountry = prefs.getString('selectedMobileCountry');

    if (accessToken != null &&
        accessToken != '' &&
        refreshToken != null &&
        refreshToken != '' &&
        expiryOnString != null &&
        expiryOnString != '' &&
        !isGuest!) {
      DateTime expiryOn = DateTime.parse(expiryOnString);

      if (DateTime.now().isAfter(expiryOn)) {
        AuthToken authToken = await sharedHttpService.getRefreshedToken();
        if (authToken.accessToken != "") {
          saveAuthTokenToSharedPreference(authToken);
        }
      }
      Get.offAllNamed(Approute_landingpage);
    } else {
      AuthToken authToken = await sharedHttpService.getGuestToken();

      if (authToken.accessToken != "") {
        saveAuthTokenToSharedPreference(authToken);
      }

      if (selectedLanguage != null &&
          selectedLanguage != '' &&
          selectedMobileCountry != null &&
          selectedMobileCountry != '' ){
        Get.offAllNamed(Approute_landingpage);
      }
      isAuthTokenSet.value = true;
    }

    final sharedController = Get.find<SharedController>();
     setDeviceLanguageAndCountry(false,false);
    sharedController.getInitialInfo();
    sharedController.getPreRegisterInfo();
  }


  Future<void> handleLogout() async {
    AuthToken authToken = AuthToken(
        accessToken: "",
        refreshToken: "",
        expiryOn: DateTime.now(),
        isGuest: true);
    saveAuthTokenToSharedPreference(authToken);
    setAuthToken();
    Get.offAllNamed(Approute_login);
  }



  changeLanguage(Language language) async {
    selectedLanguage.value = language;
    Get.updateLocale(Locale(language.code));
  }

  changeCountry(Country country) async {
    selectedCountry.value = country;
    updateCountryListByQuery("", false);
  }

  changeMobileCountry(Country country) async {
    selectedMobileCountry.value = country;
    updateCountryListByQuery("", true);
  }

  updateGenders(List<Gender> newGendersList) {
    genders.value = newGendersList;
  }

  updateCountryListByQuery(String query, bool isMobile) {

    if (query == "") {
      if (isMobile) {
        mobileCountriesToShow.value = mobileCountries.value;
      } else {
        countriesToShow.value = countries.value;
      }
    } else {
      List<Country> tempCountries = [];

      if (isMobile) {
        tempCountries = mobileCountries.value
            .where((element) =>
                element.countryName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
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
      } else {
        tempCountries = countries.value
            .where((element) =>
                element.countryName
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
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
    titleList.value = supportInfo.titleList;
    genderList.value = supportInfo.genderList;

    updateMobileCountryList(supportInfo.mobileCountryList);
    updateCountryList(supportInfo.countriesList);
  }

  Future<void> getPreRegisterInfo() async {
    BusinessDoc businessDoc =
        await sharedHttpService.getPreRegisterSupportInfo();
    log("getPreRegisterInfo");
    log(businessDoc.privacy);
    termsHtml.value = businessDoc.terms;
    privacyHtml.value = businessDoc.privacy;
  }

  Future<void> setDeviceLanguageAndCountry(bool isRedirection,bool isToast) async {
    isSetDeviceLanguageAndCountrySubmitting.value = true;
    await Future<void>.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    String firebaseToken = await getFirebaseMessagingToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(
        'selectedLanguage', selectedLanguage.value.code);
    await sharedPreferences.setString(
        'selectedMobileCountry', selectedCountry.value.countryCode);

    SetDeviceInfoRequestBody setDeviceInfoRequestBody =
        SetDeviceInfoRequestBody(
            language: selectedLanguage.value.code,
            countryCode: selectedCountry.value.countryCode,
            notificationEnabled: true,
            notificationToken: firebaseToken);

    await sharedHttpService.setDeviceInfo(setDeviceInfoRequestBody);
    isSetDeviceLanguageAndCountrySubmitting.value = false;
    if(isToast){
      showSnackbar(Get.context!, "settings_updated".tr, "info");
    }
    if(isRedirection){
      Get.toNamed(Approute_authSelector);
    }

  }

  Future<String> getFirebaseMessagingToken() async {
    try{
      await Future.delayed(const Duration(seconds: 2));
      String firebaseMessagingToken = await FirebaseMessaging.instance.getToken()??"";
      print("firebaseMessagingToken");
      print(firebaseMessagingToken);
      return firebaseMessagingToken;
    }catch (e){
      return e.toString();
    }

  }

  resetOtpResendCount(){
    otp.value = "";
    otpResendCount.value = 0;
  }

  resendOtp(String userId) async {
    if (userId != "" && otpResendCount.value<3) {
      isOtpSubmitting.value = true;
      try {
        await sharedHttpService.resendOtp(userId);
        otpResendCount.value = otpResendCount.value +1;
        showSnackbar(Get.context!, "otp_resend".tr, "info");
        isOtpSubmitting.value = false;
      } catch (e, t) {
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
         showSnackbar(Get.context!, e.toString(), "error");
        isOtpSubmitting.value = false;
      }
    }
  }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }

  getBusinessInfo(InfoType infoType) async {

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

    if (tSelectedCountry != '') {
      List<Country> tCountriesList = mobileCountryList
          .where((element) => tSelectedCountry == element.countryCode)
          .toList();

      if (tCountriesList.isNotEmpty) {
        changeMobileCountry(tCountriesList[0]);
      }
    } else {
      List<Country> defaultCountry =
          countries.value.where((element) => element.isDefault == 1).toList();
      if (defaultCountry.isNotEmpty) {
        changeMobileCountry(defaultCountry[0]);
      }
    }
  }

  Future<void> updateCountryList(List<Country> countriesList) async {
    countries.value = countriesList;
    countriesToShow.value = countriesList;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tSelectedCountry = prefs.getString('selectedCountry');

    if (tSelectedCountry != '') {
      List<Country> tCountriesList = countriesList
          .where((element) => tSelectedCountry == element.countryCode)
          .toList();

      if (tCountriesList.isNotEmpty) {
        changeCountry(tCountriesList[0]);
      }
    } else {
      List<Country> defaultCountry =
          countries.value.where((element) => element.isDefault == 1).toList();
      if (defaultCountry.isNotEmpty) {
        changeCountry(defaultCountry[0]);
      }
    }
  }

  void resetCountryList() {
    mobileCountriesToShow.value = mobileCountries;
    countriesToShow.value = countries;
  }

  paymentGatewayGoback(bool status, String summaryPageUrl){
    print("paymentGatewayGoback");
      Get.back(result: status);
  }

  void changePaymentGatewayLoading(bool status) {
    paymentGatewayIsLoading.value = status;
  }

  void changePaymentGatewayBackConfirmation() {
    paymentGatewayIsBackConfirmed.value = !paymentGatewayIsBackConfirmed.value;

  }
}
