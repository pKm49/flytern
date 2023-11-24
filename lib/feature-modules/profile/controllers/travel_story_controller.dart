 import 'dart:io';
import 'package:flytern/feature-modules/profile/data/models/business-models/user-travelstory.dart';
import 'package:flytern/feature-modules/profile/services/http-services/profile_http.dart';
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

     bool isSuccess =  await profileHttpServices.createTravelStory(userTravelStory, file);

     if(isSuccess){
       Get.back();
       print("createTravelStory completed");
       isSubmitting.value = false;
       print("createTravelStory completed 1");

       showSnackbar(Get.context!,"travel_story_created".tr,"info");
       print("createTravelStory completed 2");


       print("createTravelStory completed 3");

       await getUserTravelStories();

     }

    }catch (e){
      print("createTravelStory failed");
      showSnackbar(Get.context!, e.toString(),"error");
      isSubmitting.value = false;
    }
  }


}
