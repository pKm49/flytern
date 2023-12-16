import 'package:flytern/feature-modules/activity_booking/constants/http_request_endpoints.activity_booking.constant.dart';
import 'package:flytern/feature-modules/activity_booking/models/data.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/details_response.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/filter_body.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/option.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/price_fetch_body.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/response.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/submission_data.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/timing_option.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/transfer_type.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/destination_response.dart';
import 'package:flytern/feature-modules/flight_booking/constants/http_request_endpoint.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';
import 'package:get/get.dart';

class ActivityBookingHttpService {

  Future<DestinationResponse> getDestinations(
      int pageid, String countryisocode) async {

    try{
      FlyternHttpResponse response = await getRequest(
          ActivityBookingHttpRequestEndpointGetCities,
          {"pageid": pageid, "countryisocode": countryisocode});

      if (response.success) {
        if (response.data != null) {
          DestinationResponse destinationResponse =
          mapDestinationResponse(response.data);
          return destinationResponse;
        }
      }

      return mapDestinationResponse({});
    }catch (e){
      return mapDestinationResponse({});

    }

  }

  Future<ActivityResponse> getActivities(String cityId) async {

    List<ActivityData> activities = [];
    int objectID = -1;
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> sortingDcs = [];
    List<SortingDcs> tourCategoryDcs = [];
    List<SortingDcs> bestDealsDcs = [];

    try{
      FlyternHttpResponse response = await getRequest(
          ActivityBookingHttpRequestEndpointGetActivities, {"cityId": cityId});

      if (response.success) {
        if (response.data != null) {
          objectID = response.data["objectID"] ?? 0;
          if (response.data["results"] != null) {
            for (var i = 0; i < response.data["results"].length; i++) {
              activities.add(mapActivityData(response.data["results"][i]));
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
          if (response.data["tourCategoryDcs"] != null) {
            for (var i = 0; i < response.data["tourCategoryDcs"].length; i++) {
              tourCategoryDcs
                  .add(mapSortingDcs(response.data["tourCategoryDcs"][i]));
            }
          }
          if (response.data["bestDealsDcs"] != null) {
            for (var i = 0; i < response.data["bestDealsDcs"].length; i++) {
              bestDealsDcs.add(mapSortingDcs(response.data["bestDealsDcs"][i]));
            }
          }
        }
      }
      ActivityResponse activityResponse = ActivityResponse(
          activities: activities,
          objectID: objectID,
          priceDcs: priceDcs,
          sortingDcs: sortingDcs,
          tourCategoryDcs: tourCategoryDcs,
          bestDealsDcs: bestDealsDcs);
      return activityResponse;
    }catch (e){
      ActivityResponse activityResponse = ActivityResponse(
          activities: activities,
          objectID: objectID,
          priceDcs: priceDcs,
          sortingDcs: sortingDcs,
          tourCategoryDcs: tourCategoryDcs,
          bestDealsDcs: bestDealsDcs);
      return activityResponse;
    }

  }

  Future<ActivityResponse> filterActivities(
      ActivityFilterBody activityFilterBody) async {

    List<ActivityData> activities = [];
    int objectID = -1;
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> sortingDcs = [];
    List<SortingDcs> tourCategoryDcs = [];
    List<SortingDcs> bestDealsDcs = [];

    try{
      FlyternHttpResponse response = await postRequest(
          ActivityBookingHttpRequestEndpointFilterActivities,
          activityFilterBody.toJson());


      if (response.success) {
        if (response.data != null) {
          if (response.data["results"] != null) {
            for (var i = 0; i < response.data["results"].length; i++) {
              activities.add(mapActivityData(response.data["results"][i]));
            }
          }
        }
      }
      ActivityResponse activityResponse = ActivityResponse(
          activities: activities,
          objectID: objectID,
          priceDcs: priceDcs,
          sortingDcs: sortingDcs,
          tourCategoryDcs: tourCategoryDcs,
          bestDealsDcs: bestDealsDcs);
      return activityResponse;
    }catch (e){
      ActivityResponse activityResponse = ActivityResponse(
          activities: activities,
          objectID: objectID,
          priceDcs: priceDcs,
          sortingDcs: sortingDcs,
          tourCategoryDcs: tourCategoryDcs,
          bestDealsDcs: bestDealsDcs);
      return activityResponse;
    }


  }

  Future<ActivityDetailsResponse > getActivityDetails(int objectId,int tourid) async {

    try{
      FlyternHttpResponse response = await getRequest(
          "$ActivityBookingHttpRequestEndpointGetActivityDetails",{
        "objectid":objectId.toString(),
        "tourid":tourid.toString(),
      });

      List<ActivityOption> activityOptions = [];
      List<ActivityTransferType> activityTransferTypes = [];

      if (response.success) {
        if (response.data != null) {
          ActivityDetails activityDetails = mapActivityDetails(
              response.data["_eventdetails"], response.data["_eventimages"]);

          if (response.data["_eventoptions"] != null) {
            response.data["_eventoptions"].forEach((element) {
              if(element !=null){
                activityOptions.add(mapActivityOption(element));
              }

            });
          }

          if (response.data["_eventtransfertypes"] != null) {
            response.data["_eventtransfertypes"].forEach((element) {
              if(element !=null){
                activityTransferTypes.add(mapActivityTransferType(element));
              }

            });
          }

          return ActivityDetailsResponse(
              activityDetails: activityDetails,
              activityOptions: activityOptions,
              activityTransferTypes: activityTransferTypes);
        }
      }

      return getDefaultActivityDetailsResponse();
    }catch (e){
      return getDefaultActivityDetailsResponse();
    }

  }

  Future<ActivityTransferType > getActivityPriceInfo(ActivityPriceFetchBody activityPriceFetchBody) async {

    try{

      FlyternHttpResponse response = await postRequest(
          "$ActivityBookingHttpRequestEndpointGetActivityPriceDetails",activityPriceFetchBody.toJson());


      if (response.success) {
        if (response.data != null) {
          ActivityTransferType activityTransferType = mapActivityTransferType(
              response.data  );

          return activityTransferType ;
        }
      }

      return mapActivityTransferType({});
    }catch (e){
      return mapActivityTransferType({});

    }

  }

  Future<List<ActivityTimingOption> > getActivityTimingList(ActivityPriceFetchBody activityPriceFetchBody) async {

    List<ActivityTimingOption> activityTimingOptions = [];

    try{
      FlyternHttpResponse response = await postRequest(
          "$ActivityBookingHttpRequestEndpointGetActivityTimingSelection",activityPriceFetchBody.toOptionTimingJson());


      if (response.success) {
        if (response.data != null) {

          if (response.data["_lst"] != null) {
            for (var i = 0; i < response.data["_lst"].length; i++) {
              activityTimingOptions.add(mapActivityTimingOption(response.data["_lst"][i]));
            }
          }
        }
      }

      return activityTimingOptions;
    }catch (e){
      return activityTimingOptions;

    }

  }

  Future<String> confirmActivity(ActivityPriceFetchBody activityPriceFetchBody) async {

    try{

      FlyternHttpResponse response = await postRequest(
          "$ActivityBookingHttpRequestEndpointGetActivityConfirmEvent",activityPriceFetchBody.toActivityConfirmJson());


      if (response.success) {
        if (response.data != null) {

          if(response.data["status"]==true){
            return "";
          }else{
            return response.data["message"];
          }
        }
      }

      return "something_went_wrong".tr;
    }catch (e){
      return "something_went_wrong".tr;

    }

  }

  Future<String> setUserData(
      ActivitySubmissionData packageSubmissionData) async {

    try{

      FlyternHttpResponse response = await postRequest(
          ActivityBookingHttpRequestEndpointSaveActivityDetails,
          packageSubmissionData.toJson());

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

  Future<GetGatewayData> getPaymentGateways(
      String bookingRef) async {
    List<PaymentGateway> paymentGateways = [];
    List<BookingInfo>  bookingInfo = [];
    List<String> alertMsg = [];
    FlightDetails flightDetails = mapFlightDetails({});
    HotelDetails hotelDetails = mapHotelDetails({});
    ActivityDetails activityDetails = mapActivityDetails({},[]);
    try{
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointGetGateways,
          {
            "bookingRef": bookingRef
          });



      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isGateway"]) {
            response.data["_gatewaylist"].forEach((element) {
              if(element !=null){
                paymentGateways.add(mapPaymentGateway(element));
              }

            });
          }

          if (response.data["_activityservice"] != null) {
            if (response.data["_activityservice"]["_eventdetails"] != null) {
              activityDetails = mapActivityDetails(
                  response.data["_activityservice"]["_eventdetails"],
                  response.data["_activityservice"]["_eventimages"]??[]
              );
            }
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

  Future<bool> checkGatewayStatus(
      String bookingRef) async {

    try{
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointCheckGatewayStatus,
          {
            "bookingRef": bookingRef
          });

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isSuccess"] !=null) {
            return response.data["isSuccess"];
          }
        }
      }

      return false;
    }catch (e){
      return false;

    }

  }

  Future<PaymentConfirmationData> getConfirmationData(
      String bookingRef) async {

    try{

      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointConfirmation,
          {
            "bookingRef": bookingRef
          });

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          PaymentConfirmationData paymentConfirmationData = mapPaymentpdfLinkData(response.data,true);
          return paymentConfirmationData;
        }
      }

      return mapPaymentpdfLinkData({},false);
    }catch (e){
      return mapPaymentpdfLinkData({},false);
    }
  }

  Future<PaymentGatewayUrlData> setPaymentGateway(String processID,
      String paymentCode,
      String bookingRef) async {

    try{
      FlyternHttpResponse response = await postRequest(
          FlightBookingHttpRequestEndpointSetGateway,
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
    }catch (e){
      return mapPaymentGatewayUrlData({});
    }


  }

}
