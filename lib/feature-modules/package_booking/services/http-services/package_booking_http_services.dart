import 'package:flytern/feature-modules/flight_booking/data/constants/app_specific/flight_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/constants/app_specific/package_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_details.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_response.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

class PackageBookingHttpService {

  Future<PackageResponse?> getPackages() async {
    FlyternHttpResponse response =
    await getRequest(PackageBookingHttpRequestEndpointGetPackages, null);

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

}
