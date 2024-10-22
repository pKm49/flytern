 import 'package:flytern/feature-modules/packages/constants/http_request_endpoints.packages.constant.dart';
import 'package:flytern/feature-modules/packages/models/details.packages.model.dart';
import 'package:flytern/feature-modules/packages/models/response.packages.model.dart';
import 'package:flytern/feature-modules/packages/models/submission_data.packages.model.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';
import 'package:get/get.dart';

class PackageBookingHttpService {

  Future<PackageResponse?> getPackages(int pageid, String countryisocode) async {

    try{

      FlyternHttpResponse response =
      await getRequest(PackageBookingHttpRequestEndpointGetPackages, {
        "pageid":pageid.toString(),
        "countryisocode":countryisocode
      });

      if (response.success) {
        if (response.data != null) {
          PackageResponse packageResponse = mapPackageResponse(response.data);
          return packageResponse;
        }
      }

      return mapPackageResponse({});
    }catch (e){
      return mapPackageResponse({});
    }

  }

  Future<PackageDetails?> getPackageDetails(int refId) async {

    try{

      FlyternHttpResponse response =
      await getRequest("$PackageBookingHttpRequestEndpointGetPackageDetails$refId",null);

      if (response.success) {
        if (response.data != null) {
          PackageDetails packageDetails = mapPackageDetails(response.data);
          return packageDetails;
        }
      }
      throw response.errors.isNotEmpty?response.errors[0]:"something_went_wrong".tr;

     }catch (e){
      rethrow;
    }
  }

  Future<String> setUserData(PackageSubmissionData packageSubmissionData) async {

    try{

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
    }catch (e){
      return "";
    }
  }

}
