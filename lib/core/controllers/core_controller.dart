import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/core/data/models/business-specific/notification.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/core/services/http-services/core_http.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreController extends GetxController {
  var isAuthTokenSet = false.obs;
  var notifications = <Notification>[].obs;
  var isNotificationsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    setAuthToken();
  }

  Future<void> setAuthToken() async {
    isAuthTokenSet.value = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var coreHttpServices = CoreHttpServices();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');
    final String? selectedLanguage = prefs.getString('selectedLanguage');
    final String? selectedCountry = prefs.getString('selectedCountry');

    if (accessToken != null &&
        accessToken != '' &&
        refreshToken != null &&
        refreshToken != '' &&
        expiryOnString != null &&
        expiryOnString != '' &&
        !isGuest!) {
      DateTime expiryOn = DateTime.parse(expiryOnString);

      if (DateTime.now().isAfter(expiryOn)) {
        AuthToken authToken = await coreHttpServices.getRefreshedToken();
        if (authToken.accessToken != "") {
          saveAuthTokenToSharedPreference(authToken);
        }
      }
      Get.offAllNamed(Approute_landingpage);
    } else {
      AuthToken authToken = await coreHttpServices.getGuestToken();

      if (authToken.accessToken != "") {
        saveAuthTokenToSharedPreference(authToken);
      }
  print("selectedLanguage & selectedCountry");
  print(selectedLanguage);
  print(selectedCountry);
      if (selectedLanguage != null &&
          selectedLanguage != '' &&
          selectedCountry != null &&
          selectedCountry != '' ){
        Get.offAllNamed(Approute_landingpage);
      }
      isAuthTokenSet.value = true;
    }

    final sharedController = Get.find<SharedController>();
    sharedController.getInitialInfo();
    sharedController.getPreRegisterInfo();
  }

  getNotifications() async {
    isNotificationsLoading.value = true;
    var coreHttpServices = CoreHttpServices();
    notifications.value = await coreHttpServices.getNotifications();
    isNotificationsLoading.value = false;
  }

  Future<void> handleLogout() async {
    AuthToken authToken = AuthToken(
        accessToken: "",
        refreshToken: "",
        expiryOn: DateTime.now(),
        isGuest: true);
    saveAuthTokenToSharedPreference(authToken);
    setAuthToken();
    Get.offAllNamed(Approute_langaugeSelector);
  }
}
