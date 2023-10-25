import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/feature-modules/flight_booking/services/http-services/flight_booking_http_services.dart';
import 'package:get/get.dart';

class FlightBookingController extends GetxController {
  var isFlightDestinationsLoading = true.obs;
  var isInitialDataLoading = true.obs;
  var flightBookingHttpService = FlightBookingHttpService();

  var cabinClasses = <CabinClass>[].obs;
  var recommendedPackages = <RecommendedPackage>[].obs;
  var popularDestinations = <PopularDestination>[].obs;
  var travelStories = <TravelStory>[].obs;
  var flightDestinations = <FlightDestination>[].obs;
  var flightSearchItems = <FlightSearchItem>[].obs;
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
    flightDestinations.value =
    await flightBookingHttpService.getFlightDestinations(searchQuery);
    isFlightDestinationsLoading.value = false;
    return flightDestinations.value;
  }

  setDestination(FlightDestination flightDestination, bool isArrival,
      int index) {
    FlightSearchData newFlightSearchData = FlightSearchData(
        promoCode: flightSearchData.value.promoCode,
        adults: flightSearchData.value.adults,
        child: flightSearchData.value.child,
        infants: flightSearchData.value.infants,
        searchList: getUpdatedSearchList(flightDestination, isArrival, index),
        allowedCabins: flightSearchData.value.allowedCabins,
        mode: flightSearchData.value.mode,
        isDirectFlight: flightSearchData.value.isDirectFlight);

    flightSearchData.value = newFlightSearchData;
  }

  List<FlightSearchItem> getUpdatedSearchList(
      FlightDestination flightDestination, bool isArrival, int index) {
    List<FlightSearchItem> flightSearchItems = [];


    for (var i = 0; i < flightSearchData.value.searchList.length; i++) {
      if (index != i) {
        flightSearchItems.add(flightSearchData.value.searchList[i]);
      } else {
        FlightSearchItem flightSearchItem = FlightSearchItem(
            departure: !isArrival ? flightDestination : flightSearchData.value.searchList[i].departure ,
            arrival: isArrival ? flightDestination : flightSearchData.value .searchList[i].arrival,
            departureDate: flightSearchData.value.searchList[i].departureDate,
            returnDate: flightSearchData.value.searchList[i].returnDate
        );
        flightSearchItems.add(flightSearchItem);
      }
    }
    return flightSearchItems;
  }


}