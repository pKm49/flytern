import 'package:flytern/feature-modules/flight_booking/constants/http_request_endpoint.flight_booking.constant.dart';
import 'package:flytern/feature-modules/packages/constants/http_request_endpoints.packages.constant.dart';
import 'package:flytern/feature-modules/packages/models/details.packages.model.dart';
import 'package:flytern/feature-modules/packages/models/response.packages.model.dart';
import 'package:flytern/feature-modules/packages/models/submission_data.packages.model.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

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