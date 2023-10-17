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
import 'package:flytern/shared/data/models/business_models/gender.dart';
import 'package:flytern/shared/data/models/business_models/user_details.dart';
import 'package:flytern/shared/services/utility-services/shared_preference_handler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoPaxController extends GetxController {

  Rx<TextEditingController> firsNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> passportNumberController = TextEditingController().obs;

  var nationalityCode = "".obs;
  var passportIssuedCountryCode = "".obs;
  var dateOfBirth = "".obs;
  var passportExp = "".obs;
  var gender = "Male".obs;

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
    var profileHttpServices = ProfileHttpServices();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');

    if(accessToken != null && accessToken !='' &&
        refreshToken != null && refreshToken !='' &&
        expiryOnString != null && expiryOnString !='' &&
        isGuest != null && !isGuest){

      List<UserCoPax> coPaxes = await profileHttpServices.getUserCoPaxs();
      print("coPaxes.length");
      print(coPaxes.length);
      userCopaxes.value = coPaxes;

    }

    isCopaxDataLoading.value = false;

  }

  initializeAuditData(){
    gender.value = "Male";
    nationalityCode.value = "IN";
    passportIssuedCountryCode.value = "IN";
    dateOfBirth.value = "";
    passportExp.value = "";
    firsNameController.value.text = "";
    lastNameController.value.text = "";
    passportNumberController.value.text = "";
    Get.toNamed(Approute_profileAuditCopassenger);
  }

  void changeGender(Gender newGender) {
    gender.value = newGender.code;
  }

}
