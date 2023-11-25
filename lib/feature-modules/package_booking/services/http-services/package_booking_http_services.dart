import 'package:flytern/feature-modules/flight_booking/data/constants/app_specific/flight_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/constants/app_specific/package_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_details.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_response.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_submission_data.dart';
import 'package:flytern/shared-module/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.dart';

class PackageBookingHttpService {

  Future<PackageResponse?> getPackages(int pageid, String countryisocode) async {
    FlyternHttpResponse response =
    await getRequest(PackageBookingHttpRequestEndpointGetPackages, {
      "pageid":pageid,
      "countryisocode":countryisocode
    });

    if (response.success) {
      if (response.data != null) {
        PackageResponse packageResponse = mapPackageResponse(response.data);
        return packageResponse;
      }
    }

    return mapPackageResponse({});
  }

  Future<PackageDetails?> getPackageDetails(int refId) async {
    FlyternHttpResponse response =
    await getRequest("$PackageBookingHttpRequestEndpointGetPackageDetails$refId",null);

    if (response.success) {
      if (response.data != null) {
        PackageDetails packageDetails = mapPackageDetails(response.data);
        return packageDetails;
      }
    }

    return mapPackageDetails({});
  }

  Future<String> setUserData(PackageSubmissionData packageSubmissionData) async {

    FlyternHttpResponse response = await postRequest(
        PackageBookingHttpRequestEndpointSavePackageDetails,
        packageSubmissionData.toJson());

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
