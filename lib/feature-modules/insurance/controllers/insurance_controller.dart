import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_filter_body.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/range_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper-services/flight_booking_helper_services.dart';
import 'package:flytern/feature-modules/flight_booking/services/http-services/flight_booking_http_services.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_initial_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_get_body.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';
import 'package:flytern/feature-modules/insurance/services/http-services/insurance_booking_http_services.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';

class InsuranceBookingController extends GetxController {
  var isInitialDataLoading = true.obs;
  var isInsurancePriceGetterLoading = false.obs;
  var isInsuranceSaveTravellerLoading = false.obs;

  var insuranceBookingHttpService = InsuranceBookingHttpService();

  var insuranceInitialData = mapInsuranceInitialData({}).obs;
  var insurancePriceData = mapInsurancePriceData({}).obs;

  var bookingRef = "".obs;
  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;
  var covid = "".obs;
  var policyType = "".obs;
  var contributor = 0.obs;
  var son = 0.obs;
  var daughter = 0.obs;
  var spouse = 0.obs;
  var policyPlan = "".obs;
  var policyDuration = "".obs;
  var policyDate = "".obs;

  @override
  void onInit() {
    super.onInit();
    getInitialInfo();
  }

  Future<void> getInitialInfo() async {
    InsuranceInitialData tempInsuranceInitialData =
        await insuranceBookingHttpService.getInitialInfo();
    print("getInitialInfo completed");
    print(tempInsuranceInitialData.lstPolicyHeaderType.length);
    if (tempInsuranceInitialData.lstPolicyHeaderType.isNotEmpty) {
      insuranceInitialData.value = tempInsuranceInitialData;
    }

    isInitialDataLoading.value = false;
  }

  Future<void> getPrice(InsurancePriceGetBody insurancePriceGetBody) async {
    isInsurancePriceGetterLoading.value = true;
    insurancePriceData.value =
        await insuranceBookingHttpService.getPrice(insurancePriceGetBody);
    isInsurancePriceGetterLoading.value = false;
  }

  Future<void> setTravellerData(List<InsuranceTravellerInfo> travelInfo) async {
    if (!isInsuranceSaveTravellerLoading.value) {
      isInsuranceSaveTravellerLoading.value = true;
      String tempBookingRef = "";
      InsuranceTravellerData insuranceTravellerData = InsuranceTravellerData(
          covid: covid.value,
          policyType: policyType.value,
          contributor: contributor.value,
          son: son.value,
          daughter: daughter.value,
          spouse: spouse.value,
          policyPlan: policyPlan.value,
          policyDuration: policyDuration.value,
          policyDate: policyDate.value,
          travellerinfo: travelInfo,
          mobileCntry: mobileCntry.value,
          mobileNumber: mobileNumber.value,
          email: email.value);
      tempBookingRef =
          await insuranceBookingHttpService.setUserData(insuranceTravellerData);
      isInsuranceSaveTravellerLoading.value = false;
      if (tempBookingRef != "") {
        bookingRef.value = tempBookingRef;
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }
}
