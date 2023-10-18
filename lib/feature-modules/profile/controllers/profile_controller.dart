 import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/feature-modules/profile/controllers/copax_controller.dart';
import 'package:flytern/feature-modules/profile/controllers/travel_story_controller.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-copax.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-travelstory.dart';
import 'package:flytern/feature-modules/profile/services/http-services/profile_http.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/models/business_models/auth_token.dart';
import 'package:flytern/core/services/http-services/core_http.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';
import 'package:flytern/shared/data/models/business_models/user_details.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {

  Rx<TextEditingController> firsNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> passportNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> nationalityController = TextEditingController().obs;
  Rx<TextEditingController> passportCountryController =
      TextEditingController().obs;
  Rx<TextEditingController> passportExpiryController =
      TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;

  var dob = DefaultInvalidDate.obs;
  var passportExpiry = DefaultInvalidDate.obs;
  var editCoPaxId = 0.obs;
  var gender = "Male".obs;
  var nationalityCode = "".obs;
  var passportIssuedCountryCode = "".obs;
  var isProfileSubmitting = false.obs;
  var isEmailSubmitting = false.obs;
  var isMobileSubmitting = false.obs;
  var profilePicture = "".obs;

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
      phoneNumber: "",
  genders: []).obs;
  final coPaxController = Get.put(CoPaxController());
  final travelStoryController = Get.put(TravelStoryController());
  var profileHttpServices = ProfileHttpServices();

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
    travelStoryController.getUserTravelStories();
    coPaxController.getUserCoPassengers();
  }

  Future<void> getUserDetails() async {

    isProfileDataLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

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

      if(tempUserDetails.genders.isNotEmpty){
        final sharedController = Get.find<SharedController>();
        sharedController.updateGenders(tempUserDetails.genders);
      }

    }

    isProfileDataLoading.value = false;

  }

  void changeGender(Gender newGender) {
    gender.value = newGender.code;
  }

  void changeNationality(Country country) {
    nationalityController.value.text =
    "${country.countryName} (${country.code})";
    nationalityCode.value = country.countryISOCode;
  }

  void changePassportCountry(Country country) {
    passportCountryController.value.text =
    "${country.countryName} (${country.code})";
    passportIssuedCountryCode.value = country.countryISOCode;
  }

  void changePassportExpiry(DateTime dateTime) {
    final f = DateFormat('dd-MM-yyyy');
    passportExpiryController.value.text = f.format(dateTime);
    passportExpiry.value = dateTime;
  }

  void changeDateOfBirth(DateTime dateTime) {
    final f = DateFormat('dd-MM-yyyy');
    dobController.value.text = f.format(dateTime);
    dob.value = dateTime;
  }

  void updateProfilePicture(String base64encode) {
    profilePicture.value = base64encode;
  }


  Future<void> updateProfile(File? file) async {
    isProfileSubmitting.value = true;
    try {
      UserDetails userDetails = UserDetails(
          gender: gender.value,
          firstName: firsNameController.value.text,
          lastName: lastNameController.value.text,
          passportNumber: passportNumberController.value.text,
          dateOfBirth: dob.value,
          passportIssuerCountryCode: passportIssuedCountryCode.value,
          passportIssuerCountryName: "",
          nationalityCode: nationalityCode.value,
          nationalityName: "",
          passportExpiry: passportExpiry.value,
          phoneCountryCode: '',
          imgUrl: '', userName: '', email: '', phoneNumber: '', genders: []);

      bool isSuccess = await profileHttpServices.updateUserDetails(userDetails,file);

      if (isSuccess) {
        Get.back();
        print("user update completed");
        isProfileSubmitting.value = false;
        print("user update completed 1");

        showSnackbar("copax_updated".tr, "info");
        print("user update completed 2");

        print("user update completed 3");

        await getUserDetails();
      }
    } catch (e) {
      print("user update failed");
      showSnackbar(e.toString(), "error");
      isProfileSubmitting.value = false;
    }
  }

}
