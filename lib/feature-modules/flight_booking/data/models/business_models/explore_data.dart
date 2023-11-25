import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/shared-module/data/models/business_models/country.dart';
import 'package:flytern/shared-module/data/models/business_models/language.dart';

class ExploreData {

  final List<FlightSearchData> quickSearch;
  final List<CabinClass> cabinClasses;
  final List<RecommendedPackage> recommendedPackages;
  final List<PopularDestination> popularDestinations;
  final List<TravelStory> travelStories;

  ExploreData({
    required this.quickSearch,
    required this.cabinClasses,
    required this.recommendedPackages,
    required this.popularDestinations,
    required this.travelStories,
  });

  Map toJson() => {
    'quickSearch': quickSearch,
    'cabinClasses': cabinClasses,
    'recommendedPackages': recommendedPackages,
    'popularDestinations': popularDestinations,
    'travelStories': travelStories,
  };

}

ExploreData mapExploreData(dynamic payload){

  List<FlightSearchData> quickSearch = [];
  List<CabinClass> tempCabinClasses = [];
  List<RecommendedPackage> tempRecommendedPackages = [];
  List<PopularDestination> tempPopularDestinations = [];
  List<TravelStory> tempTravelStories = [];

  if(payload["quickSearch"] != null){
    payload["quickSearch"].forEach((element) {
      quickSearch.add(mapFlightSearchData(element));
    });
  }

  if(payload["cabinClass"] != null){
    payload["cabinClass"].forEach((element) {
      tempCabinClasses.add(mapCabinClass(element));
    });
  }

  if(payload["recommends"] != null){
    payload["recommends"].forEach((element) {
      tempRecommendedPackages.add(mapRecommendedPackage(element));
    });
  }

  if(payload["popularDestinations"] != null){
    payload["popularDestinations"].forEach((element) {
      tempPopularDestinations.add(mapPopularDestination(element));
    });
  }

  if(payload["travelStories"] != null){
    payload["travelStories"].forEach((element) {
      tempTravelStories.add(mapTravelStory(element));
    });
  }


  return ExploreData(
    cabinClasses :tempCabinClasses,
    recommendedPackages :tempRecommendedPackages,
    popularDestinations :tempPopularDestinations,
    travelStories :tempTravelStories,
    quickSearch: quickSearch
  );
}
