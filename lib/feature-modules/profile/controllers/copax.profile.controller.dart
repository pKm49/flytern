import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/models/user-copax.profile.model.dart';
import 'package:flytern/feature-modules/profile/services/http.profile.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
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
  Rx<TextEditingController> titleController = TextEditingController().obs;

  var profileHttpServices = ProfileHttpServices();
  var title = "1".obs;
  var selectedTitle = Gender(code: "", name: "", isDefault: false).obs;
  var dob = DefaultInvalidDate.obs;
  var passportExpiry = DefaultInvalidDate.obs;
  var editCoPaxId = 0.obs;
  var gender = "Male".obs;
  var nationalityCode = "".obs;
  var passportIssuedCountryCode = "".obs;
  var isCreation = true.obs;
  var isSubmitting = false.obs;
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

  Future<void> createCoPax() async {
    isSubmitting.value = true;
    try {
      UserCoPax coPax = UserCoPax(
          title: selectedTitle.value.name,

          id: 0,
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

      bool isSuccess = await profileHttpServices.createCoPax(coPax);

      if (isSuccess) {
        Get.back();
        print("copax_created completed");
        isSubmitting.value = false;
        print("copax_created completed 1");

        showSnackbar(Get.context!,"copax_created".tr, "info");
        print("copax_created completed 2");

        initializeAuditData(true);
        print("copax_created completed 3");

        await getUserCoPassengers();
      }
    } catch (e) {
      print("copax_created failed");
      showSnackbar(Get.context!,e.toString(), "error");
      isSubmitting.value = false;
    }
  }

  Future<void> editCoPax() async {
    isSubmitting.value = true;
    try {
      UserCoPax coPax = UserCoPax(
        title: selectedTitle.value.name,
          id: editCoPaxId.value,
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

      bool isSuccess = await profileHttpServices.updateCoPax(coPax);

      if (isSuccess) {
        Get.back();
        print("copax_updated completed");
        isSubmitting.value = false;
        print("copax_updated completed 1");

        showSnackbar(Get.context!,"copax_updated".tr, "info");
        print("copax_updated completed 2");

        initializeAuditData(true);
        print("copax_updated completed 3");

        await getUserCoPassengers();
      }
    } catch (e) {
      print("copax_created failed");
      showSnackbar(Get.context!,e.toString(), "error");
      isSubmitting.value = false;
    }
  }

  Future<void> deleteCoPax(int id) async {
    isSubmitting.value = true;
    try {

      bool isSuccess = await profileHttpServices.deleteCoPax(id);

      if (isSuccess) {
        print("copax_created completed");

        await getUserCoPassengers();
        isSubmitting.value = false;
        print("copax_created completed 1");

        showSnackbar(Get.context!,"copax_deleted".tr, "info");
      }
    } catch (e) {
      print("copax_created failed");
      showSnackbar(Get.context!,e.toString(), "error");
      isSubmitting.value = false;
    }
  }

  void updateEditForm(UserCoPax userCopax) {
    if (userCopax.title == "Mr") {
      title.value = "1";
      selectedTitle.value = Gender(
          code: "1", name: "Mr", isDefault: false);
    } else {
      title.value = "2";
      selectedTitle.value = Gender(
          code: "2", name: "Mrs", isDefault: false);
    }
    editCoPaxId.value = userCopax.id;
    isCreation.value = false;
    gender.value =userCopax.gender;
    nationalityController.value.text =userCopax.nationalityName;
    passportCountryController.value.text = userCopax.passportIssuedCountryName;
    passportExpiryController.value.text = getFormattedDate(userCopax.passportExp);
    dobController.value.text = getFormattedDate(userCopax.dateOfBirth);
    firsNameController.value.text =userCopax.firstName;
    lastNameController.value.text = userCopax.lastName;
    passportNumberController.value.text = userCopax.passportNumber;
    dob.value = userCopax.dateOfBirth ;
    passportExpiry.value = userCopax.passportExp;
    nationalityCode.value = userCopax.nationalityCode;
    passportIssuedCountryCode.value = userCopax.passportIssuedCountryCode;
    isSubmitting = false.obs;
    Get.toNamed(Approute_profileAuditCopassenger);

  }

  String getFormattedDate(DateTime dateTime){
    final f = DateFormat('dd-MM-yyyy');
    return f.format(dateTime);
  }

  void changeTitle(String newGender) {
    title.value = newGender;
    if (newGender == "1") {
      selectedTitle.value = Gender(
          code: "1", name: "Mr", isDefault: false);
    } else {
      selectedTitle.value = Gender(
          code: "2", name: "Mrs", isDefault: false);
    }
  }
}