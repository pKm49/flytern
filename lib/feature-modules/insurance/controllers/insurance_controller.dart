import 'package:flytern/feature-modules/insurance/data/models/insurance_initial_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_get_body.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';
import 'package:flytern/feature-modules/insurance/services/http-services/insurance_booking_http_services.dart';

import 'package:flytern/shared/services/utility-services/snackbar_shower.dart';
import 'package:get/get.dart';

class InsuranceBookingController extends GetxController {
  var isInitialDataLoading = true.obs;
  var isInsurancePriceGetterLoading = false.obs;
  var isInsuranceSaveTravellerLoading = false.obs;
  var insuranceBookingHttpService = InsuranceBookingHttpService();
  var insuranceInitialData = mapInsuranceInitialData({}).obs;
  var insurancePriceData = mapInsurancePriceData({}).obs;
  var insurancePriceGetBody =mapInsurancePriceGetBody ({}).obs;

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
    isInitialDataLoading.value = true;

    InsuranceInitialData tempInsuranceInitialData =
        await insuranceBookingHttpService.getInitialInfo();

    if (tempInsuranceInitialData.lstPolicyHeaderType.isNotEmpty) {
      insuranceInitialData.value = tempInsuranceInitialData;
      getInitialPrice();
    }

    isInitialDataLoading.value = false;
  }

  Future<void> getPrice(InsurancePriceGetBody tempInsurancePriceGetBody) async {
    isInsurancePriceGetterLoading.value = true;
    insurancePriceGetBody.value = tempInsurancePriceGetBody;
    insurancePriceData.value =
        await insuranceBookingHttpService.getPrice(tempInsurancePriceGetBody);
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

  void getInitialPrice() {
    if(insuranceInitialData.value.lstPolicyHeaderType.isNotEmpty &&
        insuranceInitialData.value.lstPolicyType.isNotEmpty &&
        insuranceInitialData.value.lstPolicyOption.isNotEmpty &&
        insuranceInitialData.value.lstPolicyPeriod.isNotEmpty ){
      getPrice(InsurancePriceGetBody(
          covidtype: insuranceInitialData.value.lstPolicyHeaderType[0].id,
          policyplan: insuranceInitialData.value.lstPolicyOption[0].id,
          policy_type: insuranceInitialData.value.lstPolicyType[0].id,
          policyperiod: insuranceInitialData.value.lstPolicyPeriod[0].id));
    }

  }

  void changePolicyHeader(String? value) {
    getPrice(InsurancePriceGetBody(
        covidtype: value??insurancePriceGetBody.value.covidtype,
        policyplan: insurancePriceGetBody.value.policyplan,
        policy_type: insurancePriceGetBody.value.policy_type,
        policyperiod: insurancePriceGetBody.value.policyperiod));
  }

  void changePolicyPlan(String? value) {
    getPrice(InsurancePriceGetBody(
        covidtype: insurancePriceGetBody.value.covidtype,
        policyplan: value??insurancePriceGetBody.value.policyplan,
        policy_type: insurancePriceGetBody.value.policy_type,
        policyperiod: insurancePriceGetBody.value.policyperiod));
  }


  void changePolicyType(String? value) {
    getPrice(InsurancePriceGetBody(
        covidtype: insurancePriceGetBody.value.covidtype,
        policyplan: insurancePriceGetBody.value.policyplan,
        policy_type: value??insurancePriceGetBody.value.policy_type,
        policyperiod: insurancePriceGetBody.value.policyperiod));
  }

  void changePolicyPeriod(String? value) {
    getPrice(InsurancePriceGetBody(
        covidtype: insurancePriceGetBody.value.covidtype,
        policyplan: insurancePriceGetBody.value.policyplan,
        policy_type: insurancePriceGetBody.value.policy_type,
        policyperiod: value??insurancePriceGetBody.value.policyperiod));
  }

  void updateFamilyMembersCount(int spouseCount, int daughterCount, int sonCount) {
    spouse.value = spouseCount;
    daughter.value = daughterCount;
    son.value = sonCount;
  }


}
