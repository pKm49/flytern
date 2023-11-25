import 'dart:ffi';

import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/extra_package/flight_addon_extra_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/extra_package/flight_addon_extra_package_selection.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/extra_package/flight_addon_set_extra_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/meal/flight_addon_get_meal.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/meal/flight_addon_meal_selection.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/meal/flight_addon_set_meal.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_flight_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/extra_package/flight_addon_get_extra_package.dart';
 import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_get_seat.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/meal/flight_addon_meal.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_passenger.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_route.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_seat_column.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_seat_selection.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_set_seat.dart';
 import 'package:flytern/feature-modules/flight_booking/data/models/booking_ref_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/cabin_info.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_details.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_filter_body.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_pretraveller_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_traveller_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/get_gateway_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/recommended_package.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/travel_story.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/traveller_info.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper-services/flight_booking_helper_services.dart';
import 'package:flytern/feature-modules/flight_booking/services/http-services/flight_booking_http_services.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';

part 'flight_booking_controller_setter.dart';
part 'flight_booking_controller_addons_handler.dart';

class FlightBookingController extends GetxController {


  var selectedRouteForSeat = "1".obs;
  var selectedPassengerForSeat = "1".obs;
  var selectedRouteForMeal = "1".obs;
  var selectedPassengerForMeal = "1".obs;
  var selectedRouteForExtraPackage = "1".obs;
  var selectedPassengerForExtraPackage = "1".obs;
  var flightAddonSetSeatData = getDummyFlightAddonSetSeat({}).obs;
  var flightAddonSetMealData = getDummyFlightAddonSetMeal({}).obs;
  var flightAddonSetExtraPackageData = getDummyFlightAddonSetExtraPackage({}).obs;

  var isGetSeatsLoading = false.obs;
  var isGetMealsLoading = false.obs;
  var isGetExtraLuggagesLoading = false.obs;
  var isSeatsSaved = false.obs;
  var isSeatsSaveLoading = false.obs;
  var isMealsSaved = false.obs;
  var isMealsSaveLoading = false.obs;
  var isExtraLuggagesSaved = false.obs;
  var isExtraLuggagesSaveLoading = false.obs;
  var addonRoutes = <FlightAddonRoute>[].obs;
  var addonPassengers = <FlightAddonPassenger>[].obs;
  var addonFlightClass = <FlightAddonFlightClass>[].obs;
  var addonMeals = <FlightAddonMeal>[].obs;
  var addonExtraPackages = <FlightAddonExtraPackage>[].obs;

  var isTravelStoriesLoading = false.obs;
  var isRecommendedLoading = false.obs;
  var isPopularDestinationsLoading = false.obs;
  var isPassengersSelected = false.obs;
  var travelStoriesPage = 1.obs;
  var popularDestinationsPage = 1.obs;
  var recommendedPage = 1.obs;

  var isModifySearchVisible = false.obs;
  var isFlightDestinationsLoading = false.obs;
  var isFlightPretravellerDataLoading = false.obs;
  var isFlightTravellerDataSaveLoading = false.obs;
  var isSmartPaymentCheckLoading = false.obs;
  var isFlightSearchResponsesLoading = false.obs;

  var isFlightGatewayStatusCheckLoading = false.obs;
  var isFlightConfirmationDataLoading = false.obs;
  var isFlightSavePaymentGatewayLoading = false.obs;
  var isFlightMoreOptionsResponsesLoading = false.obs;
  var isFlightDetailsLoading = false.obs;
  var isFlightSearchFilterResponsesLoading = false.obs;
  var isInitialDataLoading = true.obs;
  var flightBookingHttpService = FlightBookingHttpService();
  var flightBookingHelperServices = FlightBookingHelperServices();

  var cabinClasses = <CabinClass>[].obs;
  var quickSearch = <FlightSearchData>[].obs;
  var recommendedPackages = <RecommendedPackage>[].obs;
  var popularDestinations = <PopularDestination>[].obs;
  var travelStories = <TravelStory>[].obs;
  var flightDestinations = <FlightDestination>[].obs;
  var flightSearchItems = <FlightSearchItem>[].obs;
  var flightSearchResponses = <FlightSearchResponse>[].obs;
  var moreOptionFlights = <FlightSearchResponse>[].obs;
  var paymentGateways = <PaymentGateway>[].obs;

  var sortingDc = SortingDcs(value: "-1", name: "", isDefault: false).obs;

  var bookingRef = "".obs;
  var isSeatSelection = false.obs;
  var isMealSelection = false.obs;
  var isExtraBaggageSelection = false.obs;
  var currency = "KWD".obs;
  var pageId = 1.obs;
  var objectId = 1.obs;
  var detailId = 1.obs;
  var processId = "-1".obs;
  var paymentCode = "".obs;
  var gatewayUrl = "".obs;
  var confirmationUrl = "".obs;
  var confirmationMessage = "".obs;
  var pdfLink = "".obs;

  var seatTotalAmount = (0.0).obs;
  var mealTotalAmount = (0.0).obs;
  var baggageTotalAmount = (0.0).obs;
  var processingFee = (0.0).obs;

  var currentFlightIndex = (-1).obs;
  var sortingDcs = <SortingDcs>[].obs;
  var airlineDcs = <SortingDcs>[].obs;
  var selectedAirlineDcs = <SortingDcs>[].obs;
  var departureTimeDcs = <SortingDcs>[].obs;
  var selectedDepartureTimeDcs = <SortingDcs>[].obs;
  var arrivalTimeDcs = <SortingDcs>[].obs;
  var selectedArrivalTimeDcs = <SortingDcs>[].obs;
  var stopDcs = <SortingDcs>[].obs;
  var selectedStopDcs = <SortingDcs>[].obs;
  var priceDcs = <RangeDcs>[].obs;
  var selectedPriceDcs = <RangeDcs>[].obs;
  var selectedTravelInfo = <TravelInfo>[].obs;
  var flightSearchData = getDefaultFlightSearchData().obs;
  var startDate = DefaultInvalidDate.obs;
  var flightDetails = getDefaultFlightDetails().obs;
  var cabinInfo = mapCabinInfo({}).obs;
  var flightPretravellerData = mapFlightPretravellerData({}).obs;

  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;

  @override
  void onInit() {
    super.onInit();
    getInitialInfo();
  }

  Future<void> getInitialInfo() async {
    ExploreData? exploreData = await flightBookingHttpService.getInitialInfo();
    print("getInitialInfo completed");
    print(exploreData != null);
    if (exploreData != null) {
      cabinClasses.value = exploreData.cabinClasses;
      recommendedPackages.value = exploreData.recommendedPackages;
      popularDestinations.value = exploreData.popularDestinations;
      travelStories.value = exploreData.travelStories;
      quickSearch.value = exploreData.quickSearch;
      setDefaultSearchData();
    }

    isInitialDataLoading.value = false;
  }

  Future<List<FlightDestination>> getFlightDestinations(
      String searchQuery) async {
    if (searchQuery != "") {
      flightDestinations.value =
          await flightBookingHttpService.getFlightDestinations(searchQuery);
      isFlightDestinationsLoading.value = false;
      return flightDestinations.value;
    } else {
      return [];
    }
  }

  Future<void> getQuickSearchResult(FlightSearchData tFlightSearchData) async {
    print("getQuickSearchResult");
    print(tFlightSearchData.allowedCabins.length);
    print(tFlightSearchData.adults);
    if (tFlightSearchData.allowedCabins.isNotEmpty &&
        tFlightSearchData.adults > 0 &&
        !isFlightSearchResponsesLoading.value) {
      flightSearchData.value = tFlightSearchData;
      Get.toNamed(Approute_flightsSearchResult);

      print("getSearchResults called ");
      isFlightSearchResponsesLoading.value = true;
      FlightSearchResult flightSearchResult = await flightBookingHttpService
          .getFlightSearchResults(tFlightSearchData);
      flightSearchResponses.value = flightSearchResult.searchResponses;
      if (flightSearchResponses.isNotEmpty) {
        objectId.value = flightSearchResponses.value[0].objectId;
        currency.value = flightSearchResponses.value[0].currency;
        startDate.value = tFlightSearchData.searchList[0].departureDate;

      }
      sortingDcs.value = flightSearchResult.sortingDcs;
      if (sortingDcs.isNotEmpty) {
        List<SortingDcs> defaultSort =
        sortingDcs.where((p0) => p0.isDefault).toList();
        sortingDc.value =
        defaultSort.isNotEmpty ? defaultSort[0] : sortingDcs[0];
      }
      priceDcs.value = flightSearchResult.priceDcs;
      airlineDcs.value = flightSearchResult.airlineDcs;
      arrivalTimeDcs.value = flightSearchResult.arrivalTimeDcs;
      departureTimeDcs.value = flightSearchResult.departureTimeDcs;
      stopDcs.value = flightSearchResult.stopDcs;

      isFlightSearchResponsesLoading.value = false;
      isFlightSearchFilterResponsesLoading.value = false;
    } else {
      if (tFlightSearchData.allowedCabins.isEmpty ||
          tFlightSearchData.adults == 0) {
        showSnackbar(
            Get.context!, "select_passenger_cabin".tr, "error");
      }
    }
  }

  Future<void> getSearchResults(bool isNavigationRequired) async {
    if (flightSearchData.value.allowedCabins.isNotEmpty &&
        flightSearchData.value.adults > 0 &&
        !isFlightSearchResponsesLoading.value) {
      if (isNavigationRequired) {
        Get.toNamed(Approute_flightsSearchResult);
      } else {
        isModifySearchVisible.value = false;
      }
      print("getSearchResults called ");
      isFlightSearchResponsesLoading.value = true;
      FlightSearchResult flightSearchResult = await flightBookingHttpService
          .getFlightSearchResults(flightSearchData.value);
      flightSearchResponses.value = flightSearchResult.searchResponses;
      if (flightSearchResponses.isNotEmpty) {
        objectId.value = flightSearchResponses.value[0].objectId;
        currency.value = flightSearchResponses.value[0].currency;
        if (isNavigationRequired) {
          startDate.value = flightSearchData.value.searchList[0].departureDate;
        }
      }
      sortingDcs.value = flightSearchResult.sortingDcs;
      if (sortingDcs.isNotEmpty) {
        List<SortingDcs> defaultSort =
            sortingDcs.where((p0) => p0.isDefault).toList();
        sortingDc.value =
            defaultSort.isNotEmpty ? defaultSort[0] : sortingDcs[0];
      }
      priceDcs.value = flightSearchResult.priceDcs;
      airlineDcs.value = flightSearchResult.airlineDcs;
      arrivalTimeDcs.value = flightSearchResult.arrivalTimeDcs;
      departureTimeDcs.value = flightSearchResult.departureTimeDcs;
      stopDcs.value = flightSearchResult.stopDcs;

      isFlightSearchResponsesLoading.value = false;
      isFlightSearchFilterResponsesLoading.value = false;
    } else {
      if (flightSearchData.value.allowedCabins.isEmpty ||
          flightSearchData.value.adults == 0) {
        showSnackbar(
            Get.context!,"select_passenger_cabin".tr, "error");
      }
    }
  }

  Future<void> filterSearchResults() async {
    if (!isFlightSearchFilterResponsesLoading.value) {
      isFlightSearchFilterResponsesLoading.value = true;

      FlightFilterBody flightFilterBody = FlightFilterBody(
        pageId: pageId.value,
        objectID: objectId.value,
        priceMinMaxDc: selectedPriceDcs.value.isNotEmpty
            ? "${selectedPriceDcs.value[0].min}, ${selectedPriceDcs.value[0].max}"
            : "",
        arrivalTimeDc: selectedArrivalTimeDcs.value.isNotEmpty
            ? getFilterValues(selectedArrivalTimeDcs.value)
            : "",
        departureTimeDc: selectedDepartureTimeDcs.value.isNotEmpty
            ? getFilterValues(selectedDepartureTimeDcs.value)
            : "",
        airlineDc: selectedAirlineDcs.value.isNotEmpty
            ? getFilterValues(selectedAirlineDcs.value)
            : "",
        stopDc: selectedStopDcs.value.isNotEmpty
            ? getFilterValues(selectedStopDcs.value)
            : "",
        sortingDc: sortingDc.value.value,
      );

      List<FlightSearchResponse> flightSearchResponse =
          await flightBookingHttpService
              .getFlightSearchResultsFiltered(flightFilterBody);

      flightSearchResponses.value = flightSearchResponse;
      isFlightSearchFilterResponsesLoading.value = false;
    }
  }

  Future<void> getMoreOptions(int index) async {
    if (index > -1 && !isFlightMoreOptionsResponsesLoading.value) {
      Get.toNamed(Approute_flightsMoreOptions);

      print("getMoreOptions called ");
      isFlightMoreOptionsResponsesLoading.value = true;
      FlightSearchResult flightSearchResult =
          await flightBookingHttpService.getMoreOptions(index, objectId.value);
      moreOptionFlights.value = flightSearchResult.searchResponses;

      isFlightMoreOptionsResponsesLoading.value = false;
    }
  }

  Future<void> getFlightDetails(int index) async {
    if (index > -1 && !isFlightDetailsLoading.value) {
      currentFlightIndex.value = index;
      isFlightDetailsLoading.value = true;
      print("getMoreOptions called ");

      print(isFlightDetailsLoading.value && currentFlightIndex.value == index);
      FlightDetails tempFlightDetails = await flightBookingHttpService
          .getFlightDetails(index, objectId.value);
      flightDetails.value = tempFlightDetails;
      List<CabinInfo> selectedCabinInfo = flightDetails.value.cabinInfos
          .where((element) => element.id == flightDetails.value.selectedCabinId)
          .toList();
      if (selectedCabinInfo.isNotEmpty) {
        print("selectedCabinInfo.isNotEmpty");
        cabinInfo.value = selectedCabinInfo[0];
      }
      isFlightDetailsLoading.value = false;
      Get.toNamed(Approute_flightsDetails);
      if (flightDetails.value.priceChanged) {
        showSnackbar(
            Get.context!, flightDetails.value.priceChangedMessage, "info");
      }
      if (flightDetails.value.scheduleChanged) {
        showSnackbar(
            Get.context!, flightDetails.value.scheduleChangedMessage, "info");
      }
    }
  }

  void changeSelectedCabinClass(CabinInfo selectedCabinInfo) {
    cabinInfo.value = selectedCabinInfo;
  }

  Future<void> getPreTravellerData(int tempDetailId) async {
    if (!isFlightPretravellerDataLoading.value) {
      isFlightPretravellerDataLoading.value = true;
      detailId.value = tempDetailId;
      FlightPretravellerData tempFlightPretravellerData =
          await flightBookingHttpService.getPreTravellerData(tempDetailId);
      isFlightPretravellerDataLoading.value = false;

      if (tempFlightPretravellerData.countriesList.length > 0) {
        flightPretravellerData.value = tempFlightPretravellerData;
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }

  Future<void> setPreTravellerData(List<TravelInfo> travelInfo) async {
    if (!isFlightTravellerDataSaveLoading.value) {
      isFlightTravellerDataSaveLoading.value = true;
      selectedTravelInfo.value = travelInfo;
      String tempBookingRef = "";
      FlightTravellerData flightTravellerData = FlightTravellerData(
          travellerinfo: travelInfo,
          objectID: objectId.value,
          detailID: detailId.value,
          cabinID: int.parse(cabinInfo.value.id),
          mobileCntry: mobileCntry.value,
          mobileNumber: mobileNumber.value,
          email: email.value);
      BookingRefData bookingRefData =
          await flightBookingHttpService.setTravellerData(flightTravellerData);
      isFlightTravellerDataSaveLoading.value = false;
      tempBookingRef = bookingRefData.bookingRef;
      if (tempBookingRef != "") {
        bookingRef.value = tempBookingRef;
        isSeatSelection.value = bookingRefData.isSeatSelection;
        isMealSelection.value = bookingRefData.isMealSelection;
        isExtraBaggageSelection.value = bookingRefData.isExtraBaggageSelection;
        if (isSeatSelection.value == true ||
            isMealSelection.value == true ||
            isExtraBaggageSelection.value == true) {
          Get.toNamed(Approute_flightsAddonServices);
        } else {
          getPaymentGateways(false);
        }
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }

  checkSmartPayment(String tempBookingRef) async {
    isSmartPaymentCheckLoading.value = true;

    bool isSuccess =
        await flightBookingHttpService.checkSmartPayment(tempBookingRef);

    if (isSuccess) {
      bookingRef.value = tempBookingRef;
      getPaymentGateways(true);
    } else {
      isSmartPaymentCheckLoading.value = false;
      showSnackbar(Get.context!, "couldnt_find_booking".tr, "error");
    }
  }

  Future<void> getPaymentGateways(bool isSmartpayment) async {

    isFlightTravellerDataSaveLoading.value = true;
    if(!isSmartpayment && ( isSeatSelection.value|| isMealSelection.value || isExtraBaggageSelection.value)){
      saveAddonsPrice();
    }
    GetGatewayData getGatewayData =
        await flightBookingHttpService.getPaymentGateways(bookingRef.value);
    List<PaymentGateway> tempPaymentGateway = getGatewayData.paymentGateways;
    print("tempPaymentGateway");
    print(tempPaymentGateway.length);
    print(tempPaymentGateway[0]);
    paymentGateways.value = tempPaymentGateway;

    if (isSmartpayment) {
      flightDetails.value = getGatewayData.flightDetails;
      if (flightDetails.value.cabinInfos.isNotEmpty &&
          cabinInfo.value.id == "-1") {
        print("selectedCabinInfo.isNotEmpty");
        cabinInfo.value = flightDetails.value.cabinInfos[0];
      }
    }

    if (tempPaymentGateway.isNotEmpty) {
      updateProcessId(tempPaymentGateway[0].processID);
      Get.toNamed(Approute_flightsSummary);
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }
    isSmartPaymentCheckLoading.value = false;
    isFlightTravellerDataSaveLoading.value = false;
  }

  Future<void> setPaymentGateway() async {
    isFlightSavePaymentGatewayLoading.value = true;

    PaymentGatewayUrlData paymentGatewayUrlData =
        await flightBookingHttpService.setPaymentGateway(
            processId.value, paymentCode.value, bookingRef.value);

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
      //         Get.offAllNamed(Approute_flightsSummary,
      //             predicate: (route) => Get.currentRoute == Approute_userDetailsSubmission);
      //         showSnackbar(Get.context!, "payment_capture_error".tr,"error");
      //       }
      //
      // });

      checkGatewayStatus();
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isFlightSavePaymentGatewayLoading.value = false;
  }

  Future<void> checkGatewayStatus() async {
    isFlightGatewayStatusCheckLoading.value = true;
    bool isSuccess =
        await flightBookingHttpService.checkGatewayStatus(bookingRef.value);

    print("checkGatewayStatus isSuccess");
    print(isSuccess);

    if (isSuccess) {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      getConfirmationData();
    } else {
      int iter = 0;
      Get.offNamedUntil(Approute_flightsSummary, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter == 1;
      });
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    }

    isFlightGatewayStatusCheckLoading.value = false;
  }

  Future<void> getConfirmationData() async {
    isFlightConfirmationDataLoading.value = true;

    PaymentConfirmationData paymentConfirmationData =
        await flightBookingHttpService.getConfirmationData(bookingRef.value);

    print("getConfirmationData");
    print(paymentConfirmationData.isIssued);
    print(paymentConfirmationData.pdfLink);
    print(paymentConfirmationData.alertMsg);

    if (paymentConfirmationData.isIssued) {
      pdfLink.value = paymentConfirmationData.pdfLink;
      confirmationMessage.value = paymentConfirmationData.alertMsg;
      showSnackbar(Get.context!, "flight_booking_success".tr, "info");

      int iter = 0;
      Get.offNamedUntil(Approute_flightsConfirmation, arguments: [
        {"mode": "view"}
      ], (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter == 4;
      });
    } else {
      showSnackbar(Get.context!, "booking_failed".tr, "error");

      int iter = 0;
      Get.offNamedUntil(Approute_flightsSummary, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter == 1;
      });
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isFlightConfirmationDataLoading.value = false;
  }

  Future<void> getRecommendedForyou() async {
    recommendedPage.value = recommendedPage.value + 1;
    isRecommendedLoading.value = true;

    List<RecommendedPackage> tRecommendedPackages =
        await flightBookingHttpService.getRecommended(recommendedPage.value);
    recommendedPackages.value = tRecommendedPackages;

    isRecommendedLoading.value = false;
  }

  Future<void> getTravelStories() async {
    travelStoriesPage.value = travelStoriesPage.value + 1;
    isTravelStoriesLoading.value = true;

    List<TravelStory> tTravelStories = await flightBookingHttpService
        .getTravelStories(travelStoriesPage.value);
    travelStories.value = tTravelStories;

    isTravelStoriesLoading.value = false;
  }

  Future<void> getPopularPackages() async {
    popularDestinationsPage.value = popularDestinationsPage.value + 1;
    isPopularDestinationsLoading.value = true;

    List<PopularDestination> tPopularDestinations =
        await flightBookingHttpService
            .getPopularDestinations(travelStoriesPage.value);
    popularDestinations.value = tPopularDestinations;

    isPopularDestinationsLoading.value = false;
  }

  void updateProcessId(String? value) {
    if (value != null) {
      List<PaymentGateway> tempPaymentGateways = paymentGateways.value
          .where((element) => element.processID == value)
          .toList();

      if (tempPaymentGateways.isNotEmpty) {
        processId.value = value;
        paymentCode.value = tempPaymentGateways[0].paymentCode;
        processingFee.value = tempPaymentGateways[0].processingFee;
      }
    }
  }

  void resetAndNavigateToHome() {
    isModifySearchVisible.value = false;
    isFlightDestinationsLoading.value = false;
    isFlightPretravellerDataLoading.value = false;
    isFlightTravellerDataSaveLoading.value = false;
    isFlightSearchResponsesLoading.value = false;

    isFlightGatewayStatusCheckLoading.value = false;
    isFlightConfirmationDataLoading.value = false;
    isFlightSavePaymentGatewayLoading.value = false;
    isFlightMoreOptionsResponsesLoading.value = false;
    isFlightDetailsLoading.value = false;
    isFlightSearchFilterResponsesLoading.value = false;
    isInitialDataLoading.value = false;

    flightDestinations.value = [];
    flightSearchItems.value = [];
    flightSearchResponses.value = [];

    sortingDc.value = SortingDcs(value: "-1", name: "", isDefault: false);

    bookingRef.value = "";
    currency.value = "KWD";

    currentFlightIndex.value = (-1);
    sortingDcs.value = [];
    airlineDcs.value = [];
    selectedAirlineDcs.value = [];
    departureTimeDcs.value = [];
    selectedDepartureTimeDcs.value = [];
    arrivalTimeDcs.value = [];
    selectedArrivalTimeDcs.value = [];
    stopDcs.value = [];
    selectedStopDcs.value = [];
    priceDcs.value = [];
    selectedPriceDcs.value = [];
    selectedTravelInfo.value = [];
    flightSearchData.value = getDefaultFlightSearchData();
    startDate.value = DefaultInvalidDate;
    flightDetails.value = getDefaultFlightDetails();
    cabinInfo.value = mapCabinInfo({});
    flightPretravellerData.value = mapFlightPretravellerData({});

    Get.offAllNamed(Approute_landingpage);
  }

  void setDefaultSearchData() {
    if (cabinClasses.isNotEmpty) {
      List<CabinClass> allowedCabinClasses = [];
      allowedCabinClasses.add(cabinClasses.value[0]);
      updatePassengerCountAndCabinClass(1, 0, 0, allowedCabinClasses);
    }
  }


}
