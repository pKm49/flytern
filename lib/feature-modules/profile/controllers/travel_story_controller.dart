 import 'dart:io';
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
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TravelStoryController extends GetxController {

  var isGuest = true.obs;
  var isSubmitting = false.obs;
  var isTravelStoriesDataLoading = true.obs;
  var userTravelStories = <UserTravelStory>[].obs;
  var profileHttpServices = ProfileHttpServices();


  @override
  void onInit() {
    super.onInit();
    getUserTravelStories();
  }


  Future<void> getUserTravelStories() async {
    isTravelStoriesDataLoading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');

    if(accessToken != null && accessToken !='' &&
        refreshToken != null && refreshToken !='' &&
        expiryOnString != null && expiryOnString !='' &&
        isGuest != null && !isGuest){

      List<UserTravelStory> travelStories = await profileHttpServices.getUserTravelStories();
      print("travelStories.length");
      print(travelStories.length);
      userTravelStories.value = travelStories;

    }
    isTravelStoriesDataLoading.value = false;

  }

  Future<void> addTravelStory(UserTravelStory userTravelStory, File? file) async {
    isSubmitting.value = true;
    try{
      await profileHttpServices.createTravelStory(userTravelStory, file);
      getUserTravelStories();
      isSubmitting.value = false;
      showSnackbar("travel_story_created","info");
      Get.back();
    }catch (e){
      showSnackbar( e.toString(),"error");
      isSubmitting.value = false;
    }
  }


}