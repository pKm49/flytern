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
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
 import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/hotel_booking/data/constants/app_specific/hotel_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_destination.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_details.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_filter_body.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_pretraveller_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_response.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_result.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_traveller_data.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
 import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
 import 'package:flytern/shared/data/models/business_models/payment_confirmation_data.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway_url_data.dart';
import 'package:flytern/shared/data/models/business_models/support_info.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class HotelBookingHttpService {
  Future<ExploreData?> getInitialInfo() async {
    FlyternHttpResponse response =
        await getRequest(HotelBookingHttpRequestEndpointGetInitalInfo, null);

    if (response.success) {
      if (response.data != null) {
        ExploreData exploreData = mapExploreData(response.data);
        return exploreData;
      }
    }

    return null;
  }

  Future<List<HotelDestination>> getHotelDestinations(
      String searchQuery) async {
    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetDestinations,
        {"search": searchQuery});
    List<HotelDestination> flightDestinations = [];
    if (response.success) {
      if (response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          flightDestinations.add(mapHotelDestination(response.data[i]));
        }
        flightDestinations.sort((a, b) => a.sort.compareTo(b.sort));
      }
    }

    return flightDestinations;
  }

  Future<HotelSearchResult> getHotelSearchResults(
      HotelSearchData flightSearchData) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointSearchHotels,
        flightSearchData.toJson());

    List<HotelSearchResponse> searchResponses = [];
    List<SortingDcs> sortingDcs = [];
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> airlineDcs = [];
    List<SortingDcs> departureTimeDcs = [];
    List<SortingDcs> arrivalTimeDcs = [];
    List<SortingDcs> stopDcs = [];

    if (response.success) {
      if (response.data != null) {
        if (response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapHotelSearchResponse(response.data["searchResponses"][i]));
          }
        }
        if (response.data["sortingDcs"] != null) {
          for (var i = 0; i < response.data["sortingDcs"].length; i++) {
            sortingDcs.add(mapSortingDcs(response.data["sortingDcs"][i]));
          }
        }
        if (response.data["priceDcs"] != null) {
          for (var i = 0; i < response.data["priceDcs"].length; i++) {
            priceDcs.add(mapRangeDcs(response.data["priceDcs"][i]));
          }
        }
        if (response.data["airlineDcs"] != null) {
          for (var i = 0; i < response.data["airlineDcs"].length; i++) {
            airlineDcs.add(mapSortingDcs(response.data["airlineDcs"][i]));
          }
        }
        if (response.data["departureTimeDcs"] != null) {
          for (var i = 0; i < response.data["departureTimeDcs"].length; i++) {
            departureTimeDcs
                .add(mapSortingDcs(response.data["departureTimeDcs"][i]));
          }
        }
        if (response.data["arrivalTimeDcs"] != null) {
          for (var i = 0; i < response.data["arrivalTimeDcs"].length; i++) {
            arrivalTimeDcs
                .add(mapSortingDcs(response.data["arrivalTimeDcs"][i]));
          }
        }
        if (response.data["stopDcs"] != null) {
          for (var i = 0; i < response.data["stopDcs"].length; i++) {
            stopDcs.add(mapSortingDcs(response.data["stopDcs"][i]));
          }
        }
      }
    }

    HotelSearchResult flightSearchResult = HotelSearchResult(
        searchResponses: searchResponses,
        priceDcs: priceDcs,
        sortingDcs: sortingDcs,
        airlineDcs: airlineDcs,
        departureTimeDcs: departureTimeDcs,
        arrivalTimeDcs: arrivalTimeDcs,
        stopDcs: stopDcs);

    return flightSearchResult;
  }

  Future<List<HotelSearchResponse>> getHotelSearchResultsFiltered(
      HotelFilterBody flightFilterBody) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointFilterHotels,
        flightFilterBody.toJson());

    List<HotelSearchResponse> searchResponses = [];
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapHotelSearchResponse(response.data["searchResponses"][i]));
          }
        }
      }
    }

    return searchResponses;
  }

  Future<HotelSearchResult> getMoreOptions(int index, int objectId) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointGetMoreOptionHotels,
        {"objectID": objectId, "index": index});

    List<HotelSearchResponse> searchResponses = [];

    if (response.success) {
      if (response.data != null) {
        if (response.data["searchResponses"] != null) {
          for (var i = 0; i < response.data["searchResponses"].length; i++) {
            searchResponses.add(
                mapHotelSearchResponse(response.data["searchResponses"][i]));
          }
        }
      }
    }

    HotelSearchResult flightSearchResult = HotelSearchResult(
        searchResponses: searchResponses,
        priceDcs: [],
        sortingDcs: [],
        airlineDcs: [],
        departureTimeDcs: [],
        arrivalTimeDcs: [],
        stopDcs: []);

    return flightSearchResult;
  }

  Future<HotelDetails> getHotelDetails(int index, int objectId) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointGetDetailHotels,
        {"objectID": objectId, "index": index});

    HotelDetails flightDetails;

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        flightDetails = mapHotelDetails(response.data);
        return flightDetails;
      }
    }

    return mapHotelDetails({});
  }

  Future<HotelPretravellerData> getPreTravellerData(int detailId) async {
    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetPreTravellerData,
        {"detail_id": detailId});

    HotelPretravellerData flightPretravellerData;

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        flightPretravellerData = mapHotelPretravellerData(response.data);
        return flightPretravellerData;
      }
    }

    return mapHotelPretravellerData({});
  }

  Future<String> setTravellerData(
      HotelTravellerData flightTravellerData) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointGetSaveTravellerData,
        flightTravellerData.toJson());

    String bookingRef;

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        bookingRef = response.data["bookingRef"] ?? "";
        return bookingRef;
      }
    }

    return "";
  }

  Future<List<PaymentGateway>> getPaymentGateways(
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointGetGateways,
        {
          "bookingRef": bookingRef
        });

    List<PaymentGateway> paymentGateways = [];

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isGateway"]) {
          response.data["_gatewaylist"].forEach((element) {
            paymentGateways.add(mapPaymentGateway(element));
          });
          return paymentGateways;
        }
      }
    }

    return [];
  }

  Future<bool> checkGatewayStatus(
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointCheckGatewayStatus,
        {
          "bookingRef": bookingRef
        });

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isSuccess"] !=null) {
          return response.data["isSuccess"];
        }
      }
    }

    return false;
  }

  Future<PaymentConfirmationData> getConfirmationData(
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointConfirmation,
        {
          "bookingRef": bookingRef
        });

    print("getConfirmationData");
    print(response.data["isIssued"]);
    print(response.data["pdfLink"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentConfirmationData paymentConfirmationData = mapPaymentpdfLinkData(response.data);
        return paymentConfirmationData;
      }
    }

    return mapPaymentpdfLinkData({});
  }


  Future<PaymentGatewayUrlData> setPaymentGateway(String processID,
      String paymentCode,
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointSetGateway,
        {
          "processID": processID,
          "paymentCode": paymentCode,
          "bookingRef": bookingRef
        });

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentGatewayUrlData paymentGatewayUrlData = mapPaymentGatewayUrlData(response.data);
        return paymentGatewayUrlData;
      }
    }

    return mapPaymentGatewayUrlData({});
  }

  Future<List<RecommendedPackage>> getRecommended(int pageId) async {
    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetViewAllRecommeded,
        {"pageid": pageId.toString()});
    List<RecommendedPackage> recommendedPackages = [];
    if (response.success) {
      if (response.data != null) {
        if (response.data["records"] != null) {
          response.data["records"].forEach((element) {
            recommendedPackages.add(mapRecommendedPackage(element));
          });
          return recommendedPackages;
        }
      }
    }

    return [];
  }

  Future<List<TravelStory>> getTravelStories(int pageId) async {
    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetViewAllRecommeded,
        {"pageid": pageId.toString()});
    List<TravelStory> travelStories = [];
    if (response.success) {
      if (response.data != null) {
        if (response.data["records"] != null) {
          response.data["records"].forEach((element) {
            travelStories.add(mapTravelStory(element));
          });
          return travelStories;
        }
      }
    }

    return [];
  }

  Future<List<PopularDestination>> getPopularDestinations(int pageId) async {
    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetViewAllRecommeded,
        {"pageid": pageId.toString()});
    List<PopularDestination> popularDestination = [];
    if (response.success) {
      if (response.data != null) {
        if (response.data["records"] != null) {
          response.data["records"].forEach((element) {
            popularDestination.add(mapPopularDestination(element));
          });
          return popularDestination;
        }
      }
    }

    return [];
  }
}