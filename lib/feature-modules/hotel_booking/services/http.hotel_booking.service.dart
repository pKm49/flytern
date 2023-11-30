import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/constants/http_request_endpoint.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/explore_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/filter_body.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/pretraveller_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_response.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_result.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/traveller_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/popular_destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/recommended_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/constants/http_request_endpoints.hotel_booking.constant.dart';
import 'package:flytern/feature-modules/hotel_booking/models/destination.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/filter_body.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/pretraveller_data.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_data.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_result.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/traveller_data.hotel_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/models/travel_story.flight_booking.model.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/models/support_info.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

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


  Future<List<HotelSearchData>> getRecentSearch ( ) async {

    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetQuickSearch, null);
    List<HotelSearchData> hotelSearchData = [];
    if (response.success) {
      if (response.data != null) {
        for (var i = 0; i < response.data.length; i++) {
          hotelSearchData.add(mapHotelSearchData(response.data[i]));
        }
      }
    }

    return hotelSearchData;

  }

  Future<HotelSearchResult> getHotelSearchResults(
      HotelSearchData flightSearchData) async {
    List<HotelSearchResponse> searchResponses = [];
    List<SortingDcs> sortingDcs = [];
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> ratingDcs = [];
    List<SortingDcs> locationDcs = [];
    int objectID = -1;
    try {
      FlyternHttpResponse response = await postRequest(
          HotelBookingHttpRequestEndpointSearchHotels,
          flightSearchData.toJson());

      if (response.success) {
        if (response.data != null) {
          objectID = response.data["objectID"] ?? -1;
          if (response.data["_lst"] != null) {
            for (var i = 0; i < response.data["_lst"].length; i++) {
              searchResponses
                  .add(mapHotelSearchResponse(response.data["_lst"][i]));
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
          if (response.data["ratingDcs"] != null) {
            for (var i = 0; i < response.data["ratingDcs"].length; i++) {
              ratingDcs.add(mapSortingDcs(response.data["ratingDcs"][i]));
            }
          }
          if (response.data["locationDcs"] != null) {
            for (var i = 0; i < response.data["locationDcs"].length; i++) {
              locationDcs.add(mapSortingDcs(response.data["locationDcs"][i]));
            }
          }
        }
      }
    } catch (e) {
      print("errrror");
      print(e);
    }

    HotelSearchResult flightSearchResult = HotelSearchResult(
      objectID: objectID,
      searchResponses: searchResponses,
      priceDcs: priceDcs,
      sortingDcs: sortingDcs,
      ratingDcs: ratingDcs,
      locationDcs: locationDcs,
    );

    return flightSearchResult;
  }

  Future<List<HotelSearchResponse>> getHotelSearchResultsFiltered(
      HotelFilterBody flightFilterBody) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointFilterHotels, flightFilterBody.toJson());

    List<HotelSearchResponse> searchResponses = [];
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["_lst"] != null) {
          for (var i = 0; i < response.data["_lst"].length; i++) {
            searchResponses.add(
                mapHotelSearchResponse(response.data["_lst"][i]));
          }
        }
      }
    }

    return searchResponses;
  }

  Future<HotelDetails> getHotelDetails(int hotelid, int objectId) async {
    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetDetailHotels,
        {"objectID": objectId, "hotelid": hotelid});

    HotelDetails flightDetails;

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        flightDetails = mapHotelDetails(response.data);
        return flightDetails;
      }
    }

    return mapHotelDetails({});
  }

  Future<HotelPretravellerData> getPreTravellerData( ) async {
    FlyternHttpResponse response = await getRequest(
        HotelBookingHttpRequestEndpointGetPreTravellerData,null);

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
  Future<bool> checkSmartPayment(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointSmartPayment,
        {"bookingRef": bookingRef});

    print("getPaymentGateways");
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isSuccess"] != null) {
          return response.data["isSuccess"];
        }
      }
    }

    return false;
  }
  Future<GetGatewayData> getPaymentGateways(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointGetGateways, {"bookingRef": bookingRef});


    List<PaymentGateway> paymentGateways = [];
    List<BookingInfo>  bookingInfo = [];
    List<String> alertMsg = [];
    FlightDetails flightDetails = mapFlightDetails({});
    HotelDetails hotelDetails = mapHotelDetails({});
    ActivityDetails activityDetails = mapActivityDetails({},[]);

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isGateway"]) {
          response.data["_gatewaylist"].forEach((element) {
            paymentGateways.add(mapPaymentGateway(element));
          });
        }

        if (response.data["_hotelservice"] != null) {
          hotelDetails = mapHotelDetails(
              response.data["_hotelservice"] );
          print("flightDetails");
          print(flightDetails.objectId);
        }
        if (response.data["alertMsg"]!=null) {
          response.data["alertMsg"].forEach((element) {
            alertMsg.add(element);
          });
        }

        if (response.data["_bookingInfo"]!=null) {
          response.data["_bookingInfo"].forEach((element) {
            bookingInfo.add(mapBookingInfo(element));
          });
        }
      }
    }

    return GetGatewayData(
        hotelDetails:hotelDetails,
        activityDetails: activityDetails,
        paymentGateways: paymentGateways,
        alert: alertMsg,
        bookingInfo: bookingInfo,
        flightDetails: flightDetails);

  }

  Future<bool> checkGatewayStatus(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointCheckGatewayStatus,
        {"bookingRef": bookingRef});

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isSuccess"] != null) {
          return response.data["isSuccess"];
        }
      }
    }

    return false;
  }

  Future<PaymentConfirmationData> getConfirmationData(String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointConfirmation,
        {"bookingRef": bookingRef});

    print("getConfirmationData");
    print(response.data["isIssued"]);
    print(response.data["pdfLink"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentConfirmationData paymentConfirmationData =
            mapPaymentpdfLinkData(response.data);
        return paymentConfirmationData;
      }
    }

    return mapPaymentpdfLinkData({});
  }

  Future<PaymentGatewayUrlData> setPaymentGateway(
      String processID, String paymentCode, String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        HotelBookingHttpRequestEndpointSetGateway, {
      "processID": processID,
      "paymentCode": paymentCode,
      "bookingRef": bookingRef
    });

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentGatewayUrlData paymentGatewayUrlData =
            mapPaymentGatewayUrlData(response.data);
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
