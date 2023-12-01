import 'dart:ffi';

import 'package:flytern/feature-modules/activity_booking/models/city.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/data.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/details_response.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/filter_body.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/option.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/price_fetch_body.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/response.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/submission_data.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/timing_option.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/transfer_type.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/traveller_info.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/destination_response.dart';
import 'package:flytern/feature-modules/activity_booking/services/http.activity_booking.service.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';

class ActivityBookingController extends GetxController {
  var isActivitiesLoading = false.obs;
  var isInitialDataLoading = true.obs;
  var isDetailsDataLoading = true.obs;
  var isPriceDataLoading = true.obs;
  var isSaveContactLoading = false.obs;
  var activityBookingHttpService = ActivityBookingHttpService();
  var isSmartPaymentCheckLoading = false.obs;
  var selectedImageIndex = (-1).obs;
  var currency = "KWD".obs;
  var selectedDestination = "".obs;
  var selectedActivity = "".obs;
  var activities = <ActivityData>[].obs;
  var destinations = <Country>[].obs;
  var cities = <ActivityCity>[].obs;
  var activityDetails = getDefaultActivityDetails().obs;
  var selectedActivityOption = mapActivityOption({}).obs;
  var selectedActivityTransferType = mapActivityTransferType({}).obs;
  var selectedActivityTime = mapActivityTimingOption({}).obs;
  var activityOptions = <ActivityOption>[].obs;
  var activityTransferTypes = <ActivityTransferType>[].obs;
  var activityTimingOptions = <ActivityTimingOption>[].obs;

  var pageId = 1.obs;
  var activityId = 1.obs;
  var cityId = "-1".obs;
  var objectID = 1.obs;
  var countryisocode = "ALL".obs;
  var bookingRef = "".obs;
  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;

  var transferId = (-1).obs;
  var tourid = (-1).obs;
  var cityid = (-1).obs;
  var touroptionid = (-1).obs;
  var contractId = (-1).obs;
  var noOfAdult = 0.obs;
  var noOfChildren = 0.obs;
  var noOfInfant = 0.obs;
  var travelDate = DefaultInvalidDate.obs;

  var tourCategoryDcs = <SortingDcs>[].obs;
  var selectedTourCategoryDcs = <SortingDcs>[].obs;
  var bestDealsDcs = <SortingDcs>[].obs;
  var selectedBestDealsDcs = <SortingDcs>[].obs;
  var sortingDcs = <SortingDcs>[].obs;
  var selectedSortingDcs = <SortingDcs>[].obs;
  var priceDcs = <RangeDcs>[].obs;
  var selectedPriceDcs = <RangeDcs>[].obs;
  var sortingDc = SortingDcs(value: "-1", name: "", isDefault: false).obs;
  var paymentGateways = <PaymentGateway>[].obs;
  var selectedGateway = mapPaymentGateway({}).obs;


  var gatewayUrl = "".obs;
  var confirmationUrl = "".obs;
  var confirmationMessage = "".obs;
  var pdfLink = "".obs;
  var isIssued = false.obs;
  var bookingInfo = <BookingInfo>[].obs;
  var paymentInfo = <BookingInfo>[].obs;
  var alert = <String>[].obs;

  var isActivityGatewayStatusCheckLoading = false.obs;
  var isActivityConfirmationDataLoading = false.obs;
  var isActivitySavePaymentGatewayLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getInitialInfo();
  }

  Future<void> getInitialInfo() async {
    getCities(1, "ALL");
  }

  Future<void> getCities(int newPageId, String newCountryisocode) async {
    isInitialDataLoading.value = true;

    pageId.value = newPageId;
    countryisocode.value = newCountryisocode;

    DestinationResponse destinationResponse = await activityBookingHttpService
        .getDestinations(newPageId, newCountryisocode);

    if (destinationResponse != null) {
      cities.value = destinationResponse.cities;
      if (newCountryisocode == "ALL") {
        destinations.value = destinationResponse.destinations;
      }
    }
    isInitialDataLoading.value = false;
  }

  Future<void> getActivities(String cityID, bool isRedirection) async {
    isActivitiesLoading.value = true;
    if (isRedirection) {
      Get.toNamed(Approute_activitiesList);
    }
    cityId.value = cityID;
    ActivityResponse activityResponse =
        await activityBookingHttpService.getActivities(cityID);

    activities.value = activityResponse.activities;
    if (activities.value.isNotEmpty) {
      currency.value = activities[0].currency;
    }
    sortingDcs.value = activityResponse.sortingDcs;
    objectID.value = activityResponse.objectID;
    priceDcs.value = activityResponse.priceDcs;
    tourCategoryDcs.value = activityResponse.tourCategoryDcs;
    bestDealsDcs.value = activityResponse.bestDealsDcs;

    selectedPriceDcs.value = [];
    selectedTourCategoryDcs.value = [];
    selectedBestDealsDcs.value = [];

    if (sortingDcs.isNotEmpty) {
      List<SortingDcs> defaultSort =
          sortingDcs.where((p0) => p0.isDefault).toList();
      sortingDc.value = defaultSort.isNotEmpty ? defaultSort[0] : sortingDcs[0];
    }
    isActivitiesLoading.value = false;
  }

  void updateSort(String sortingDcValue) {
    List<SortingDcs> tempSortingDcs = sortingDcs.value
        .where((element) => element.value == sortingDcValue)
        .toList();
    if (tempSortingDcs.isNotEmpty) {
      sortingDc.value = tempSortingDcs[0];
      filterSearchResults();
    }
  }

  setFilterValues(ActivityResponse selectedFilterOptions) {
    selectedPriceDcs.value = selectedFilterOptions.priceDcs;
    selectedTourCategoryDcs.value = selectedFilterOptions.tourCategoryDcs;
    selectedBestDealsDcs.value = selectedFilterOptions.bestDealsDcs;

    filterSearchResults();
  }

  Future<void> filterSearchResults() async {
    if (!isActivitiesLoading.value) {
      isActivitiesLoading.value = true;

      ActivityFilterBody activityFilterBody = ActivityFilterBody(
        pageId: pageId.value,
        objectID: objectID.value,
        priceMinMaxDc: selectedPriceDcs.value.isNotEmpty
            ? "${selectedPriceDcs.value[0].min}, ${selectedPriceDcs.value[0].max}"
            : "",
        tourCategoryDc: selectedTourCategoryDcs.value.isNotEmpty
            ? getFilterValues(selectedTourCategoryDcs.value)
            : "",
        bestDealsDc: selectedBestDealsDcs.value.isNotEmpty
            ? getFilterValues(selectedBestDealsDcs.value)
            : "",
        sortingDc: sortingDc.value.value,
      );

      ActivityResponse activityResponse =
          await activityBookingHttpService.filterActivities(activityFilterBody);

      activities.value = activityResponse.activities;

      isActivitiesLoading.value = false;
    }
  }

  getFilterValues(List<SortingDcs> value) {
    String filterString = "";
    for (var i = 0; i < value.length; i++) {
      filterString += value[i].value;
      if (i != (value.length - 1)) {
        filterString += ",";
      }
    }
    return filterString;
  }

  Future<void> getActivityDetails(int tourId) async {
    isDetailsDataLoading.value = true;
    selectedImageIndex.value = -1;
    Get.toNamed(Approute_activitiesDetails);
    activityId.value = tourId;
    ActivityDetailsResponse activityDetailsResponse =
        await activityBookingHttpService.getActivityDetails(
            objectID.value, tourId);
    activityDetails.value = activityDetailsResponse.activityDetails;
    selectedImageIndex.value =
    activityDetails.value.subImages.isNotEmpty ? 0 : -1;

    activityOptions.value =
        activityDetailsResponse.activityOptions.toSet().toList();
    final ids = Set();
    List<ActivityTransferType> tActivityTransferTypes =
        activityDetailsResponse.activityTransferTypes;
    tActivityTransferTypes.retainWhere((x) => ids.add(x.transferId));
    activityTransferTypes.value = tActivityTransferTypes;

    getInitialPrice();
  }
  void changeSelectedImage(int index) {
    selectedImageIndex.value = index;
  }
  Future<void> setTravellerData(
      ActivityTravellerInfo activityTravellerInfo) async {
    isSaveContactLoading.value = true;
    String tempBookingRef = "";

    List<ActivityPriceFetchBody> eventlstInfo = [];
    eventlstInfo.add(ActivityPriceFetchBody(
        contractId: contractId.value,
        objectID: objectID.value,
        transferId: transferId.value,
        tourid: tourid.value,
        cityid: cityid.value,
        touroptionid: touroptionid.value,
        travelDate: travelDate.value,
        noOfAdult: noOfAdult.value.toString(),
        noOfChildren: noOfChildren.value.toString(),
        noOfInfant: noOfInfant.value.toString(),
        tourGuide: objectID.value.toString(),
        startTime: "",
        timeSlotId: selectedActivityTime.value.timeSlotId.toString()));

    ActivitySubmissionData activitySubmissionData = ActivitySubmissionData(
        leadInfo: activityTravellerInfo, eventlstInfo: eventlstInfo);

    tempBookingRef =
        await activityBookingHttpService.setUserData(activitySubmissionData);
    isSaveContactLoading.value = false;
    if (tempBookingRef != "") {
      bookingRef.value = tempBookingRef;
      getPaymentGateways(false, bookingRef.value);
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }
  }

  checkSmartPayment(String tempBookingRef) async {
    isSmartPaymentCheckLoading.value = true;

    bool isSuccess =
        await activityBookingHttpService.checkSmartPayment(tempBookingRef);

    if (isSuccess) {
      bookingRef.value = tempBookingRef;
      getPaymentGateways(true, tempBookingRef);
    } else {
      isSmartPaymentCheckLoading.value = false;
      showSnackbar(Get.context!, "couldnt_find_booking".tr, "error");
    }
  }

  Future<void> getPaymentGateways(
      bool isSmartpayment, String tempBookingRef) async {
    if (isSmartpayment) {
      bookingRef.value = tempBookingRef;
    }
    isSaveContactLoading.value = true;
    paymentGateways.value = [];
    alert.value = [];
    alert.value = [];
    bookingInfo.value = [];
    GetGatewayData getGatewayData =
        await activityBookingHttpService.getPaymentGateways(bookingRef.value);

    paymentGateways.value = getGatewayData.paymentGateways;
    bookingInfo.value = getGatewayData.bookingInfo;
    alert.value = getGatewayData.alert;
    if (isSmartpayment) {
      activityDetails.value = getGatewayData.activityDetails;
    }

    if (getGatewayData.paymentGateways.isNotEmpty) {
      updateProcessId(getGatewayData.paymentGateways[0].processID);
    }

    Get.toNamed(Approute_activitiesSummary);
    isSmartPaymentCheckLoading.value = false;
    isSaveContactLoading.value = false;
  }

  void updateProcessId(String? value) {
    if (value != null) {
      List<PaymentGateway> tempPaymentGateways = paymentGateways.value
          .where((element) => element.processID == value)
          .toList();

      if (tempPaymentGateways.isNotEmpty) {
        selectedGateway.value = tempPaymentGateways[0];

      }
    }
  }

  Future<void> setPaymentGateway() async {
    isActivitySavePaymentGatewayLoading.value = true;

    PaymentGatewayUrlData paymentGatewayUrlData =
        await activityBookingHttpService.setPaymentGateway(
            selectedGateway.value.processID, selectedGateway.value.paymentCode, bookingRef.value);

    print("paymentGatewayUrlData");
    print(paymentGatewayUrlData.isOkRedirection);

    gatewayUrl.value = paymentGatewayUrlData.gatewayUrl;
    confirmationUrl.value = paymentGatewayUrlData.confirmationUrl;

    if (gatewayUrl.value != "") {
      // Get.toNamed(Approute_paymentPage,
      //         arguments: [gatewayUrl.value, confirmationUrl.value])
      //     ?.then((value) {
      //       if(value){
      //         checkGatewayStatus();
      //       }else{
      //         Get.offAllNamed(Approute_activitiesSummary,
      //             predicate: (route) => Get.currentRoute == Approute_userDetailsSubmission);
      //         showSnackbar(Get.context!, "payment_capture_error".tr,"error");
      //       }
      //
      // });

      checkGatewayStatus();
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isActivitySavePaymentGatewayLoading.value = false;
  }

  Future<void> checkGatewayStatus() async {
    isActivityGatewayStatusCheckLoading.value = true;
    bool isSuccess =
        await activityBookingHttpService.checkGatewayStatus(bookingRef.value);

    print("checkGatewayStatus isSuccess");
    print(isSuccess);

    if (isSuccess) {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      getConfirmationData(bookingRef.value,false);
    } else {
      int iter = 0;
      Get.offNamedUntil(Approute_activitiesSummary, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter == 1;
      });
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    }

    isActivityGatewayStatusCheckLoading.value = false;
  }

  Future<void> getConfirmationData(String bookingRef,bool isBookingFinder) async {
    isActivityConfirmationDataLoading.value = true;

    PaymentConfirmationData paymentConfirmationData =
        await activityBookingHttpService.getConfirmationData(bookingRef);

    if (paymentConfirmationData.isSuccess) {

      pdfLink.value = paymentConfirmationData.pdfLink;
      isIssued.value = paymentConfirmationData.isIssued;
      bookingInfo.value = paymentConfirmationData.bookingInfo;
      paymentInfo.value = paymentConfirmationData.paymentInfo;
      alert.value = paymentConfirmationData.alertMsg;
      activityDetails.value = paymentConfirmationData.activityDetails;
      // confirmationMessage.value = paymentConfirmationData.alertMsg;

      if(isBookingFinder){
        Get.toNamed(Approute_activitiesConfirmation, arguments: [
          {"mode": "edit"}
        ]);
      }else{
        showSnackbar(Get.context!, "activity_booking_success".tr, "info");

        int iter = 0;
        Get.offNamedUntil(Approute_activitiesConfirmation, arguments: [
          {"mode": "view"}
        ], (route) {
          print("Get.currentRoute");
          print(Get.currentRoute);
          return ++iter == 4;
        });
      }


    } else {


      if(!isBookingFinder){
        showSnackbar(Get.context!, "booking_failed".tr, "error");

        int iter = 0;
        Get.offNamedUntil(Approute_activitiesSummary, (route) {
          print("Get.currentRoute");
          print(Get.currentRoute);
          return ++iter == 1;
        });
      }
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isActivityConfirmationDataLoading.value = false;
  }

  void resetAndNavigateToHome() {
    isActivitiesLoading.value = false;
    isInitialDataLoading.value = true;
    isDetailsDataLoading.value = true;
    isSaveContactLoading.value = true;

    selectedDestination.value = "";
    selectedActivity.value = "";
    activities.value = <ActivityData>[];
    destinations.value = <Country>[];
    activityDetails.value = getDefaultActivityDetails();
    pageId.value = 1;
    activityId.value = 1;
    countryisocode.value = "ALL";
    bookingRef.value = "";
    mobileCntry.value = "";
    mobileNumber.value = "";
    email.value = "";
    Get.offAllNamed(Approute_landingpage);
  }

  void changeSelectedActivityOption(ActivityOption selectedItem) {
    selectedActivityOption.value = selectedItem;
    getActivityPriceInfo();
  }

  void changeSelectedActivityTransferType(
      ActivityTransferType tSelectedActivityTransferType) {
    selectedActivityTransferType.value = tSelectedActivityTransferType;
    if (selectedActivityTransferType.value.isSlot) {
      getActivityTimingList();
    } else {
      getActivityPriceInfo();
    }
  }

  void updatePassengerCount(
      int tAdultCount, int tChildCount, int tInfantCount) {
    noOfAdult.value = tAdultCount;
    noOfChildren.value = tChildCount;
    noOfInfant.value = tInfantCount;
    getActivityPriceInfo();
  }

  void changeTravelDate(DateTime dateTime) {
    travelDate.value = dateTime;
    getActivityPriceInfo();
  }

  void getInitialPrice() {
    if (activityOptions.isNotEmpty && activityTransferTypes.isNotEmpty) {
      selectedActivityTransferType.value = activityTransferTypes[0];
      selectedActivityOption.value = activityOptions.value[0];
      transferId.value =
          int.parse(activityTransferTypes.value[0].transferId.toString());
      tourid.value = int.parse(activityOptions.value[0].tourId.toString());
      cityid.value = int.parse(activityOptions.value[0].cityId.toString());
      contractId.value =
          int.parse(activityTransferTypes.value[0].contractId.toString());
      touroptionid.value =
          int.parse(activityOptions.value[0].tourOptionId.toString());

      noOfAdult.value = 1;
      noOfChildren.value = 0;
      noOfInfant.value = 0;
      travelDate.value = DateTime.now().add(Duration(days: 1));
      getActivityPriceInfo();
      getActivityTimingList();
    }
  }

  Future<void> getActivityPriceInfo() async {
    isPriceDataLoading.value = true;

    ActivityTransferType activityTransferType = await activityBookingHttpService
        .getActivityPriceInfo(ActivityPriceFetchBody(
            transferId: transferId.value,
            tourid: tourid.value,
            cityid: cityid.value,
            touroptionid: touroptionid.value,
            travelDate: travelDate.value,
            noOfAdult: noOfAdult.value.toString(),
            noOfChildren: noOfChildren.value.toString(),
            noOfInfant: noOfInfant.value.toString(),
            contractId: -1,
            objectID: objectID.value,
            tourGuide: '0',
            startTime: '0',
            timeSlotId: ''));

    print("transferId before update");
    print(selectedActivityTransferType.value.transferId);
    activityTransferTypes.value.forEach((element) {
      print("element.transferId i");
      print(element.transferId);
    });
    selectedActivityTransferType.value = activityTransferType;
    print("transferId after update");
    print(selectedActivityTransferType.value.transferId);
    isDetailsDataLoading.value = false;
    isPriceDataLoading.value = false;
    confirmActivity();
  }

  Future<void> getActivityTimingList() async {
    isPriceDataLoading.value = true;

    activityTimingOptions.value = await activityBookingHttpService
        .getActivityTimingList(ActivityPriceFetchBody(
            transferId: transferId.value,
            tourid: tourid.value,
            cityid: cityid.value,
            touroptionid: touroptionid.value,
            travelDate: travelDate.value,
            noOfAdult: noOfAdult.value.toString(),
            noOfChildren: noOfChildren.value.toString(),
            noOfInfant: noOfInfant.value.toString(),
            contractId: contractId.value,
            objectID: objectID.value,
            tourGuide: '0',
            startTime: '0',
            timeSlotId: ''));

    if (activityTimingOptions.isNotEmpty) {
      selectedActivityTime.value = activityTimingOptions.value[0];
      getActivityPriceInfo();
    }
  }

  Future<void> confirmActivity() async {
    String msg = await activityBookingHttpService.confirmActivity(
        ActivityPriceFetchBody(
            transferId: transferId.value,
            tourid: tourid.value,
            cityid: cityid.value,
            touroptionid: touroptionid.value,
            travelDate: travelDate.value,
            noOfAdult: noOfAdult.value.toString(),
            noOfChildren: noOfChildren.value.toString(),
            noOfInfant: noOfInfant.value.toString(),
            contractId: contractId.value,
            objectID: objectID.value,
            tourGuide: '0',
            startTime: '0',
            timeSlotId: selectedActivityTime.value.timeSlotId.toString()));
  }

  void changeActivityTime(ActivityTimingOption activityTimingOption) {
    selectedActivityTime.value = activityTimingOption;
  }

}
