import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/feature-modules/flight_booking/services/http-services/flight_booking_http_services.dart';
import 'package:flytern/shared/data/constants/business_constants/available_countries.dart';
import 'package:flytern/shared/data/constants/business_constants/available_languages.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/shared_http_services.dart';
import 'package:get/get.dart';

class FlightBookingController extends GetxController {

  var isInitialDataLoading = false.obs;
  var flightBookingHttpService = FlightBookingHttpService();

  var cabinClasses = <CabinClass>[].obs;
  var recommendedPackages = <RecommendedPackage>[].obs;
  var popularDestinations = <PopularDestination>[].obs;
  var travelStories = <TravelStory>[].obs;

  @override
  void onInit() {
    super.onInit();
    getInitialInfo();
  }

  Future<void> getInitialInfo() async {

    ExploreData? exploreData = await flightBookingHttpService.getInitialInfo();

    if(exploreData != null){
      cabinClasses.value = exploreData.cabinClasses;
      recommendedPackages.value = exploreData.recommendedPackages;
      popularDestinations.value = exploreData.popularDestinations;
      travelStories.value = exploreData.travelStories;
    }

  }

}
