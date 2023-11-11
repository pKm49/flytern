import 'package:flytern/feature-modules/activity_booking/data/constants/app_specific/activity_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_details.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_details_response.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_filter_body.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_option.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_price_fetch_body.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_response.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_submission_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_timing_option.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_transfer_type.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/destination_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/constants/app_specific/flight_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/constants/app_specific/package_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_details.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_response.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_submission_data.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/business_models/payment_confirmation_data.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway.dart';
import 'package:flytern/shared/data/models/business_models/payment_gateway_url_data.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';
import 'package:get/get.dart';

class ActivityBookingHttpService {

  Future<DestinationResponse> getDestinations(
      int pageid, String countryisocode) async {
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
  }

  Future<ActivityResponse> getActivities(String cityId) async {
    FlyternHttpResponse response = await getRequest(
        ActivityBookingHttpRequestEndpointGetActivities, {"cityId": cityId});

    List<ActivityData> activities = [];
    int objectID = -1;
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> sortingDcs = [];
    List<SortingDcs> tourCategoryDcs = [];
    List<SortingDcs> bestDealsDcs = [];

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
  }

  Future<ActivityResponse> filterActivities(
      ActivityFilterBody activityFilterBody) async {
    FlyternHttpResponse response = await postRequest(
        ActivityBookingHttpRequestEndpointFilterActivities,
        activityFilterBody.toJson());

    List<ActivityData> activities = [];
    int objectID = -1;
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> sortingDcs = [];
    List<SortingDcs> tourCategoryDcs = [];
    List<SortingDcs> bestDealsDcs = [];

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
  }

  Future<ActivityDetailsResponse > getActivityDetails(int objectId,int tourid) async {
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
            activityOptions.add(mapActivityOption(element));
          });
        }

        if (response.data["_eventtransfertypes"] != null) {
          response.data["_eventtransfertypes"].forEach((element) {
            activityTransferTypes.add(mapActivityTransferType(element));
          });
        }
        print("activityTransferTypes");
        print(activityTransferTypes.length);
        return ActivityDetailsResponse(
            activityDetails: activityDetails,
            activityOptions: activityOptions,
            activityTransferTypes: activityTransferTypes);
      }
    }

    return getDefaultActivityDetailsResponse();
  }

  Future<ActivityTransferType > getActivityPriceInfo(ActivityPriceFetchBody activityPriceFetchBody) async {
    FlyternHttpResponse response = await postRequest(
        "$ActivityBookingHttpRequestEndpointGetActivityPriceDetails",activityPriceFetchBody.toJson());


    if (response.success) {
      if (response.data != null) {
        ActivityTransferType activityTransferType = mapActivityTransferType(
            response.data  );

        print("activityTransferTypes");
        print(activityTransferType.currency);
        print(activityTransferType.finalAmount);
        return activityTransferType ;
      }
    }

    return mapActivityTransferType({});
  }

  Future<List<ActivityTimingOption> > getActivityTimingList(ActivityPriceFetchBody activityPriceFetchBody) async {
    FlyternHttpResponse response = await postRequest(
        "$ActivityBookingHttpRequestEndpointGetActivityTimingSelection",activityPriceFetchBody.toOptionTimingJson());

    List<ActivityTimingOption> activityTimingOptions = [];

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
  }

  Future<String > confirmActivity(ActivityPriceFetchBody activityPriceFetchBody) async {
    FlyternHttpResponse response = await postRequest(
        "$ActivityBookingHttpRequestEndpointGetActivityConfirmEvent",activityPriceFetchBody.toActivityConfirmJson());


    if (response.success) {
      if (response.data != null) {

        print("confirmActivity");
        print(response.data["status"]);
        print(response.data["message"]);
        if(response.data["status"]==true){
          return "";
        }else{
          return response.data["message"];
        }
      }
    }

    return "something_went_wrong".tr;
  }

  Future<String> setUserData(
      ActivitySubmissionData packageSubmissionData) async {
    FlyternHttpResponse response = await postRequest(
        ActivityBookingHttpRequestEndpointSaveActivityDetails,
        packageSubmissionData.toJson());

    String bookingRef;
    print("setUserData bookingRef");


    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        bookingRef = response.data["bookingRef"] ?? "";
        print("bookingRef");
        print(bookingRef);
        return bookingRef;
      }
    }

    return "";
  }


  Future<List<PaymentGateway>> getPaymentGateways(
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        FlightBookingHttpRequestEndpointGetGateways,
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
        FlightBookingHttpRequestEndpointCheckGatewayStatus,
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
        FlightBookingHttpRequestEndpointConfirmation,
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
  }

}
