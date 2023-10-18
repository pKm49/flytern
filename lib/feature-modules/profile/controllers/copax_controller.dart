import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
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

class CoPaxController extends GetxController {
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
  var profileHttpServices = ProfileHttpServices();

  var dob = DefaultInvalidDate.obs;
  var passportExpiry= DefaultInvalidDate.obs;
  var gender = "Male".obs;
  var nationalityCode = "".obs;
  var passportIssuedCountryCode = "".obs;
  var isCreation = true.obs;
  var isSubmitting = true.obs;
  var isCopaxDataLoading = true.obs;
  var userCopaxes = <UserCoPax>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserCoPassengers();
  }

  Future<void> getUserCoPassengers() async {
    isCopaxDataLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');

    if (accessToken != null &&
        accessToken != '' &&
        refreshToken != null &&
        refreshToken != '' &&
        expiryOnString != null &&
        expiryOnString != '' &&
        isGuest != null &&
        !isGuest) {
      List<UserCoPax> coPaxes = await profileHttpServices.getUserCoPaxs();
      print("coPaxes.length");
      print(coPaxes.length);
      userCopaxes.value = coPaxes;
    }

    isCopaxDataLoading.value = false;
  }

  initializeAuditData(bool mode) {
    isCreation.value = mode;
    gender.value = "Male";
    nationalityController.value.text = "";
    passportCountryController.value.text = "";
    passportExpiryController.value.text = "";
    dobController.value.text = "";
    firsNameController.value.text = "";
    lastNameController.value.text = "";
    passportNumberController.value.text = "";
    dob.value = DefaultInvalidDate;
    passportExpiry.value = DefaultInvalidDate;
    nationalityCode.value = "";
    passportIssuedCountryCode.value = "";
    isSubmitting = false.obs;
  }

  void changeGender(Gender newGender) {
    gender.value = newGender.code;
  }

  void changeNationality(Country country) {
    nationalityController.value.text =
        "${country.countryName} (${country.code})";
    nationalityCode.value = country.countryCode;
  }

  void changePassportCountry(Country country) {
    passportCountryController.value.text =
        "${country.countryName} (${country.code})";
    passportIssuedCountryCode.value = country.countryCode;
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

  Future<void> createCoPax() async {
    isSubmitting.value = true;
    try{
      UserCoPax coPax = UserCoPax(
          gender: gender.value,
          firstName: firsNameController.value.text,
          lastName: lastNameController.value.text,
          passportNumber: passportNumberController.value.text,
          dateOfBirth: dob.value,
          passportIssuedCountryCode: passportIssuedCountryCode.value,
          passportIssuedCountryName: "",
          nationalityCode: nationalityCode.value,
          nationalityName: "",
          passportExp: passportExpiry.value);


      bool isSuccess =  await profileHttpServices.createCoPax(coPax);

      if(isSuccess){
        Get.back();
        print("copax_created completed");
        isSubmitting.value = false;
        print("copax_created completed 1");

        showSnackbar("copax_created".tr,"info");
        print("copax_created completed 2");

        initializeAuditData(true);
        print("copax_created completed 3");

        await getUserCoPassengers();

      }

    }catch (e){
      print("copax_created failed");
      showSnackbar( e.toString(),"error");
      isSubmitting.value = false;
    }


  }
}
