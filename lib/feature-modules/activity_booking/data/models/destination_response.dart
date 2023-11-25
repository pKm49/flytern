import 'package:flytern/feature-modules/activity_booking/data/models/activity_city.dart';
import 'package:flytern/shared-module/data/models/business_models/country.dart';

class DestinationResponse {

  final List<ActivityCity> cities;
  final List<Country> destinations;


  DestinationResponse({
    required this.cities,
    required this.destinations
  });

}

DestinationResponse mapDestinationResponse(dynamic payload){

  List<ActivityCity> cities = [];
  List<Country> destinations = [];

  if(payload["activitityCities"] != null){
    payload["activitityCities"].forEach((element) {
      cities.add(mapActivityCity(element));
    });
  }

  if(payload["destinations"] != null){
    payload["destinations"].forEach((element) {
      destinations.add(mapCountry(element));
    });
  }

  return DestinationResponse(
    cities :cities,
    destinations :destinations
  );

}
