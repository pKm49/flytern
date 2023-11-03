import 'package:flytern/feature-modules/flight_booking/data/constants/app_specific/flight_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_details.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_filter_body.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_pretraveller_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_traveller_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/range_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/shared/data/constants/app_specific/shared_http_request_endpoints.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/app_specific/set_device_info_request_body.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class FlightBookingHttpService {
  Future<ExploreData?> getInitialInfo() async {
    FlyternHttpResponse response =
    await getRequest(FlightBookingHttpRequestEndpointGetInitalInfo, null);

    if (response.success) {
      if (response.data != null) {
        ExploreData exploreData = mapExploreData(response.data);
        return exploreData;
      }
    }

    return null;
  }

  Future<List<FlightDestination>> getFlightDestinations(
      String searchQuery) async {
    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetDestinations,
        {"search": searchQuery});
    List<FlightDestination> flightDestinations = [];
    if (response.success) {
      if (response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          flightDestinations.add(mapFlightDestination(response.data[i]));
        }
        flightDestinations.sort((a, b) => a.sort.compareTo(b.sort));
      }
    }

    return flightDestinations;
  }

  Future<FlightSearchResult> getFlightSearchResults(
      FlightSearchData flightSearchData) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSearchFlights,
        flightSearchData.toJson());

    List<FlightSearchResponse> searchResponses = [];
    List<SortingDcs> sortingDcs = [];
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> airlineDcs = [];
    List<SortingDcs> departureTimeDcs = [];
    List<SortingDcs> arrivalTimeDcs = [];
    List<SortingDcs> stopDcs = [];

    if (response.success) {
      if (response.data != null  ) {
        if (  response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapFlightSearchResponse(response.data["searchResponses"][i]));
          }
        }
        if (  response.data["sortingDcs"] != null) {
          for (var i = 0; i < response.data["sortingDcs"].length; i++) {
            sortingDcs.add(
                mapSortingDcs(response.data["sortingDcs"][i]));
          }
        }
        if (  response.data["priceDcs"] != null) {
          for (var i = 0; i < response.data["priceDcs"].length; i++) {
            priceDcs.add(
                mapRangeDcs(response.data["priceDcs"][i]));
          }
        }
        if (  response.data["airlineDcs"] != null) {
          for (var i = 0; i < response.data["airlineDcs"].length; i++) {
            airlineDcs.add(
                mapSortingDcs(response.data["airlineDcs"][i]));
          }
        }
        if (  response.data["departureTimeDcs"] != null) {
          for (var i = 0; i < response.data["departureTimeDcs"].length; i++) {
            departureTimeDcs.add(
                mapSortingDcs(response.data["departureTimeDcs"][i]));
          }
        }
        if (  response.data["arrivalTimeDcs"] != null) {
          for (var i = 0; i < response.data["arrivalTimeDcs"].length; i++) {
            arrivalTimeDcs.add(
                mapSortingDcs(response.data["arrivalTimeDcs"][i]));
          }
        }
        if (  response.data["stopDcs"] != null) {
          for (var i = 0; i < response.data["stopDcs"].length; i++) {
            stopDcs.add(
                mapSortingDcs(response.data["stopDcs"][i]));
          }
        }

      }
    }

    FlightSearchResult flightSearchResult = FlightSearchResult(
        searchResponses: searchResponses,
        priceDcs: priceDcs,
        sortingDcs: sortingDcs,
        airlineDcs: airlineDcs,
        departureTimeDcs: departureTimeDcs,
        arrivalTimeDcs: arrivalTimeDcs,
        stopDcs: stopDcs
    );

    return flightSearchResult;
  }


  Future<List<FlightSearchResponse>> getFlightSearchResultsFiltered(
      FlightFilterBody flightFilterBody) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointFilterFlights,
        flightFilterBody.toJson());

    List<FlightSearchResponse> searchResponses = [];
    if (response.success && response.statusCode==200) {
      if (response.data != null  ) {
        if (  response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapFlightSearchResponse(response.data["searchResponses"][i]));
          }
        }

      }
    }

    return searchResponses;
  }

  Future<FlightSearchResult> getMoreOptions(
      int index, int objectId) async {

    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetMoreOptionFlights,
        {
          "objectID":objectId,
          "index": index
        });

    List<FlightSearchResponse> searchResponses = [];

    if (response.success) {
      if (response.data != null  ) {
        if (  response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapFlightSearchResponse(response.data["searchResponses"][i]));
          }
        }


      }
    }

    FlightSearchResult flightSearchResult = FlightSearchResult(
        searchResponses: searchResponses,
        priceDcs: [],
        sortingDcs: [],
        airlineDcs: [],
        departureTimeDcs:[],
        arrivalTimeDcs: [],
        stopDcs: []
    );

    return flightSearchResult;
  }

  Future<FlightDetails> getFlightDetails(
      int index, int objectId) async {

    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetDetailFlights,
        {
          "objectID":objectId,
          "index": index
        });

    FlightDetails flightDetails;

    if (response.success && response.statusCode ==200) {
      if (response.data != null  ) {
        flightDetails = mapFlightDetails(response.data);
        return flightDetails;
      }
    }

    return mapFlightDetails({});
  }


  Future<FlightPretravellerData> getPreTravellerData(
      int detailId ) async {

    FlyternHttpResponse response = await getRequest(
        FlightBookingHttpRequestEndpointGetPreTravellerData,
        {
          "detail_id":detailId
        });

    FlightPretravellerData flightPretravellerData;

    if (response.success && response.statusCode ==200) {
      if (response.data != null  ) {
        flightPretravellerData = mapFlightPretravellerData(response.data);
        return flightPretravellerData;
      }
    }

    return mapFlightPretravellerData({});
  }

  Future<String> setTravellerData(
      FlightTravellerData flightTravellerData) async {

    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetSaveTravellerData,
        flightTravellerData.toJson());

    String bookingRef;

    if (response.success && response.statusCode ==200) {
      if (response.data != null  ) {
        bookingRef = response.data["bookingRef"]??"";
        return bookingRef;
      }
    }

    return "";
  }


}
