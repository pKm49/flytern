import 'package:flytern/feature-modules/flight_booking/data/constants/app_specific/flight_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/shared/data/constants/app_specific/shared_http_request_endpoints.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/app_specific/set_device_info_request_body.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class FlightBookingHttpService {

  Future<ExploreData?> getInitialInfo( ) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetInitalInfo, null);

    if(response.success){
      if(response.data != null){
        ExploreData exploreData = mapExploreData(response.data);
        return exploreData;
      }
    }

    return null;
  }

  Future<List<FlightDestination>> getFlightDestinations(String searchQuery ) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetDestinations+searchQuery, null);
    List<FlightDestination> flightDestinations =[];
    if(response.success){
      if(response.data != null){
        for(var i =0; i<response.data.length;i++) {
          flightDestinations.add(mapFlightDestination(response.data[i]));
        }
      }
    }

    return flightDestinations;
  }

}
