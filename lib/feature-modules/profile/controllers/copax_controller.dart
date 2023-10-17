 import 'dart:ui';

import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-copax.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-travelstory.dart';
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

class CoPaxController extends GetxController {

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

}
