import 'package:flytern/feature-modules/package_booking/data/models/package_data.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_details.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_response.dart';
import 'package:flytern/feature-modules/package_booking/data/models/package_submission_data.dart';
import 'package:flytern/feature-modules/package_booking/services/http-services/package_booking_http_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';

class PackageBookingController extends GetxController {

  var isPackagesLoading = false.obs;
  var isInitialDataLoading = true.obs;
  var isDetailsDataLoading = true.obs;
  var isSaveContactLoading = true.obs;
  var packageBookingHttpService = PackageBookingHttpService();

  var selectedDestination = "".obs;
  var selectedPackage = "".obs;
  var packages = <PackageData>[].obs;
  var destinations = <Country>[].obs;
  var packageDetails = getDefaultPackageDetails().obs;
  var pageId = 1.obs;
  var packageId = 1.obs;
  var countryisocode = "ALL".obs;
  var bookingRef = "".obs;
  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;

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
    packageId.value = refId;
    PackageDetails? tempPackageDetails = await packageBookingHttpService.getPackageDetails(refId);
    if (tempPackageDetails != null) {
      packageDetails.value = tempPackageDetails;
    }
    isDetailsDataLoading.value = false;

  }

  Future<void> setTravellerData() async {
      isSaveContactLoading.value = true;
      String tempBookingRef = "";
      PackageSubmissionData packageSubmissionData = PackageSubmissionData(
          packageID: packageId.value,
          mobileCntry: mobileCntry.value,
          mobileNumber: mobileNumber.value,
          email: email.value);
      tempBookingRef =
      await packageBookingHttpService.setUserData(packageSubmissionData);
      isSaveContactLoading.value = false;
      if (tempBookingRef != "") {
        bookingRef.value = tempBookingRef;
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }

  }

  void saveContactInfo(String tMobileCntry, String tMobileNumber, String tEmail) {
    mobileCntry.value =tMobileCntry;
    mobileNumber.value =tMobileNumber;
    email.value =tEmail;
    setTravellerData();
  }

  void resetAndNavigateToHome() {

    isPackagesLoading.value = false;
    isInitialDataLoading.value = true;
    isDetailsDataLoading.value = true;
    isSaveContactLoading.value = true;

    selectedDestination.value = "";
    selectedPackage.value = "";
    packages.value = <PackageData>[];
    destinations.value = <Country>[];
    packageDetails.value = getDefaultPackageDetails();
    pageId.value = 1;
    packageId.value = 1;
    countryisocode.value = "ALL";
    bookingRef.value = "";
    mobileCntry.value = "";
    mobileNumber.value = "";
    email.value = "";

     Get.offAllNamed(Approute_landingpage);
  }

}
