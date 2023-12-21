import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
  import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
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
 import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';
 import 'package:get/get.dart';

class HotelBookingHttpService {


  Future<List<HotelDestination>> getHotelDestinations(
      String searchQuery) async {
    List<HotelDestination> flightDestinations = [];

    try{

      FlyternHttpResponse response = await getRequest(
          HotelBookingHttpRequestEndpointGetDestinations,
          {"search": searchQuery});
      if (response.success) {
        if (response.data != null) {
          for (var i = 0; i < response.data.length; i++) {
            flightDestinations.add(mapHotelDestination(response.data[i]));
          }
          flightDestinations.sort((a, b) => a.sort.compareTo(b.sort));
        }
      }

      return flightDestinations;
    }catch (e){
      return flightDestinations;
    }

  }

  Future<List<HotelSearchData>> getRecentSearch ( ) async {
    List<HotelSearchData> hotelSearchData = [];

    try{
      FlyternHttpResponse response = await getRequest(
          HotelBookingHttpRequestEndpointGetQuickSearch, null);
      if (response.success) {
        if (response.data != null) {
          for (var i = 0; i < response.data.length; i++) {
            hotelSearchData.add(mapHotelSearchData(response.data[i]));
          }
        }
      }

      return hotelSearchData;
    }catch (e){
      return hotelSearchData;
    }



  }

  Future<HotelSearchResult> getHotelSearchResults(
      HotelSearchData flightSearchData) async {

    List<HotelSearchResponse> searchResponses = [];
    List<SortingDcs> sortingDcs = [];
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> ratingDcs = [];
    List<SortingDcs> locationDcs = [];
    int objectID = -1;
    int totalHotels = 0;
    String alertMsg = "";

    try {
      FlyternHttpResponse response = await postRequest(
          HotelBookingHttpRequestEndpointSearchHotels,
          flightSearchData.toJson());

      if (response.success) {
        if (response.data != null) {
          totalHotels = response.data["totalHotels"] ?? 0;
          objectID = response.data["objectID"] ?? -1;
          alertMsg = response.data["alertMsg"] ?? "";

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

      HotelSearchResult flightSearchResult = HotelSearchResult(
        alertMsg:alertMsg,
        totalHotels:totalHotels,
        objectID: objectID,
        searchResponses: searchResponses,
        priceDcs: priceDcs,
        sortingDcs: sortingDcs,
        ratingDcs: ratingDcs,
        locationDcs: locationDcs,
      );

      return flightSearchResult;
    } catch (e) {
      HotelSearchResult flightSearchResult = HotelSearchResult(
        alertMsg:alertMsg,
        objectID: objectID,
        totalHotels:totalHotels,
        searchResponses: searchResponses,
        priceDcs: priceDcs,
        sortingDcs: sortingDcs,
        ratingDcs: ratingDcs,
        locationDcs: locationDcs,
      );

      return flightSearchResult;
    }


  }

  Future<HotelSearchResult> getHotelSearchResultsFiltered(
      HotelFilterBody flightFilterBody) async {

    List<HotelSearchResponse> searchResponses = [];
    String alertMsg = "";
    int totalHotels = 0;

    try{
      FlyternHttpResponse response = await postRequest(
          HotelBookingHttpRequestEndpointFilterHotels, flightFilterBody.toJson());

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          alertMsg = response.data["alertMsg"] ?? "";
          totalHotels = response.data["totalHotels"] ?? 0;

          if (response.data["_lst"] != null) {
            for (var i = 0; i < response.data["_lst"].length; i++) {
              searchResponses.add(
                  mapHotelSearchResponse(response.data["_lst"][i]));
            }
          }
        }
      }

      return HotelSearchResult(
        alertMsg:alertMsg,
        objectID: -1,
        totalHotels:totalHotels,
        searchResponses: searchResponses,
        priceDcs: [],
        sortingDcs: [],
        ratingDcs: [],
        locationDcs: [],
      );
    }catch (e){
      return HotelSearchResult(
        alertMsg:alertMsg,
        objectID: -1,
        totalHotels:totalHotels,
        searchResponses: searchResponses,
        priceDcs: [],
        sortingDcs: [],
        ratingDcs: [],
        locationDcs: [],
      );
    }


  }

  Future<HotelDetails> getHotelDetails(int hotelid, int objectId) async {

    try{
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

      throw response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr;

    }catch (e){

      rethrow;
    }

  }

  Future<HotelPretravellerData> getPreTravellerData( int objectId,int hotelId ) async {

    try{
      FlyternHttpResponse response = await getRequest(
          HotelBookingHttpRequestEndpointGetPreTravellerData, {"objectId":objectId,"hotelId":hotelId});

      HotelPretravellerData flightPretravellerData;

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          flightPretravellerData = mapHotelPretravellerData(response.data);
          return flightPretravellerData;
        }
      }

      return mapHotelPretravellerData({});
    }catch (e){
      return mapHotelPretravellerData({});
    }

  }

  Future<String> setTravellerData(
      HotelTravellerData flightTravellerData) async {
    try{
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
    }catch (e){
      return "";
    }

  }


  Future<GetGatewayData> getPaymentGateways(String bookingRef) async {

    List<PaymentGateway> paymentGateways = [];
    List<BookingInfo>  bookingInfo = [];
    List<String> alertMsg = [];
    FlightDetails flightDetails = mapFlightDetails({});
    HotelDetails hotelDetails = mapHotelDetails({});
    ActivityDetails activityDetails = mapActivityDetails({},[]);

    try{
      FlyternHttpResponse response = await postRequest(
          HotelBookingHttpRequestEndpointGetGateways, {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isGateway"]) {
            response.data["_gatewaylist"].forEach((element) {
              if(element !=null){
                paymentGateways.add(mapPaymentGateway(element));
              }

            });
          }

          if (response.data["_hotelservice"] != null) {
            hotelDetails = mapHotelDetails(
                response.data["_hotelservice"] );
          }
          if (response.data["alertMsg"]!=null) {
            response.data["alertMsg"].forEach((element) {
              if(element !=null){
                alertMsg.add(element);
              }

            });
          }

          if (response.data["_bookingInfo"]!=null) {
            response.data["_bookingInfo"].forEach((element) {
              if(element !=null){
                bookingInfo.add(mapBookingInfo(element));
              }

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
    }catch (e){
      return GetGatewayData(
          hotelDetails:hotelDetails,
          activityDetails: activityDetails,
          paymentGateways: paymentGateways,
          alert: alertMsg,
          bookingInfo: bookingInfo,
          flightDetails: flightDetails);
    }


  }

  Future<bool> checkGatewayStatus(String bookingRef) async {

    try{

      FlyternHttpResponse response = await postRequest(
          HotelBookingHttpRequestEndpointCheckGatewayStatus,
          {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isSuccess"] != null) {
            return response.data["isSuccess"];
          }
        }
      }

      return false;
    }catch (e){
      return false;
    }
  }

  Future<PaymentConfirmationData> getConfirmationData(String bookingRef) async {

    try{
      FlyternHttpResponse response = await postRequest(
          HotelBookingHttpRequestEndpointConfirmation,
          {"bookingRef": bookingRef});

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          PaymentConfirmationData paymentConfirmationData =
          mapPaymentpdfLinkData(response.data,true);
          return paymentConfirmationData;
        }
      }

      return mapPaymentpdfLinkData({},false);
    }catch (e){
      return mapPaymentpdfLinkData({},false);
    }

  }

  Future<PaymentGatewayUrlData> setPaymentGateway(
      String processID, String paymentCode, String bookingRef) async {

    try{
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
    }catch (e){
      return mapPaymentGatewayUrlData({});
    }

  }

  Future<List<RecommendedPackage>> getRecommended(int pageId) async {

    try{

      FlyternHttpResponse response = await getRequest(
          HotelBookingHttpRequestEndpointGetViewAllRecommeded,
          {"pageid": pageId.toString()});
      List<RecommendedPackage> recommendedPackages = [];
      if (response.success) {
        if (response.data != null) {
          if (response.data["records"] != null) {
            response.data["records"].forEach((element) {
              if(element !=null){
                recommendedPackages.add(mapRecommendedPackage(element));
              }

            });
            return recommendedPackages;
          }
        }
      }

      return [];
    }catch (e){
      return [];
    }

  }

  Future<List<TravelStory>> getTravelStories(int pageId) async {

    try{
      FlyternHttpResponse response = await getRequest(
          HotelBookingHttpRequestEndpointGetViewAllRecommeded,
          {"pageid": pageId.toString()});
      List<TravelStory> travelStories = [];
      if (response.success) {
        if (response.data != null) {
          if (response.data["records"] != null) {
            response.data["records"].forEach((element) {
              if(element !=null){
                travelStories.add(mapTravelStory(element));
              }

            });
            return travelStories;
          }
        }
      }

      return [];
    }catch (e){
      return [];
    }

  }

  Future<List<PopularDestination>> getPopularDestinations(int pageId) async {

    try{

      FlyternHttpResponse response = await getRequest(
          HotelBookingHttpRequestEndpointGetViewAllRecommeded,
          {"pageid": pageId.toString()});
      List<PopularDestination> popularDestination = [];
      if (response.success) {
        if (response.data != null) {
          if (response.data["records"] != null) {
            response.data["records"].forEach((element) {
              if(element !=null){
                popularDestination.add(mapPopularDestination(element));
              }

            });
            return popularDestination;
          }
        }
      }

      return [];
    }catch (e){
      return [];
    }
  }

}
