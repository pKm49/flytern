import 'package:flytern/feature-modules/package_booking/data/models/package_data.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_details.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_response.dart';
import 'package:flytern/feature-modules/package_booking/services/http-services/package_booking_http_services.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:get/get.dart';

class PackageBookingController extends GetxController {

  var isPackagesLoading = false.obs;
  var isInitialDataLoading = true.obs;
  var isDetailsDataLoading = true.obs;
  var packageBookingHttpService = PackageBookingHttpService();

  var selectedDestination = "".obs;
  var selectedPackage = "".obs;
  var packages = <PackageData>[].obs;
  var destinations = <Country>[].obs;
  var packageDetails = getDefaultPackageDetails().obs;
  var pageId = 1.obs;
  var countryisocode = "ALL".obs;

  @override
  void onInit() {
    super.onInit();
    getInitialInfo();
  }

  Future<void> getInitialInfo() async {
    getPackages(1,"ALL");
  }

  Future<void> getPackages(int newPageId, String newCountryisocode) async {
    isInitialDataLoading.value = true;

    pageId.value = newPageId;
    countryisocode.value = newCountryisocode;

    PackageResponse? packageResponse = await packageBookingHttpService.getPackages(newPageId,newCountryisocode);

    if (packageResponse != null) {
      packages.value = packageResponse.packages;
      if(newCountryisocode == "ALL"){
        destinations.value = packageResponse.destinations;
      }
    }
    isInitialDataLoading.value = false;
  }

  Future<void> getPackageDetails(int refId) async {

    isDetailsDataLoading.value = true;
    PackageDetails? tempPackageDetails = await packageBookingHttpService.getPackageDetails(66);
    if (tempPackageDetails != null) {
      packageDetails.value = tempPackageDetails;
    }
    isDetailsDataLoading.value = false;

  }

}
