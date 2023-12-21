import 'package:flytern/feature-modules/flight_booking/models/cabin_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_data.flight_booking.model.dart';
 import 'package:flytern/feature-modules/flight_booking/models/popular_destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/recommended_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/travel_story.flight_booking.model.dart';


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
        if(element !=null){
          quickSearch.add(mapFlightSearchData(element));
        }
      });
    }

    if(payload["cabinClass"] != null){
      payload["cabinClass"].forEach((element) {
        if(element !=null){
          tempCabinClasses.add(mapCabinClass(element));
        }

      });
    }

    if(payload["recommends"] != null){
      payload["recommends"].forEach((element) {
        if(element !=null){
          tempRecommendedPackages.add(mapRecommendedPackage(element));
        }
      });
    }

    if(payload["popularDestinations"] != null){
      payload["popularDestinations"].forEach((element) {
        if(element !=null){
          tempPopularDestinations.add(mapPopularDestination(element));
        }
      });
    }

    if(payload["travelStories"] != null){
      payload["travelStories"].forEach((element) {
        if(element !=null){
          tempTravelStories.add(mapTravelStory(element));
        }
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
