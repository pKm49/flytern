import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';

class ExploreData {

  final List<CabinClass> cabinClasses;
  final List<RecommendedPackage> recommendedPackages;
  final List<PopularDestination> popularDestinations;
  final List<TravelStory> travelStories;

  ExploreData({
    required this.cabinClasses,
    required this.recommendedPackages,
    required this.popularDestinations,
    required this.travelStories,
  });

  Map toJson() => {
    'cabinClasses': cabinClasses,
    'recommendedPackages': recommendedPackages,
    'popularDestinations': popularDestinations,
    'travelStories': travelStories,
  };

}

ExploreData mapExploreData(dynamic payload){

  List<CabinClass> tempCabinClasses = [];
  List<RecommendedPackage> tempRecommendedPackages = [];
  List<PopularDestination> tempPopularDestinations = [];
  List<TravelStory> tempTravelStories = [];

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
  );
}
