import 'dart:ffi';

import 'package:flytern/feature-modules/flight_booking/constants/flight_mode.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/constants/flight_mode.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/extra_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/extra_package_selection.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/set_extra_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/get_meal.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/meal_selection.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/set_meal.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/flight_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/get_extra_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/get_seat.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/meal.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/passenger.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/route.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/seat_column.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/seat_selection.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/set_seat.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/booking_ref_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/cabin_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/cabin_info.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/explore_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/filter_body.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/pretraveller_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_item.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_response.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_result.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/traveller_data.flight_booking.model.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/popular_destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/recommended_package.flight_booking.model.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/models/travel_story.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/traveller_info.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper.flight_booking.service.dart';
import 'package:flytern/feature-modules/flight_booking/services/http.flight_booking.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';

part 'data_setter.flight_booking.controller.dart';

part 'addons_handler.flight_booking.controller.dart';

class FlightBookingController extends GetxController {
  final sharedController = Get.find<SharedController>();

  var selectedRouteForSeat = "1".obs;
  var selectedPassengerForSeat = "1".obs;
  var selectedRouteForMeal = "1".obs;
  var selectedPassengerForMeal = "1".obs;
  var selectedRouteForExtraPackage = "1".obs;
  var selectedPassengerForExtraPackage = "1".obs;
  var flightAddonSetSeatData = getDummyFlightAddonSetSeat({}).obs;
  var flightAddonSetMealData = getDummyFlightAddonSetMeal({}).obs;
  var flightAddonSetExtraPackageData =
      getDummyFlightAddonSetExtraPackage({}).obs;
  var travelInfo = <TravelInfo>[].obs;
  var alertMsg = "".obs;
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
  var isTravelStoriesPageLoading = false.obs;
  var isRecommendedLoading = false.obs;
  var isRecommendedPageLoading = false.obs;
  var isPopularDestinationsLoading = false.obs;
  var isPopularDestinationsPageLoading = false.obs;

  var isPassengersSelected = false.obs;
  var searchResultsPage = 1.obs;
  var isSearchScrollOver = false.obs;
  var travelStoriesPage = 1.obs;
  var isTravelStoriesPageScrollOver = false.obs;
  var popularDestinationsPage = 1.obs;
  var isPopularDestinationsPageScrollOver = false.obs;
  var recommendedPage = 1.obs;
  var isRecommendedPageScrollOver = false.obs;

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
  var isFlightSearchPageResponsesLoading = false.obs;

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
  var paymentRef = "".obs;
  var isSeatSelection = false.obs;
  var isMealSelection = false.obs;
  var isExtraBaggageSelection = false.obs;
  var currency = "KWD".obs;
  var objectId = 1.obs;
  var detailId = 1.obs;
  var selectedPaymentGateway = mapPaymentGateway({}).obs;

  var gatewayUrl = "".obs;
  var confirmationUrl = "".obs;
  var pdfLink = "".obs;
  var isIssued = false.obs;
  var bookingInfo = <BookingInfo>[].obs;
  var paymentInfo = <BookingInfo>[].obs;
  var alert = <String>[].obs;
  var seatTotalAmount = (0.0).obs;
  var mealTotalAmount = (0.0).obs;
  var baggageTotalAmount = (0.0).obs;

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
    ExploreData exploreData = await flightBookingHttpService.getInitialInfo();

    print(exploreData.cabinClasses.length);
    print(exploreData.recommendedPackages.length);
    print(exploreData.popularDestinations.length);
    cabinClasses.value = exploreData.cabinClasses;
    recommendedPackages.value = exploreData.recommendedPackages;
    popularDestinations.value = exploreData.popularDestinations;
    travelStories.value = exploreData.travelStories;
    quickSearch.value = exploreData.quickSearch;
    setDefaultSearchData();

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
    if (tFlightSearchData.allowedCabins.isNotEmpty &&
        tFlightSearchData.adults > 0 &&
        !isFlightSearchResponsesLoading.value) {
      searchResultsPage.value = 1;
      isSearchScrollOver.value = false;
      flightSearchData.value = tFlightSearchData;
      Get.toNamed(Approute_flightsSearchResult);

      isFlightSearchResponsesLoading.value = true;
      FlightSearchResult flightSearchResult = await flightBookingHttpService
          .getFlightSearchResults(tFlightSearchData);
      flightSearchResponses.value = flightSearchResult.searchResponses;
      alertMsg.value = flightSearchResult.alertMsg;
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
        showSnackbar(Get.context!, "select_passenger_cabin".tr, "error");
      }
    }
  }

  Future<void> getSearchResults(bool isNavigationRequired) async {
    if (flightSearchData.value.allowedCabins.isNotEmpty &&
        flightSearchData.value.adults > 0 &&
        !isFlightSearchResponsesLoading.value) {
      searchResultsPage.value = 1;
      isSearchScrollOver.value = false;
      if (isNavigationRequired) {
        Get.toNamed(Approute_flightsSearchResult);
      } else {
        isModifySearchVisible.value = false;
      }
      isFlightSearchFilterResponsesLoading.value = true;
      isFlightSearchResponsesLoading.value = true;
      FlightSearchResult flightSearchResult = await flightBookingHttpService
          .getFlightSearchResults(flightSearchData.value);
      alertMsg.value = flightSearchResult.alertMsg;

      flightSearchResponses.value = flightSearchResult.searchResponses;
      if (flightSearchResponses.isNotEmpty) {
        objectId.value = flightSearchResponses.value[0].objectId;
        currency.value = flightSearchResponses.value[0].currency;
        startDate.value = flightSearchData.value.searchList[0].departureDate;
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
        showSnackbar(Get.context!, "select_passenger_cabin".tr, "error");
      }
    }
  }

  Future<void> filterSearchResults() async {
    if (!isFlightSearchFilterResponsesLoading.value) {
      isFlightSearchFilterResponsesLoading.value = true;
      searchResultsPage.value = 1;
      isSearchScrollOver.value = false;
      FlightFilterBody flightFilterBody = FlightFilterBody(
        pageId: 1,
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

      FlightSearchResult flightSearchResult = await flightBookingHttpService
          .getFlightSearchResultsFiltered(flightFilterBody);

      alertMsg.value = flightSearchResult.alertMsg;
      flightSearchResponses.value = flightSearchResult.searchResponses;
      isFlightSearchFilterResponsesLoading.value = false;
    }
  }

  Future<void> getMoreOptions(int index) async {
    if (index > -1 && !isFlightMoreOptionsResponsesLoading.value) {
      Get.toNamed(Approute_flightsMoreOptions);

      isFlightMoreOptionsResponsesLoading.value = true;
      FlightSearchResult flightSearchResult =
          await flightBookingHttpService.getMoreOptions(index, objectId.value);
      moreOptionFlights.value = flightSearchResult.searchResponses;
      alertMsg.value = flightSearchResult.alertMsg;

      isFlightMoreOptionsResponsesLoading.value = false;
    }
  }

  Future<void> getFlightDetails(int index) async {
    if (index > -1 && !isFlightDetailsLoading.value) {

      try{
        currentFlightIndex.value = index;
        isFlightDetailsLoading.value = true;
        Get.toNamed(Approute_flightsDetails);
        FlightDetails tempFlightDetails = await flightBookingHttpService
            .getFlightDetails(index, objectId.value);
        flightDetails.value = tempFlightDetails;
        List<CabinInfo> selectedCabinInfo = flightDetails.value.cabinInfos
            .where((element) => element.id == flightDetails.value.selectedCabinId)
            .toList();
        if (selectedCabinInfo.isNotEmpty) {
          cabinInfo.value = selectedCabinInfo[0];
        }
        isFlightDetailsLoading.value = false;

      }catch (e){
        isFlightDetailsLoading.value = false;
        Get.back();
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
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
          getPaymentGateways(false, bookingRef.value);
        }
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }

  Future<void> getPaymentGateways(
      bool isSmartpayment, String tempBookingRef) async {
    if (isSmartpayment) {
      bookingRef.value = tempBookingRef;
    }
    isFlightTravellerDataSaveLoading.value = true;
    paymentGateways.value = [];
    bookingInfo.value = [];

    alert.value = [];
    alert.value = [];
    if (!isSmartpayment &&
        (isSeatSelection.value ||
            isMealSelection.value ||
            isExtraBaggageSelection.value)) {
      saveAddonsPrice();
    }
    GetGatewayData getGatewayData =
        await flightBookingHttpService.getPaymentGateways(bookingRef.value);
    List<PaymentGateway> tempPaymentGateway = getGatewayData.paymentGateways;

    paymentGateways.value = tempPaymentGateway;
    bookingInfo.value = getGatewayData.bookingInfo;
    alert.value = getGatewayData.alert;
    if (isSmartpayment) {
      flightDetails.value = getGatewayData.flightDetails;
      if (flightDetails.value.cabinInfos.isNotEmpty &&
          cabinInfo.value.id == "-1") {
        cabinInfo.value = flightDetails.value.cabinInfos[0];
      }
    }

    if (tempPaymentGateway.isNotEmpty) {
      updateProcessId(tempPaymentGateway[0].processID);
    }
    Get.toNamed(Approute_flightsSummary);
    isSmartPaymentCheckLoading.value = false;
    isFlightTravellerDataSaveLoading.value = false;
  }

  Future<void> setPaymentGateway() async {
    isFlightSavePaymentGatewayLoading.value = true;

    PaymentGatewayUrlData paymentGatewayUrlData =
        await flightBookingHttpService.setPaymentGateway(
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
        Approute_flightsSummary
      ])?.then((value) {
        print("Get back from Approute_paymentPage");
        print("value");
        print(value);
        isFlightSavePaymentGatewayLoading.value = false;
        checkGatewayStatus();
      });

      // checkGatewayStatus();
    } else {
      isFlightSavePaymentGatewayLoading.value = false;
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }
  }

  Future<void> checkGatewayStatus() async {
    isFlightGatewayStatusCheckLoading.value = true;
    bool isSuccess =
        await flightBookingHttpService.checkGatewayStatus(paymentRef.value);

    if (isSuccess) {
      // showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      getConfirmationData(bookingRef.value, false);
    } else {
      getPaymentGateways(false, bookingRef.value);
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    }

    isFlightGatewayStatusCheckLoading.value = false;
  }

  Future<void> getConfirmationData(
      String bookingRef, bool isBookingFinder) async {
    isFlightConfirmationDataLoading.value = true;
    bookingInfo.value = [];
    paymentInfo.value = [];
    alert.value = [];
    pdfLink.value = "";
    isIssued.value = false;

    PaymentConfirmationData paymentConfirmationData =
        await flightBookingHttpService.getConfirmationData(bookingRef);

    if (paymentConfirmationData.isSuccess) {
      pdfLink.value = paymentConfirmationData.pdfLink;
      isIssued.value = paymentConfirmationData.isIssued;
      bookingInfo.value = paymentConfirmationData.bookingInfo;
      paymentInfo.value = paymentConfirmationData.paymentInfo;
      alert.value = paymentConfirmationData.alertMsg;
      flightDetails.value = paymentConfirmationData.flightDetails;

      if (isBookingFinder) {
        Get.toNamed(Approute_flightsConfirmation, arguments: [
          {"mode": "edit"}
        ]);
      } else {
        showSnackbar(Get.context!, "flight_booking_success".tr, "info");

        int iter = 0;
        Get.offNamedUntil(Approute_flightsConfirmation, arguments: [
          {"mode": "view"}
        ], (route) {
          return ++iter == 4;
        });
      }
    } else {
      if (!isBookingFinder) {
        showSnackbar(Get.context!, "booking_failed".tr, "error");

        int iter = 0;
        Get.offNamedUntil(Approute_flightsSummary, (route) {
          return ++iter == 1;
        });
      }

      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isFlightConfirmationDataLoading.value = false;
  }

  Future<void> getRecommendedForyou() async {

    if(!isRecommendedPageScrollOver.value){
      recommendedPage.value = recommendedPage.value + 1;
      isRecommendedPageLoading.value = true;

      List<RecommendedPackage> tRecommendedPackages =
      await flightBookingHttpService.getRecommended(recommendedPage.value);

      List<RecommendedPackage> tempRecommendedPackages = [];

      if(tRecommendedPackages.isEmpty){
        isRecommendedPageScrollOver.value = true;
      }

      for (var element in recommendedPackages.value) {
        tempRecommendedPackages.add(element);
      }

      for (var element in tRecommendedPackages) {
        tempRecommendedPackages.add(element);
      }

      recommendedPackages.value = tempRecommendedPackages;

      isRecommendedPageLoading.value = false;
    }


  }

  Future<void> getTravelStories() async {
    if (!isTravelStoriesPageScrollOver.value) {
      travelStoriesPage.value = travelStoriesPage.value + 1;
      isTravelStoriesPageLoading.value = true;

      List<TravelStory> tTravelStories = await flightBookingHttpService
          .getTravelStories(travelStoriesPage.value);

      List<TravelStory> tempTravelStories = [];

      if (tTravelStories.isEmpty) {
        isTravelStoriesPageScrollOver.value = true;
      }
      for (var element in travelStories.value) {
        tempTravelStories.add(element);
      }

      for (var element in tTravelStories) {
        tempTravelStories.add(element);
      }

      travelStories.value = tempTravelStories;

      isTravelStoriesPageLoading.value = false;
    }
  }

  Future<void> getPopularPackages() async {

    if(!isPopularDestinationsPageScrollOver.value){
      popularDestinationsPage.value = popularDestinationsPage.value + 1;
      isPopularDestinationsPageLoading.value = true;

      List<PopularDestination> tPopularDestinations =
      await flightBookingHttpService
          .getPopularDestinations(travelStoriesPage.value);

      if(tPopularDestinations.isEmpty){
        isPopularDestinationsPageScrollOver.value = true;
      }

      List<PopularDestination> tempPopularDestinations = [];

      for (var element in popularDestinations.value) {
        tempPopularDestinations.add(element);
      }

      for (var element in tPopularDestinations) {
        tempPopularDestinations.add(element);
      }

      popularDestinations.value = tempPopularDestinations;

      isPopularDestinationsPageLoading.value = false;
    }


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

  Future<void> getFlightSearchResultsNextPage() async {
    if (!isFlightSearchPageResponsesLoading.value &&
        !isSearchScrollOver.value) {
      isFlightSearchPageResponsesLoading.value = true;
      searchResultsPage.value = searchResultsPage.value + 1;

      FlightFilterBody flightFilterBody = FlightFilterBody(
        pageId: searchResultsPage.value,
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

      FlightSearchResult flightSearchResult = await flightBookingHttpService
          .getFlightSearchResultsFiltered(flightFilterBody);

      alertMsg.value = flightSearchResult.alertMsg;

      if (flightSearchResult.searchResponses.isEmpty) {
        isSearchScrollOver.value = true;
      }

      List<FlightSearchResponse> tFlightSearchResponse = [];

      for (var element in flightSearchResponses.value) {
        tFlightSearchResponse.add(element);
      }

      for (var element in flightSearchResult.searchResponses) {
        tFlightSearchResponse.add(element);
      }

      flightSearchResponses.value = tFlightSearchResponse;

      isFlightSearchPageResponsesLoading.value = false;
    }
  }

  void updateTravellerInfo(List<TravelInfo> tempTravelInfo) {
    travelInfo.value = tempTravelInfo;
  }

  void addTravellerInfo(TravelInfo tTravelInfo) {
    List<TravelInfo> tempTravelInfo = travelInfo.value;
    tempTravelInfo.add(tTravelInfo);
    travelInfo.value = tempTravelInfo;
  }
}
