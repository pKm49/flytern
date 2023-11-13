    import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/h_cabin_info.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_destination.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_details.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_filter_body.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_pretraveller_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_item_room_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_response.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_result.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_traveller_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_traveller_info.dart';
import 'package:flytern/feature-modules/hotel_booking/services/helper-services/hotel_booking_helper_services.dart';
import 'package:flytern/feature-modules/hotel_booking/services/http-services/hotel_booking_http_services.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';
 import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/models/business_models/payment_confirmation_data.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway_url_data.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';
part 'hotel_booking_controller_setter.dart';

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

  var isHotelGatewayStatusCheckLoading = false.obs;
  var isHotelConfirmationDataLoading = false.obs;
  var isHotelSavePaymentGatewayLoading = false.obs;
  var isHotelMoreOptionsResponsesLoading = false.obs;
  var isHotelDetailsLoading = false.obs;
  var isHotelSearchFilterResponsesLoading = false.obs;
  var isInitialDataLoading = true.obs;
  var hotelBookingHttpService = HotelBookingHttpService();
  var hotelBookingHelperServices = HotelBookingHelperServices();

  var hotelDestinations = <HotelDestination>[].obs;
  var hotelSearchItems = <HotelSearchItemRoomData>[].obs;
  var hotelSearchResponses = <HotelSearchResponse>[].obs;
  var moreOptionHotels = <HotelSearchResponse>[].obs;
  var paymentGateways = <PaymentGateway>[].obs;

  var sortingDc = SortingDcs(value: "-1", name: "", isDefault: false).obs;

  var selectedDestination = mapHotelDestination({}).obs;
  var destination = "".obs;
  var bookingRef = "".obs;
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

  var processingFee = (0.0).obs;

  var currentHotelIndex = (-1).obs;
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
  var selectedTravelInfo = <HotelTravelInfo>[].obs;
  var hotelSearchData = getDefaultHotelSearchData().obs;
  var startDate = DefaultInvalidDate.obs;
  var hotelDetails = getDefaultHotelDetails().obs;
  var cabinInfo = mapHotelCabinInfo({}).obs;
  var hotelPretravellerData = mapHotelPretravellerData({}).obs;

  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<HotelDestination>> getHotelDestinations(
      String searchQuery) async {
    isHotelDestinationsLoading.value = true;

    if (searchQuery != "") {
      hotelDestinations.value =
          await hotelBookingHttpService.getHotelDestinations(searchQuery);
      isHotelDestinationsLoading.value = false;
      return hotelDestinations.value;
    } else {
      return [];
    }
  }

  Future<void> getSearchResults(bool isNavigationRequired) async {
    if (hotelSearchData.value.rooms.isNotEmpty &&
        hotelSearchData.value.destination !="" &&
        !isHotelSearchResponsesLoading.value) {
      print("getSearchResults called ");
      isHotelSearchResponsesLoading.value = true;
      HotelSearchResult hotelSearchResult = await hotelBookingHttpService
          .getHotelSearchResults(hotelSearchData.value);
      hotelSearchResponses.value = hotelSearchResult.searchResponses;
      if (hotelSearchResponses.isNotEmpty) {
        objectId.value = hotelSearchResponses.value[0].objectId;
        currency.value = hotelSearchResponses.value[0].currency;
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
      airlineDcs.value = hotelSearchResult.airlineDcs;
      arrivalTimeDcs.value = hotelSearchResult.arrivalTimeDcs;
      departureTimeDcs.value = hotelSearchResult.departureTimeDcs;
      stopDcs.value = hotelSearchResult.stopDcs;

      isHotelSearchResponsesLoading.value = false;
      isHotelSearchFilterResponsesLoading.value = false;
      if (isNavigationRequired) {
        Get.toNamed(Approute_hotelsSearchResult);
      } else {
        isModifySearchVisible.value = false;
      }
    }
  }

  Future<void> filterSearchResults() async {
    if (!isHotelSearchFilterResponsesLoading.value) {
      isHotelSearchFilterResponsesLoading.value = true;

      HotelFilterBody hotelFilterBody = HotelFilterBody(
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

      List<HotelSearchResponse> hotelSearchResponse =
          await hotelBookingHttpService
              .getHotelSearchResultsFiltered(hotelFilterBody);

      hotelSearchResponses.value = hotelSearchResponse;
      isHotelSearchFilterResponsesLoading.value = false;
    }
  }


  Future<void> getHotelDetails(int index) async {
    if (index > -1 && !isHotelDetailsLoading.value) {
      currentHotelIndex.value = index;
      isHotelDetailsLoading.value = true;
      print("getMoreOptions called ");

      print(isHotelDetailsLoading.value && currentHotelIndex.value == index);
      HotelDetails tempHotelDetails =
          await hotelBookingHttpService.getHotelDetails(index, objectId.value);
      hotelDetails.value = tempHotelDetails;
      List<HotelCabinInfo> selectedCabinInfo = hotelDetails.value.cabinInfos
          .where((element) => element.id == hotelDetails.value.selectedCabinId)
          .toList();
      if (selectedCabinInfo.isNotEmpty) {
        print("selectedCabinInfo.isNotEmpty");
        cabinInfo.value = selectedCabinInfo[0];
      }
      isHotelDetailsLoading.value = false;
      Get.toNamed(Approute_hotelsDetails);
      if (hotelDetails.value.priceChanged) {
        showSnackbar(
            Get.context!, hotelDetails.value.priceChangedMessage, "info");
      }
      if (hotelDetails.value.scheduleChanged) {
        showSnackbar(
            Get.context!, hotelDetails.value.scheduleChangedMessage, "info");
      }
    }
  }

  void changeSelectedCabinClass(HotelCabinInfo selectedCabinInfo) {
    cabinInfo.value = selectedCabinInfo;
  }

  Future<void> getPreTravellerData(int tempDetailId) async {
    if (!isHotelPretravellerDataLoading.value) {
      isHotelPretravellerDataLoading.value = true;
      detailId.value = tempDetailId;
      HotelPretravellerData tempHotelPretravellerData =
          await hotelBookingHttpService.getPreTravellerData(tempDetailId);
      isHotelPretravellerDataLoading.value = false;

      if (tempHotelPretravellerData.countriesList.length > 0) {
        hotelPretravellerData.value = tempHotelPretravellerData;

        // Get.toNamed(Approute_hotelsAddonServices);
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
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
          objectID: objectId.value,
          detailID: detailId.value,
          cabinID: int.parse(cabinInfo.value.id),
          mobileCntry: mobileCntry.value,
          mobileNumber: mobileNumber.value,
          email: email.value);
      tempBookingRef =
          await hotelBookingHttpService.setTravellerData(hotelTravellerData);
      isHotelTravellerDataSaveLoading.value = false;
      if (tempBookingRef != "") {
        bookingRef.value = tempBookingRef;
        getPaymentGateways();
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }

  Future<void> getPaymentGateways() async {
    isHotelTravellerDataSaveLoading.value = true;

    List<PaymentGateway> tempPaymentGateway =
        await hotelBookingHttpService.getPaymentGateways(bookingRef.value);

    print("tempPaymentGateway");
    print(tempPaymentGateway.length);
    print(tempPaymentGateway[0]);
    paymentGateways.value = tempPaymentGateway;
    if (tempPaymentGateway.isNotEmpty) {
      updateProcessId(tempPaymentGateway[0].processID);
      Get.toNamed(Approute_hotelsSummary);
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isHotelTravellerDataSaveLoading.value = false;
  }

  Future<void> setPaymentGateway() async {
    isHotelSavePaymentGatewayLoading.value = true;

    PaymentGatewayUrlData paymentGatewayUrlData =
        await hotelBookingHttpService.setPaymentGateway(
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
      //         Get.offAllNamed(Approute_hotelsSummary,
      //             predicate: (route) => Get.currentRoute == Approute_userDetailsSubmission);
      //         showSnackbar(Get.context!, "payment_capture_error".tr,"error");
      //       }
      //
      // });

      checkGatewayStatus();
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isHotelSavePaymentGatewayLoading.value = false;
  }

  Future<void> checkGatewayStatus() async {
    isHotelGatewayStatusCheckLoading.value = true;
    bool isSuccess =
        await hotelBookingHttpService.checkGatewayStatus(bookingRef.value);

    print("checkGatewayStatus isSuccess");
    print(isSuccess);

    if (isSuccess) {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      getConfirmationData();
    } else {
      int iter = 0;
      Get.offNamedUntil(Approute_hotelsSummary, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter == 1;
      });
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    }

    isHotelGatewayStatusCheckLoading.value = false;
  }

  Future<void> getConfirmationData() async {
    isHotelConfirmationDataLoading.value = true;

    PaymentConfirmationData paymentConfirmationData =
        await hotelBookingHttpService.getConfirmationData(bookingRef.value);

    print("getConfirmationData");
    print(paymentConfirmationData.isIssued);
    print(paymentConfirmationData.pdfLink);
    print(paymentConfirmationData.alertMsg);

    if (paymentConfirmationData.isIssued) {
      pdfLink.value = paymentConfirmationData.pdfLink;
      confirmationMessage.value = paymentConfirmationData.alertMsg;
      showSnackbar(Get.context!, "hotel_booking_success".tr, "info");

      int iter = 0;
      Get.offNamedUntil(Approute_hotelsConfirmation, arguments: [
        {"mode": "view"}
      ], (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter == 4;
      });
    } else {
      showSnackbar(Get.context!, "booking_failed".tr, "error");

      int iter = 0;
      Get.offNamedUntil(Approute_hotelsSummary, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter == 1;
      });
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
        processId.value = value;
        paymentCode.value = tempPaymentGateways[0].paymentCode;
        processingFee.value = tempPaymentGateways[0].processingFee;
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
    currency.value = "KWD";

    currentHotelIndex.value = (-1);
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
    hotelSearchData.value = getDefaultHotelSearchData();
    startDate.value = DefaultInvalidDate;
    hotelDetails.value = getDefaultHotelDetails();
    cabinInfo.value = mapHotelCabinInfo({});
    hotelPretravellerData.value = mapHotelPretravellerData({});

    Get.offAllNamed(Approute_landingpage);
  }
}
