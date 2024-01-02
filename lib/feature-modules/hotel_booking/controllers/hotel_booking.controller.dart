import 'dart:convert';
import 'dart:developer';

import 'package:flytern/feature-modules/hotel_booking/models/destination.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/filter_body.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/pretraveller_data.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room_option.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room_option_cancel_policy.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room_option_supplement.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_data.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_item_room_data.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_result.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/traveller_data.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/traveller_info.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/services/helper.hotel_booking.service.dart';
import 'package:flytern/feature-modules/hotel_booking/services/http.hotel_booking.service.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'data_setter.hotel_booking.controller.dart';

part 'data_getter.hotel_booking.controller.dart';

class HotelBookingController extends GetxController {
  var isTravelStoriesLoading = false.obs;
  var isRecommendedLoading = false.obs;
  var isPopularDestinationsLoading = false.obs;
  var travelStoriesPage = 1.obs;
  var popularDestinationsPage = 1.obs;
  var recommendedPage = 1.obs;

  var isModifySearchVisible = false.obs;
  var isHotelDestinationsLoading = false.obs;
  var isHotelPretravellerDataLoading = false.obs;
  var isHotelTravellerDataSaveLoading = false.obs;
  var isHotelSearchResponsesLoading = false.obs;
  var isSmartPaymentCheckLoading = false.obs;

  var isHotelGatewayStatusCheckLoading = false.obs;
  var isHotelConfirmationDataLoading = false.obs;
  var isHotelSavePaymentGatewayLoading = false.obs;
  var isHotelMoreOptionsResponsesLoading = false.obs;
  var isHotelDetailsLoading = false.obs;
  var isHotelSearchFilterResponsesLoading = false.obs;
  var isHotelSearchPageResponsesLoading = false.obs;

  var isInitialDataLoading = true.obs;
  var hotelBookingHttpService = HotelBookingHttpService();
  var hotelBookingHelperServices = HotelBookingHelperServices();

  var quickSearch = <HotelSearchData>[].obs;
  var hotelDestinations = <HotelDestination>[].obs;
  var hotelSearchItems = <HotelSearchItemRoomData>[].obs;
  var hotelSearchResponses = <HotelSearchResponse>[].obs;
  var moreOptionHotels = <HotelSearchResponse>[].obs;
  var paymentGateways = <PaymentGateway>[].obs;
  var selectedPaymentGateway = mapPaymentGateway({}).obs;

  var sortingDc = SortingDcs(value: "-1", name: "", isDefault: false).obs;

  var selectedDestination = mapHotelDestination({
    "cityName": "select_destination".tr,
    "uniqueCombination": "select_destination".tr,
  }).obs;
  var destination = "".obs;
  var bookingRef = "".obs;
  var paymentRef = "".obs;
  var priceUnit = "KWD".obs;
  var selectedRoomSelectionIndex = 0.obs;
  var hotelId = (-1).obs;
  var objectId = (-1).obs;
  var totalHotels = (0).obs;
  var alertMsg = "".obs;
  var searchResultsPage = 1.obs;
  var isSearchScrollOver = false.obs;

  var gatewayUrl = "".obs;
  var confirmationUrl = "".obs;
  var confirmationMessage = "".obs;
  var pdfLink = "".obs;
  var isIssued = false.obs;
  var bookingInfo = <BookingInfo>[].obs;
  var paymentInfo = <BookingInfo>[].obs;
  var travelInfo = <HotelTravelInfo>[].obs;

  var alert = <String>[].obs;
  var selectedImageIndex = (-1).obs;
  var selectedRoomImageIndex = (-1).obs;

  var sortingDcs = <SortingDcs>[].obs;
  var ratingDcs = <SortingDcs>[].obs;
  var selectedratingDcs = <SortingDcs>[].obs;
  var locationDcs = <SortingDcs>[].obs;
  var selectedlocationDcs = <SortingDcs>[].obs;
  var priceDcs = <RangeDcs>[].obs;
  var selectedPriceDcs = <RangeDcs>[].obs;
  var selectedTravelInfo = <HotelTravelInfo>[].obs;
  var hotelSearchData = getDefaultHotelSearchData().obs;
  var startDate = DefaultInvalidDate.obs;
  var hotelDetails = getDefaultHotelDetails().obs;
  var selectedRoom = <HotelRoom>[].obs;
  var selectedRoomOption = <HotelRoomOption>[].obs;
  var hotelPretravellerData = mapHotelPretravellerData({}).obs;
  var nationality = Country(
      isDefault: 1,
      countryName: ("select_nationality".tr),
      countryCode: "",
      countryISOCode: "",
      countryName_Ar: "",
      flag: "",
      code: "")
      .obs;

  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;
  bool isInitial = true;

  @override
  void onInit() {
    super.onInit();
    getRecentSearch();
  }

  Future<void> getRecentSearch() async {
    isInitialDataLoading.value = true;

    quickSearch.value = await hotelBookingHttpService.getRecentSearch();

    if (isInitial) {
      resetDestinationAndNationality();
    }

    isInitialDataLoading.value = false;
  }

  Future<List<HotelDestination>> getHotelDestinations(
      String searchQuery) async {
    if (searchQuery != "") {
      isHotelDestinationsLoading.value = true;
      hotelDestinations.value =
      await hotelBookingHttpService.getHotelDestinations(searchQuery);
      isHotelDestinationsLoading.value = false;
      return hotelDestinations.value;
    } else {
      isHotelDestinationsLoading.value = false;
      return [];
    }
  }

  resetDestinationAndNationality() async {
    selectedDestination.value = mapHotelDestination({
      "cityName": "select_destination".tr,
      "uniqueCombination": "select_destination".tr,
    });

    var sharedPreferences = await SharedPreferences.getInstance();
    String? hotelnationalityString = sharedPreferences.getString(
        "hotelnationality");

    if (hotelnationalityString != null && hotelnationalityString != "") {
      // log("resetDestinationAndNationality");
      // log(hotelnationalityString);
      final sharedController = Get.find<SharedController>();

      List<Country> countries = sharedController.countries.value.where((element) => element.code == hotelnationalityString).toList();
      if(countries.isNotEmpty){
        nationality.value = countries[0];
      }else{
        nationality.value = Country(
            isDefault: 1,
            countryName: ("select_nationality".tr),
            countryCode: "",
            countryISOCode: "",
            countryName_Ar: "",
            flag: "",
            code: "");
      }


    }else{
      nationality.value = Country(
          isDefault: 1,
          countryName: ("select_nationality".tr),
          countryCode: "",
          countryISOCode: "",
          countryName_Ar: "",
          flag: "",
          code: "");
    }
  }

  Future<void> getSearchResults(bool isNavigationRequired) async {
    if (hotelSearchData.value.rooms.isNotEmpty &&
        hotelSearchData.value.destination != "" &&
        !isHotelSearchResponsesLoading.value) {
      objectId.value = -1;
      totalHotels.value = 0;
      isHotelSearchResponsesLoading.value = true;
      if (isNavigationRequired) {
        Get.toNamed(Approute_hotelsSearchResult);
      } else {
        isModifySearchVisible.value = false;
      }
      isSearchScrollOver.value = false;
      searchResultsPage.value = 1;
      HotelSearchResult hotelSearchResult = await hotelBookingHttpService
          .getHotelSearchResults(hotelSearchData.value);
      hotelSearchResponses.value = hotelSearchResult.searchResponses;

      totalHotels.value = hotelSearchResult.totalHotels;
      objectId.value = hotelSearchResult.objectID;
      alertMsg.value = hotelSearchResult.alertMsg;
      if (hotelSearchResponses.isNotEmpty) {
        hotelId.value = hotelSearchResponses.value[0].hotelId;
        priceUnit.value = hotelSearchResponses.value[0].priceUnit;
        if (isNavigationRequired) {
          startDate.value = hotelSearchData.value.checkInDate;
        }
      }
      sortingDcs.value = hotelSearchResult.sortingDcs;
      if (sortingDcs.isNotEmpty) {
        List<SortingDcs> defaultSort =
        sortingDcs.where((p0) => p0.isDefault).toList();
        sortingDc.value =
        defaultSort.isNotEmpty ? defaultSort[0] : sortingDcs[0];
      }
      priceDcs.value = hotelSearchResult.priceDcs;
      ratingDcs.value = hotelSearchResult.ratingDcs;
      locationDcs.value = hotelSearchResult.locationDcs;

      isHotelSearchResponsesLoading.value = false;
      isHotelSearchFilterResponsesLoading.value = false;
    }
    getRecentSearch();
  }

  Future<void> getQuickSearchResult(HotelSearchData tHotelSearchData) async {
    if (tHotelSearchData.rooms.isNotEmpty &&
        tHotelSearchData.destination != "" &&
        !isHotelSearchResponsesLoading.value) {
      objectId.value = -1;
      isHotelSearchResponsesLoading.value = true;
      Get.toNamed(Approute_hotelsSearchResult);
      isSearchScrollOver.value = false;
      searchResultsPage.value = 1;
      HotelSearchResult hotelSearchResult =
      await hotelBookingHttpService.getHotelSearchResults(tHotelSearchData);
      hotelSearchResponses.value = hotelSearchResult.searchResponses;

      objectId.value = hotelSearchResult.objectID;
      alertMsg.value = hotelSearchResult.alertMsg;
      if (hotelSearchResponses.isNotEmpty) {
        hotelId.value = hotelSearchResponses.value[0].hotelId;
        priceUnit.value = hotelSearchResponses.value[0].priceUnit;
        startDate.value = hotelSearchData.value.checkInDate;
      }
      sortingDcs.value = hotelSearchResult.sortingDcs;
      if (sortingDcs.isNotEmpty) {
        List<SortingDcs> defaultSort =
        sortingDcs.where((p0) => p0.isDefault).toList();
        sortingDc.value =
        defaultSort.isNotEmpty ? defaultSort[0] : sortingDcs[0];
      }
      priceDcs.value = hotelSearchResult.priceDcs;
      ratingDcs.value = hotelSearchResult.ratingDcs;
      locationDcs.value = hotelSearchResult.locationDcs;

      isHotelSearchResponsesLoading.value = false;
      isHotelSearchFilterResponsesLoading.value = false;
    }
  }

  Future<void> filterSearchResults() async {
    if (!isHotelSearchFilterResponsesLoading.value) {
      isHotelSearchFilterResponsesLoading.value = true;
      isSearchScrollOver.value = false;
      searchResultsPage.value = 1;
      totalHotels.value = 0;
      HotelFilterBody hotelFilterBody = HotelFilterBody(
        pageId: 1,
        objectID: objectId.value,
        priceMinMaxDc: selectedPriceDcs.value.isNotEmpty
            ? "${selectedPriceDcs.value[0].min}, ${selectedPriceDcs.value[0]
            .max}"
            : "",
        locationDcs: selectedlocationDcs.value.isNotEmpty
            ? getFilterValues(selectedlocationDcs.value)
            : "",
        ratingDcs: selectedratingDcs.value.isNotEmpty
            ? getFilterValues(selectedratingDcs.value)
            : "",
        sortingDc: sortingDc.value.value,
      );

      HotelSearchResult hotelSearchResult = await hotelBookingHttpService
          .getHotelSearchResultsFiltered(hotelFilterBody);

      totalHotels.value = hotelSearchResult.totalHotels;
      alertMsg.value = hotelSearchResult.alertMsg;
      hotelSearchResponses.value = hotelSearchResult.searchResponses;
      isHotelSearchFilterResponsesLoading.value = false;
    }
  }

  Future<void> getHotelDetails(int tHotelid) async {
    if (tHotelid > -1 && !isHotelDetailsLoading.value) {
      try {
        selectedImageIndex.value = -1;
        selectedRoomImageIndex.value = -1;

        Get.toNamed(Approute_hotelsDetails);
        hotelId.value = tHotelid;
        isHotelDetailsLoading.value = true;
        selectedRoom.value = [];
        selectedRoomOption.value = [];
        selectedRoomSelectionIndex.value = 0;

        HotelDetails tempHotelDetails = await hotelBookingHttpService
            .getHotelDetails(hotelId.value, objectId.value);
        hotelDetails.value = tempHotelDetails;

        selectedImageIndex.value =
        hotelDetails.value.imageUrls.isNotEmpty ? 0 : -1;

        if (hotelDetails.value.rooms.isNotEmpty) {
          for (var i = 0; i < hotelSearchData.value.rooms.length; i++) {
            selectedRoom.value.add(hotelDetails.value.rooms[0]);
          }
          if (hotelDetails.value.rooms[0].roomOptions.isNotEmpty) {
            for (var i = 0; i < hotelSearchData.value.rooms.length; i++) {
              selectedRoomOption.value
                  .add(hotelDetails.value.rooms[0].roomOptions[0]);
            }
          }
        }

        isHotelDetailsLoading.value = false;

        getPreTravellerData();
      } catch (e) {
        Get.back();
        selectedImageIndex.value = -1;
        selectedRoomImageIndex.value = -1;
        hotelId.value = tHotelid;
        isHotelDetailsLoading.value = false;
        selectedRoom.value = [];
        selectedRoomOption.value = [];
        selectedRoomSelectionIndex.value = 0;
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }

  Future<void> getPreTravellerData() async {
    if (!isHotelPretravellerDataLoading.value) {
      isHotelPretravellerDataLoading.value = true;
      HotelPretravellerData tempHotelPretravellerData =
      await hotelBookingHttpService.getPreTravellerData(
          objectId.value, hotelId.value);
      isHotelPretravellerDataLoading.value = false;

      if (tempHotelPretravellerData.rooms.isNotEmpty) {
        hotelPretravellerData.value = tempHotelPretravellerData;
      }
    }
  }

  Future<void> setPreTravellerData(List<HotelTravelInfo> travelInfo) async {
    if (!isHotelTravellerDataSaveLoading.value) {
      isHotelTravellerDataSaveLoading.value = true;
      selectedTravelInfo.value = travelInfo;
      String tempBookingRef = "";
      HotelTravellerData hotelTravellerData = HotelTravellerData(
          travellerinfo: travelInfo,
          bookingCode:
          selectedRoomOption[selectedRoomSelectionIndex.value].bookingCode,
          hotelID: hotelId.value,
          objectID: objectId.value,
          mobileCntry: mobileCntry.value,
          mobileNumber: mobileNumber.value,
          email: email.value);
      tempBookingRef =
      await hotelBookingHttpService.setTravellerData(hotelTravellerData);
      isHotelTravellerDataSaveLoading.value = false;
      if (tempBookingRef != "") {
        bookingRef.value = tempBookingRef;
        getPaymentGateways(false, bookingRef.value);
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }

  Future<void> getPaymentGateways(bool isSmartpayment,
      String tempBookingRef) async {
    if (isSmartpayment) {
      bookingRef.value = tempBookingRef;
    }
    isHotelTravellerDataSaveLoading.value = true;
    paymentGateways.value = [];
    alert.value = [];
    alert.value = [];
    GetGatewayData getGatewayData =
    await hotelBookingHttpService.getPaymentGateways(bookingRef.value);

    paymentGateways.value = getGatewayData.paymentGateways;
    bookingInfo.value = getGatewayData.bookingInfo;
    alert.value = getGatewayData.alert;

    hotelDetails.value = getGatewayData.hotelDetails;
    selectedRoom.value = hotelDetails.value.rooms;
    selectedRoomOption.value = hotelDetails.value.rooms.isNotEmpty
        ? hotelDetails.value.rooms[0].roomOptions
        : [];
    selectedRoomSelectionIndex.value =
    hotelDetails.value.rooms.isNotEmpty ? 0 : -1;

    if (getGatewayData.paymentGateways.isNotEmpty) {
      updateProcessId(getGatewayData.paymentGateways[0].processID);
    }
    Get.toNamed(Approute_hotelsSummary);
    isSmartPaymentCheckLoading.value = false;

    isHotelTravellerDataSaveLoading.value = false;
  }

  Future<void> setPaymentGateway() async {
    isHotelSavePaymentGatewayLoading.value = true;

    PaymentGatewayUrlData paymentGatewayUrlData =
    await hotelBookingHttpService.setPaymentGateway(
        selectedPaymentGateway.value.processID,
        selectedPaymentGateway.value.paymentCode,
        bookingRef.value);

    gatewayUrl.value = paymentGatewayUrlData.gatewayUrl;
    confirmationUrl.value = paymentGatewayUrlData.confirmationUrl;
    paymentRef.value = paymentGatewayUrlData.paymentRef;

    if (gatewayUrl.value != "") {
      Get.toNamed(Approute_paymentPage, arguments: [
        gatewayUrl.value,
        confirmationUrl.value,
        Approute_hotelsSummary
      ])?.then((value) {
        checkGatewayStatus();
      });

      // checkGatewayStatus();
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isHotelSavePaymentGatewayLoading.value = false;
  }

  Future<void> checkGatewayStatus() async {
    isHotelGatewayStatusCheckLoading.value = true;
    bool isSuccess =
    await hotelBookingHttpService.checkGatewayStatus(paymentRef.value);

    if (isSuccess) {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      getConfirmationData(bookingRef.value, false);
    } else {
      getPaymentGateways(false, bookingRef.value);
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    }

    isHotelGatewayStatusCheckLoading.value = false;
  }

  Future<void> getConfirmationData(String bookingRef,
      bool isBookingFinder) async {
    isHotelConfirmationDataLoading.value = true;
    bookingInfo.value = [];
    paymentInfo.value = [];
    alert.value = [];
    pdfLink.value = "";
    isIssued.value = false;
    PaymentConfirmationData paymentConfirmationData =
    await hotelBookingHttpService.getConfirmationData(bookingRef);

    if (paymentConfirmationData.isSuccess) {
      pdfLink.value = paymentConfirmationData.pdfLink;
      isIssued.value = paymentConfirmationData.isIssued;
      paymentInfo.value = paymentConfirmationData.paymentInfo;
      bookingInfo.value = paymentConfirmationData.bookingInfo;
      alert.value = paymentConfirmationData.alertMsg;
      hotelDetails.value = paymentConfirmationData.hotelDetails;
      // confirmationMessage.value = paymentConfirmationData.alertMsg;
      selectedRoom.value = hotelDetails.value.rooms;
      selectedRoomOption.value = hotelDetails.value.rooms.isNotEmpty
          ? hotelDetails.value.rooms[0].roomOptions
          : [];
      selectedRoomSelectionIndex.value =
      hotelDetails.value.rooms.isNotEmpty ? 0 : -1;

      if (isBookingFinder) {
        Get.toNamed(Approute_hotelsConfirmation, arguments: [
          {"mode": "edit"}
        ]);
      } else {
        showSnackbar(Get.context!, "hotel_booking_success".tr, "info");
        int iter = 0;
        Get.offNamedUntil(Approute_hotelsConfirmation, arguments: [
          {"mode": "view"}
        ], (route) {
          return ++iter == 4;
        });
      }
    } else {
      if (!isBookingFinder) {
        showSnackbar(Get.context!, "booking_failed".tr, "error");

        int iter = 0;
        Get.offNamedUntil(Approute_hotelsSummary, (route) {
          return ++iter == 1;
        });
      }

      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isHotelConfirmationDataLoading.value = false;
  }

  void updateProcessId(String? value) {
    if (value != null) {
      List<PaymentGateway> tempPaymentGateways = paymentGateways.value
          .where((element) => element.processID == value)
          .toList();

      if (tempPaymentGateways.isNotEmpty) {
        selectedPaymentGateway.value = tempPaymentGateways[0];
      }
    }
  }

  void resetAndNavigateToHome() {
    isModifySearchVisible.value = false;
    isHotelDestinationsLoading.value = false;
    isHotelPretravellerDataLoading.value = false;
    isHotelTravellerDataSaveLoading.value = false;
    isHotelSearchResponsesLoading.value = false;

    isHotelGatewayStatusCheckLoading.value = false;
    isHotelConfirmationDataLoading.value = false;
    isHotelSavePaymentGatewayLoading.value = false;
    isHotelMoreOptionsResponsesLoading.value = false;
    isHotelDetailsLoading.value = false;
    isHotelSearchFilterResponsesLoading.value = false;
    isInitialDataLoading.value = false;

    hotelDestinations.value = [];
    hotelSearchItems.value = [];
    hotelSearchResponses.value = [];

    sortingDc.value = SortingDcs(value: "-1", name: "", isDefault: false);

    bookingRef.value = "";
    priceUnit.value = "KWD";

    hotelId.value = (-1);
    sortingDcs.value = [];
    ratingDcs.value = [];
    selectedratingDcs.value = [];
    locationDcs.value = [];
    selectedlocationDcs.value = [];
    priceDcs.value = [];
    selectedPriceDcs.value = [];
    selectedTravelInfo.value = [];
    hotelSearchData.value = getDefaultHotelSearchData();
    startDate.value = DefaultInvalidDate;
    hotelDetails.value = getDefaultHotelDetails();
    hotelPretravellerData.value = mapHotelPretravellerData({});

    Get.offAllNamed(Approute_landingpage);
  }

  void changeSelectedImage(int index) {
    selectedImageIndex.value = index;
  }

  void changeSelectedRoomImage(int index) {
    selectedRoomImageIndex.value = index;
  }

  Future<void> getHotelSearchResultsNextPage() async {
    if (!isHotelSearchPageResponsesLoading.value && !isSearchScrollOver.value) {
      isHotelSearchPageResponsesLoading.value = true;
      searchResultsPage.value = searchResultsPage.value + 1;

      HotelFilterBody hotelFilterBody = HotelFilterBody(
        pageId: searchResultsPage.value,
        objectID: objectId.value,
        priceMinMaxDc: selectedPriceDcs.value.isNotEmpty
            ? "${selectedPriceDcs.value[0].min}, ${selectedPriceDcs.value[0]
            .max}"
            : "",
        locationDcs: selectedlocationDcs.value.isNotEmpty
            ? getFilterValues(selectedlocationDcs.value)
            : "",
        ratingDcs: selectedratingDcs.value.isNotEmpty
            ? getFilterValues(selectedratingDcs.value)
            : "",
        sortingDc: sortingDc.value.value,
      );

      HotelSearchResult hotelSearchResult = await hotelBookingHttpService
          .getHotelSearchResultsFiltered(hotelFilterBody);

      alertMsg.value = hotelSearchResult.alertMsg;
      List<HotelSearchResponse> tHotelSearchResponse = [];

      for (var element in hotelSearchResponses.value) {
        tHotelSearchResponse.add(element);
      }

      if (hotelSearchResult.searchResponses.isEmpty) {
        isSearchScrollOver.value = true;
      }

      for (var element in hotelSearchResult.searchResponses) {
        tHotelSearchResponse.add(element);
      }

      hotelSearchResponses.value = tHotelSearchResponse;

      isHotelSearchPageResponsesLoading.value = false;
    }
  }

  void updateTravellerInfo(List<HotelTravelInfo> tempTravelInfo) {
    travelInfo.value = tempTravelInfo;
  }

  void addTravellerInfo(HotelTravelInfo tTravelInfo) {
    List<HotelTravelInfo> tempTravelInfo = travelInfo.value;
    tempTravelInfo.add(tTravelInfo);
    travelInfo.value = tempTravelInfo;
  }
}
