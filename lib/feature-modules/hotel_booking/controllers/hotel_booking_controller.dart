 import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_destination.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_details.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_filter_body.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_pretraveller_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_room.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_room_option.dart';
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

  var quickSearch = <HotelSearchData>[].obs;
  var hotelDestinations = <HotelDestination>[].obs;
  var hotelSearchItems = <HotelSearchItemRoomData>[].obs;
  var hotelSearchResponses = <HotelSearchResponse>[].obs;
  var moreOptionHotels = <HotelSearchResponse>[].obs;
  var paymentGateways = <PaymentGateway>[].obs;
  var selectedPaymentGateway = mapPaymentGateway({}).obs;

  var sortingDc = SortingDcs(value: "-1", name: "", isDefault: false).obs;

  var selectedDestination = mapHotelDestination({}).obs;
  var destination = "".obs;
  var bookingRef = "".obs;
  var priceUnit = "KWD".obs;
  var selectedRoomSelectionIndex = 0.obs;
  var pageId = 1.obs;
  var hotelId =  (-1).obs;
  var objectId = (-1).obs;
  var processId = "-1".obs;
  var paymentCode = "".obs;
  var gatewayUrl = "".obs;
  var confirmationUrl = "".obs;
  var confirmationMessage = "".obs;
  var pdfLink = "".obs;

  var processingFee = (0.0).obs;

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
      countryName: "select_nationality".tr,
      countryCode: "",
      countryISOCode: "",
      countryName_Ar: "",
      flag: "",
      code: "").obs;

  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;

  @override
  void onInit() {
    super.onInit();
    getRecentSearch();
  }

  Future<void> getRecentSearch() async {

    isInitialDataLoading.value = true;

    quickSearch.value =
    await hotelBookingHttpService.getRecentSearch();
    isInitialDataLoading.value = false;

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
      objectId.value = -1;
      print("getSearchResults called ");
      isHotelSearchResponsesLoading.value = true;
      if (isNavigationRequired) {
        Get.toNamed(Approute_hotelsSearchResult);
      } else {
        isModifySearchVisible.value = false;
      }

      HotelSearchResult hotelSearchResult = await hotelBookingHttpService
          .getHotelSearchResults(hotelSearchData.value);
      hotelSearchResponses.value = hotelSearchResult.searchResponses;
      print("hotelSearchResponses value ");
      print(hotelSearchResponses.isNotEmpty);
      objectId.value = hotelSearchResult.objectID;

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
        tHotelSearchData.destination !="" &&
        !isHotelSearchResponsesLoading.value) {
      objectId.value = -1;
      print("getSearchResults called ");
      isHotelSearchResponsesLoading.value = true;
      Get.toNamed(Approute_hotelsSearchResult);

      HotelSearchResult hotelSearchResult = await hotelBookingHttpService
          .getHotelSearchResults(tHotelSearchData);
      hotelSearchResponses.value = hotelSearchResult.searchResponses;
      print("hotelSearchResponses value ");
      print(hotelSearchResponses.isNotEmpty);
      objectId.value = hotelSearchResult.objectID;

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

      HotelFilterBody hotelFilterBody = HotelFilterBody(
        pageId: pageId.value,
        objectID: objectId.value,
        priceMinMaxDc: selectedPriceDcs.value.isNotEmpty
            ? "${selectedPriceDcs.value[0].min}, ${selectedPriceDcs.value[0].max}"
            : "",
        locationDcs: selectedlocationDcs.value.isNotEmpty
            ? getFilterValues(selectedlocationDcs.value)
            : "",
        ratingDcs: selectedratingDcs.value.isNotEmpty
            ? getFilterValues(selectedratingDcs.value)
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

  Future<void> getHotelDetails(int tHotelid) async {
    print(tHotelid);
    print(tHotelid > -1);
    print(!isHotelDetailsLoading.value);
    if (tHotelid > -1 && !isHotelDetailsLoading.value) {
      print("inside");
      hotelId.value = tHotelid;
      isHotelDetailsLoading.value = true;
      print("getMoreOptions called ");
      selectedRoom.value =[];
      selectedRoomOption.value =[];
      selectedRoomSelectionIndex.value = 0;

      HotelDetails tempHotelDetails =
          await hotelBookingHttpService.getHotelDetails(hotelId.value, objectId.value);
      hotelDetails.value = tempHotelDetails;
      print("room length after maping");
      print(hotelDetails.value.rooms.length);
      if(hotelDetails.value.rooms.isNotEmpty){
        for(var i=0;i<hotelSearchData.value.rooms.length;i++){
          selectedRoom.value.add(hotelDetails.value.rooms[0]) ;
        }
        if(hotelDetails.value.rooms[0].roomOptions.isNotEmpty){
          for(var i=0;i<hotelSearchData.value.rooms.length;i++){
            selectedRoomOption.value.add(hotelDetails.value.rooms[0].roomOptions[0]);
          }
        }
      }

      print("selectedRoom length");
      print(hotelSearchData.value.rooms.length);
      print(selectedRoom.length);
      print(selectedRoomOption.length);

      isHotelDetailsLoading.value = false;
      Get.toNamed(Approute_hotelsDetails);
      getPreTravellerData();
    }
  }


  Future<void> getPreTravellerData() async {
    if (!isHotelPretravellerDataLoading.value) {
      isHotelPretravellerDataLoading.value = true;
      HotelPretravellerData tempHotelPretravellerData =
          await hotelBookingHttpService.getPreTravellerData();
      isHotelPretravellerDataLoading.value = false;

      if (tempHotelPretravellerData.genderList.isNotEmpty) {
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
        selectedPaymentGateway.value = tempPaymentGateways[0];
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




}
