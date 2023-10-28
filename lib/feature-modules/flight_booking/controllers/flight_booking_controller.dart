import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
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
part 'flight_booking_controller_setter.dart';

class FlightBookingController extends GetxController {

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

  var airlineDc = SortingDcs(
      value: "-1",
      name: "",
      isDefault: false
  ).obs;

  var departureTimeDc = SortingDcs(
      value: "-1",
      name: "",
      isDefault: false
  ).obs;

  var arrivalTimeDc = SortingDcs(
      value: "-1",
      name: "",
      isDefault: false
  ).obs;

  var stopDc = SortingDcs(
      value: "-1",
      name: "",
      isDefault: false
  ).obs;

  var priceDc = RangeDcs(
      min: 0.0,
      max: 100000.0,
  ).obs;

  var sortingDcs = <SortingDcs>[].obs;
  var airlineDcs = <SortingDcs>[].obs;
  var departureTimeDcs = <SortingDcs>[].obs;
  var arrivalTimeDcs = <SortingDcs>[].obs;
  var stopDcs = <SortingDcs>[].obs;
  var priceDcs = <RangeDcs>[].obs;
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

  Future<void> getSearchResults() async {

    if(flightSearchData.value.allowedCabins.isNotEmpty && flightSearchData.value.adults>0 &&
        !isFlightSearchResponsesLoading.value){
      isFlightSearchResponsesLoading.value = true;
      FlightSearchResult flightSearchResult = await flightBookingHttpService.getFlightSearchResults(flightSearchData.value);
      flightSearchResponses.value = flightSearchResult.searchResponses;
      sortingDcs.value = flightSearchResult.sortingDcs;
      if(sortingDcs.isNotEmpty ){
        List<SortingDcs> defaultSort = sortingDcs.where((p0) => p0.isDefault).toList();
        sortingDc.value = defaultSort.isNotEmpty?defaultSort[0]:sortingDcs[0];
      }
      priceDcs.value = flightSearchResult.priceDcs;
      airlineDcs.value = flightSearchResult.airlineDcs;
      arrivalTimeDcs.value = flightSearchResult.arrivalTimeDcs;
      departureTimeDcs.value = flightSearchResult.departureTimeDcs;
      stopDcs.value = flightSearchResult.stopDcs;

      isFlightSearchResponsesLoading.value = false;
      isFlightSearchFilterResponsesLoading.value = false;
      Get.toNamed(Approute_flightsSearchResult);
    }


  }

  Future<void> filterSearchResults() async {

    if(flightSearchData.value.allowedCabins.isNotEmpty && flightSearchData.value.adults>0 &&
        !isFlightSearchFilterResponsesLoading.value){
      isFlightSearchFilterResponsesLoading.value = true;
      FlightSearchResult flightSearchResult = await flightBookingHttpService.getFlightSearchResultsFiltered(
          flightSearchData.value);
      flightSearchResponses.value = flightSearchResult.searchResponses;
      sortingDcs.value = flightSearchResult.sortingDcs;
      if(sortingDcs.isNotEmpty ){
        List<SortingDcs> defaultSort = sortingDcs.where((p0) => p0.isDefault).toList();
        sortingDc.value = defaultSort.isNotEmpty?defaultSort[0]:sortingDcs[0];
      }
      priceDcs.value = flightSearchResult.priceDcs;
      airlineDcs.value = flightSearchResult.airlineDcs;
      arrivalTimeDcs.value = flightSearchResult.arrivalTimeDcs;
      departureTimeDcs.value = flightSearchResult.departureTimeDcs;
      stopDcs.value = flightSearchResult.stopDcs;

      isFlightSearchFilterResponsesLoading.value = false;
      Get.toNamed(Approute_flightsSearchResult);
    }


  }

}
