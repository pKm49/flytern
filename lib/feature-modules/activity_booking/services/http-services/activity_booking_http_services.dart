import 'package:flytern/feature-modules/activity_booking/data/constants/app_specific/activity_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_details.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_filter_body.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_response.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_submission_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/destination_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/constants/app_specific/flight_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/constants/app_specific/package_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_details.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_response.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_submission_data.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class ActivityBookingHttpService {

  Future<DestinationResponse> getDestinations(int pageid,
      String countryisocode) async {
    FlyternHttpResponse response =
    await getRequest(ActivityBookingHttpRequestEndpointGetCities, {
      "pageid": pageid,
      "countryisocode": countryisocode
    });

    if (response.success) {
      if (response.data != null) {
        DestinationResponse destinationResponse = mapDestinationResponse(
            response.data);
        return destinationResponse;
      }
    }

    return mapDestinationResponse({});
  }


  Future<ActivityResponse> getActivities(String cityId) async {
    FlyternHttpResponse response =
    await getRequest(ActivityBookingHttpRequestEndpointGetActivities, {
      "cityId": cityId
    });


    List<ActivityData> activities = [];
    int objectID = -1;
    List<RangeDcs> priceDcs = [];
    List<SortingDcs> sortingDcs = [];
    List<SortingDcs> tourCategoryDcs = [];
    List<SortingDcs> bestDealsDcs = [];

    if (response.success) {
      if (response.data != null) {
        objectID = response.data["objectID"]??0;
        if (response.data["results"] != null) {
          for (var i = 0; i < response.data["results"].length; i++) {
            activities.add(
                mapActivityData(response.data["results"][i]));
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
            tourCategoryDcs.add(mapSortingDcs(response.data["tourCategoryDcs"][i]));
          }
        }
        if (response.data["bestDealsDcs"] != null) {
          for (var i = 0; i < response.data["bestDealsDcs"].length; i++) {
            bestDealsDcs
                .add(mapSortingDcs(response.data["bestDealsDcs"][i]));
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
        bestDealsDcs: bestDealsDcs
    );
    return activityResponse;

  }

  Future<ActivityResponse> filterActivities(ActivityFilterBody activityFilterBody) async {
    FlyternHttpResponse response =
    await postRequest(ActivityBookingHttpRequestEndpointFilterActivities,activityFilterBody.toJson());

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
            activities.add(
                mapActivityData(response.data["results"][i]));
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
        bestDealsDcs: bestDealsDcs
    );
    return activityResponse;

  }


  Future<ActivityDetails?> getActivityDetails(int refId) async {
    FlyternHttpResponse response =
    await getRequest(
        "$ActivityBookingHttpRequestEndpointGetActivityDetails$refId", null);

    if (response.success) {
      if (response.data != null) {
        ActivityDetails packageDetails = mapActivityDetails(response.data);
        return packageDetails;
      }
    }

    return mapActivityDetails({});
  }

  Future<String> setUserData(
      ActivitySubmissionData packageSubmissionData) async {
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
  }

}
