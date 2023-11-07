
 import 'package:flytern/feature-modules/activity_booking/data/models/activity_city.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_details.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_response.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_submission_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/destination_response.dart';
import 'package:flytern/feature-modules/activity_booking/services/http-services/activity_booking_http_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';

class ActivityBookingController extends GetxController {

  var isActivitysLoading = false.obs;
  var isInitialDataLoading = true.obs;
  var isDetailsDataLoading = true.obs;
  var isSaveContactLoading = true.obs;
  var packageBookingHttpService = ActivityBookingHttpService();

  var selectedDestination = "".obs;
  var selectedActivity = "".obs;
  var activities = <ActivityData>[].obs;
  var destinations = <Country>[].obs;
  var cities = <ActivityCity>[].obs;
  var packageDetails = getDefaultActivityDetails().obs;
  var pageId = 1.obs;
  var packageId = 1.obs;
  var cityId = 1.obs;
  var objectID = 1.obs;
  var countryisocode = "ALL".obs;
  var bookingRef = "".obs;
  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;

  var tourCategoryDcs = <SortingDcs>[].obs;
  var selectedTourCategoryDcs = <SortingDcs>[].obs;
  var bestDealsDcs = <SortingDcs>[].obs;
  var selectedBestDealsDcs = <SortingDcs>[].obs;
  var sortingDcs = <SortingDcs>[].obs;
  var selectedSortingDcs = <SortingDcs>[].obs;
  var priceDcs = <RangeDcs>[].obs;
  var selectedPriceDcs = <RangeDcs>[].obs;
  var sortingDc = SortingDcs(value: "-1", name: "", isDefault: false).obs;

  @override
  void onInit() {
    super.onInit();
    getInitialInfo();
  }

  Future<void> getInitialInfo() async {
    getCities(1,"ALL");
  }

  Future<void> getCities(int newPageId, String newCountryisocode) async {
    isInitialDataLoading.value = true;

    pageId.value = newPageId;
    countryisocode.value = newCountryisocode;

    DestinationResponse destinationResponse = await packageBookingHttpService.getDestinations(newPageId,newCountryisocode);

    if (destinationResponse != null) {
      cities.value = destinationResponse.cities;
      if(newCountryisocode == "ALL"){
        destinations.value = destinationResponse.destinations;
      }
    }
    isInitialDataLoading.value = false;
  }

  Future<void> getActivities(int cityID ) async {

    isInitialDataLoading.value = true;

    cityId.value = cityID;

    ActivityResponse activityResponse = await packageBookingHttpService.getActivities(cityID);

    activities.value = activityResponse.activities;
    sortingDcs.value = activityResponse.sortingDcs;
    objectID.value = activityResponse.objectID;
    priceDcs.value = activityResponse.priceDcs;
    tourCategoryDcs.value = activityResponse.tourCategoryDcs;
    bestDealsDcs.value = activityResponse.bestDealsDcs;

    if (sortingDcs.isNotEmpty) {
      List<SortingDcs> defaultSort =
      sortingDcs.where((p0) => p0.isDefault).toList();
      sortingDc.value =
      defaultSort.isNotEmpty ? defaultSort[0] : sortingDcs[0];
    }
      isInitialDataLoading.value = false;

  }

  Future<void> getActivityDetails(int refId) async {

    isDetailsDataLoading.value = true;
    packageId.value = refId;
    ActivityDetails? tempActivityDetails = await packageBookingHttpService.getActivityDetails(refId);
    if (tempActivityDetails != null) {
      packageDetails.value = tempActivityDetails;
    }
    isDetailsDataLoading.value = false;

  }

  Future<void> setTravellerData() async {
      isSaveContactLoading.value = true;
      String tempBookingRef = "";
      ActivitySubmissionData packageSubmissionData = ActivitySubmissionData(
          packageID: packageId.value,
          mobileCntry: mobileCntry.value,
          mobileNumber: mobileNumber.value,
          email: email.value);
      tempBookingRef =
      await packageBookingHttpService.setUserData(packageSubmissionData);
      isSaveContactLoading.value = false;
      if (tempBookingRef != "") {
        bookingRef.value = tempBookingRef;
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }

  }

  void saveContactInfo(String tMobileCntry, String tMobileNumber, String tEmail) {
    mobileCntry.value =tMobileCntry;
    mobileNumber.value =tMobileNumber;
    email.value =tEmail;
    setTravellerData();
  }

  void resetAndNavigateToHome() {

    isActivitysLoading.value = false;
    isInitialDataLoading.value = true;
    isDetailsDataLoading.value = true;
    isSaveContactLoading.value = true;

    selectedDestination.value = "";
    selectedActivity.value = "";
    activities.value = <ActivityData>[];
    destinations.value = <Country>[];
    packageDetails.value = getDefaultActivityDetails();
    pageId.value = 1;
    packageId.value = 1;
    countryisocode.value = "ALL";
    bookingRef.value = "";
    mobileCntry.value = "";
    mobileNumber.value = "";
    email.value = "";

     Get.offAllNamed(Approute_landingpage);
  }

}
