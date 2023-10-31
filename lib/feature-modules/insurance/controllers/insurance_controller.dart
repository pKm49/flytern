import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_filter_body.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/range_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper-services/flight_booking_helper_services.dart';
import 'package:flytern/feature-modules/flight_booking/services/http-services/flight_booking_http_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:get/get.dart';


class InsuranceBookingController extends GetxController {

  var isFlightDestinationsLoading = false.obs;
  var isFlightSearchResponsesLoading = false.obs;
  var isFlightSearchFilterResponsesLoading = false.obs;
  var isInitialDataLoading = true.obs;
  var flightBookingHttpService = FlightBookingHttpService();
  var flightBookingHelperServices = FlightBookingHelperServices();

  var cabinClasses = <CabinClass>[].obs;
  var recommendedPackages = <RecommendedPackage>[].obs;
  var popularDestinations = <PopularDestination>[].obs;
  var travelStories = <TravelStory>[].obs;
  var flightDestinations = <FlightDestination>[].obs;
  var flightSearchItems = <FlightSearchItem>[].obs;
  var flightSearchResponses = <FlightSearchResponse>[].obs;

  var sortingDc = SortingDcs(
      value: "-1",
      name: "",
      isDefault: false
  ).obs;

  var currency ="KWD".obs;
  var pageId = 1.obs;
  var objectId = 1.obs;
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
  var flightSearchData = getDefaultFlightSearchData().obs;

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

  Future<void> getSearchResults(bool isNavigationRequired) async {
    if (flightSearchData.value.allowedCabins.isNotEmpty &&
        flightSearchData.value.adults > 0 &&
        !isFlightSearchResponsesLoading.value) {
      isFlightSearchResponsesLoading.value = true;
      FlightSearchResult flightSearchResult = await flightBookingHttpService
          .getFlightSearchResults(flightSearchData.value);
      flightSearchResponses.value = flightSearchResult.searchResponses;
      if(flightSearchResponses.isNotEmpty){
        objectId.value = flightSearchResponses.value[0].objectId;
        currency.value = flightSearchResponses.value[0].currency;
      }
      sortingDcs.value = flightSearchResult.sortingDcs;
      if (sortingDcs.isNotEmpty) {
        List<SortingDcs> defaultSort = sortingDcs.where((p0) => p0.isDefault)
            .toList();
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
      if(isNavigationRequired){
        Get.toNamed(Approute_flightsSearchResult);
      }
    }
  }

  Future<void> filterSearchResults() async {
    if ( !isFlightSearchFilterResponsesLoading.value) {
      isFlightSearchFilterResponsesLoading.value = true;

      FlightFilterBody flightFilterBody = FlightFilterBody(
          pageId: pageId.value,
          objectID: objectId.value,
          priceMinMaxDc: selectedPriceDcs.value.isNotEmpty?
          "${selectedPriceDcs.value[0].max}, ${selectedPriceDcs.value[0].min}":"",
          arrivalTimeDc: selectedArrivalTimeDcs.value.isNotEmpty?
          selectedArrivalTimeDcs.value.map((e) => e.value).toString():"",
          departureTimeDc: selectedDepartureTimeDcs.value.isNotEmpty?
          selectedDepartureTimeDcs.value.map((e) => e.value).toString():"",
          airlineDc: selectedAirlineDcs.value.isNotEmpty?
          selectedAirlineDcs.value.map((e) => e.value).toString():"",
          stopDc: selectedStopDcs.value.isNotEmpty?
          selectedStopDcs.value.map((e) => e.value).toString():"",
          sortingDc: sortingDc.value.value,
      );

      List<FlightSearchResponse> flightSearchResponse = await flightBookingHttpService
          .getFlightSearchResultsFiltered(flightFilterBody);

      flightSearchResponses.value = flightSearchResponse;
      isFlightSearchFilterResponsesLoading.value = false;
    }
  }

}
