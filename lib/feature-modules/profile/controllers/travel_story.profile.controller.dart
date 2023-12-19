 import 'dart:io';
import 'package:flytern/feature-modules/profile/models/user-travelstory.profile.model.dart';
import 'package:flytern/feature-modules/profile/services/http.profile.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
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

      userTravelStories.value = travelStories;

    }
    isTravelStoriesDataLoading.value = false;

  }

  Future<void> addTravelStory(UserTravelStory userTravelStory, File? file) async {
    isSubmitting.value = true;
    try{

     bool isSuccess =  await profileHttpServices.createTravelStory(userTravelStory, file);

     if(isSuccess){
       Get.back();
       isSubmitting.value = false;
       showSnackbar(Get.context!,"travel_story_created".tr,"info");
       await getUserTravelStories();
     }else{
       Get.back();
       showSnackbar(Get.context!, "something_went_wrong".tr, "error");
       isSubmitting.value = false;
     }

    }catch (e){
       showSnackbar(Get.context!, e.toString(),"error");
      isSubmitting.value = false;
    }
  }


}
