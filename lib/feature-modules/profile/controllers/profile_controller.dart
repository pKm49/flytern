 import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/feature-modules/profile/services/http-services/profile_http.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/core/services/http-services/core_http.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/models/business_models/user_details.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {

  var isGuest = true.obs;
  var isProfileDataLoading = true.obs;

  var userDetails = UserDetails(gender: "",
      firstName: "",
      lastName: "",
      phoneCountryCode: "",
      imgUrl: "",
      passportNumber: "",
      dateOfBirth: DefaultInvalidDate,
      passportIssuerCountryCode: "",
      passportIssuerCountryName: "",
      nationalityCode: "",
      nationalityName: "",
      userName: "",
      email: "",
      passportExpiry: DefaultInvalidDate,
      phoneNumber: "").obs;


  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  Future<void> getUserDetails() async {

    isProfileDataLoading.value = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileHttpServices = ProfileHttpServices();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');

    if(accessToken != null && accessToken !='' &&
        refreshToken != null && refreshToken !='' &&
        expiryOnString != null && expiryOnString !='' &&
        isGuest != null && !isGuest){

      UserDetails tempUserDetails = await profileHttpServices.getUserDetails();
      if(tempUserDetails.firstName != ""){
        userDetails.value = tempUserDetails;
      }

    }

    isProfileDataLoading.value = true;

  }



}
