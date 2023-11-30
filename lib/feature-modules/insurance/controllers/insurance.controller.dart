import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/models/initial_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/price_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/get_price_body.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/traveller_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/traveller_info.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/services/http.insurance.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class InsuranceBookingController extends GetxController {

  var isInitialDataLoading = true.obs;
  var isInsurancePriceGetterLoading = false.obs;
  var isInsuranceSaveTravellerLoading = false.obs;
  var isInsuranceSavePaymentGatewayLoading = false.obs;
  var isInsuranceGatewayStatusCheckLoading = false.obs;
  var isInsuranceConfirmationDataLoading = false.obs;

  var insuranceBookingHttpService = InsuranceBookingHttpService();
  var insuranceInitialData = mapInsuranceInitialData({}).obs;
  var insurancePriceData = mapInsurancePriceData({}).obs;
  var insurancePriceGetBody = mapInsurancePriceGetBody({}).obs;

  var bookingRef = "".obs;
  var mobileCntry = "".obs;
  var mobileNumber = "".obs;
  var email = "".obs;

  var policyHeaderObj = GeneralItem(id: '-1', name: '').obs;
  var policyTypeObj = GeneralItem(id: '-1', name: '').obs;
  var policyPeriodObj = GeneralItem(id: '-1', name: '').obs;
  var policyOptionObj = GeneralItem(id: '-1', name: '').obs;

  var contributor = 1.obs;
  var son = 0.obs;
  var daughter = 0.obs;
  var spouse = 0.obs;
  var gatewayUrl = "".obs;
  var pdfLink = "".obs;
  var confirmationMessage = "".obs;
  var confirmationUrl = "".obs;
  var policyDate = DefaultInvalidDate.obs;
  var selectedTravelInfo = <InsuranceTravellerInfo>[].obs;

  var processId = "-1".obs;
  var paymentCode = "".obs;
  var processingFee = (0.0).obs;

  Rx<TextEditingController> policyDateController = TextEditingController().obs;
  var paymentGateways = <PaymentGateway>[].obs;
  var selectedPaymentGateway = mapPaymentGateway({}).obs;

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
      policyDateController.value.text =
          getFormattedDate(insuranceInitialData.value.minPolicyDate);
       policyDate.value = insuranceInitialData.value.minPolicyDate;
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

  void saveTravellersData(List<InsuranceTravellerInfo> travelInfo) {
    String validityString = "";
    for (var i = 0; i < travelInfo.length; i++) {
      print("travelInfo " + i.toString());
      print(travelInfo[i].toJson());
    }
    for (var i = 0; i < travelInfo.length; i++) {
      print("travelInfo " + i.toString());
      print("firstName");
      print(travelInfo[i].firstName);

      if (travelInfo[i].firstName == "") {
        validityString = "enter_firstname_copax"
            .tr
            .replaceAll("user", "  ${getUserId(travelInfo[i], i)}");

        break;
      }
      print("lastName");
      print(travelInfo[i].lastName);
      if (travelInfo[i].lastName == "") {
        validityString = "enter_lastname_copax"
            .tr
            .replaceAll("user", "${getUserId(travelInfo[i], i)} ");

        break;
      }
      print("dateOfBirth");
      print(travelInfo[i].dateOfBirth);
      print(DefaultInvalidDate);

      if (travelInfo[i].dateOfBirth == DefaultInvalidDate) {
        validityString = "enter_dob_copax"
            .tr
            .replaceAll("user", "${getUserId(travelInfo[i], i)}  ");

        break;
      }
      print(travelInfo[i].nationalityCode);

      if (travelInfo[i].nationalityCode == "") {
        validityString = "enter_nationality_copax"
            .tr
            .replaceAll("user", "${getUserId(travelInfo[i], i)} ");

        break;
      }
      print("civilID");
      print(travelInfo[i].civilID);
      if (travelInfo[i].civilID == "") {
        validityString = "enter_civilid_copax"
            .tr
            .replaceAll("user", "${getUserId(travelInfo[i], i)}  ");

        break;
      }
    }

    if (validityString != "") {
      showSnackbar(Get.context!, validityString, "error");
    } else {
      setTravellerData(travelInfo);
    }

    // Get.toNamed(Approute_flightsSummary);
  }

  Future<void> setTravellerData(List<InsuranceTravellerInfo> travelInfo) async {
    if (!isInsuranceSaveTravellerLoading.value) {
      isInsuranceSaveTravellerLoading.value = true;
      selectedTravelInfo.value = travelInfo;
      String tempBookingRef = "";
      print("setTravellerData");

      print(policyDate.value);
      InsuranceTravellerData insuranceTravellerData = InsuranceTravellerData(
          covid: policyHeaderObj.value.id,
          policyType: policyTypeObj.value.id,
          contributor: contributor.value,
          son: son.value,
          daughter: daughter.value,
          spouse: spouse.value,
          policyPlan: policyOptionObj.value.id,
          policyDuration:policyPeriodObj.value.id,
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
        getPaymentGateways();
      } else {
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      }
    }
  }

  void getInitialPrice() {
    if (insuranceInitialData.value.lstPolicyHeaderType.isNotEmpty &&
        insuranceInitialData.value.lstPolicyType.isNotEmpty &&
        insuranceInitialData.value.lstPolicyOption.isNotEmpty &&
        insuranceInitialData.value.lstPolicyPeriod.isNotEmpty) {
      policyHeaderObj.value = insuranceInitialData.value.lstPolicyHeaderType[0];
      policyOptionObj.value = insuranceInitialData.value.lstPolicyOption[0];
      policyTypeObj.value = insuranceInitialData.value.lstPolicyType[0];
      policyPeriodObj.value = insuranceInitialData.value.lstPolicyPeriod[0];
      getPrice(InsurancePriceGetBody(
          covidtype: insuranceInitialData.value.lstPolicyHeaderType[0].id,
          policyplan: insuranceInitialData.value.lstPolicyOption[0].id,
          policy_type: insuranceInitialData.value.lstPolicyType[0].id,
          policyperiod: insuranceInitialData.value.lstPolicyPeriod[0].id));
    }
  }

  void changePolicyHeader(String? value) {
    List<GeneralItem> tempHeader = insuranceInitialData
        .value.lstPolicyHeaderType
        .where((element) => element.id == value)
        .toList();
    if (tempHeader.isNotEmpty) {
      policyHeaderObj.value = tempHeader[0];
      getPrice(InsurancePriceGetBody(
          covidtype: value ?? insurancePriceGetBody.value.covidtype,
          policyplan: insurancePriceGetBody.value.policyplan,
          policy_type: insurancePriceGetBody.value.policy_type,
          policyperiod: insurancePriceGetBody.value.policyperiod));
    }
  }

  void changePolicyPlan(String? value) {
    List<GeneralItem> tempPlan = insuranceInitialData.value.lstPolicyOption
        .where((element) => element.id == value)
        .toList();
    if (tempPlan.isNotEmpty) {
      policyOptionObj.value = tempPlan[0];

      getPrice(InsurancePriceGetBody(
          covidtype: insurancePriceGetBody.value.covidtype,
          policyplan: value ?? insurancePriceGetBody.value.policyplan,
          policy_type: insurancePriceGetBody.value.policy_type,
          policyperiod: insurancePriceGetBody.value.policyperiod));
    }
  }

  void changePolicyType(String? value) {
    List<GeneralItem> tempType = insuranceInitialData.value.lstPolicyType
        .where((element) => element.id == value)
        .toList();
    if (tempType.isNotEmpty) {
      policyTypeObj.value = tempType[0];
      if(value == "1"){
        updateFamilyMembersCount( 0,
            0, 0 );
      }else{
        updateFamilyMembersCount( 1,
            0, 0 );
      }
      getPrice(InsurancePriceGetBody(
          covidtype: insurancePriceGetBody.value.covidtype,
          policyplan: insurancePriceGetBody.value.policyplan,
          policy_type: value ?? insurancePriceGetBody.value.policy_type,
          policyperiod: insurancePriceGetBody.value.policyperiod));
    }
  }

  void changePolicyPeriod(String? value) {
    List<GeneralItem> tempPeriod = insuranceInitialData.value.lstPolicyPeriod
        .where((element) => element.id == value)
        .toList();
    if (tempPeriod.isNotEmpty) {
      policyPeriodObj.value = tempPeriod[0];

      getPrice(InsurancePriceGetBody(
          covidtype: insurancePriceGetBody.value.covidtype,
          policyplan: insurancePriceGetBody.value.policyplan,
          policy_type: insurancePriceGetBody.value.policy_type,
          policyperiod: value ?? insurancePriceGetBody.value.policyperiod));
    }
  }

  void updateFamilyMembersCount(
      int spouseCount, int daughterCount, int sonCount) {
    spouse.value = spouseCount;
    daughter.value = daughterCount;
    son.value = sonCount;
  }

  void saveContactInfo(
      String tMobileCntry, String tMobileNumber, String tEmail) {
    mobileCntry.value = tMobileCntry;
    mobileNumber.value = tMobileNumber;
    email.value = tEmail;
  }

  getUserId(InsuranceTravellerInfo travelInfo, int index) {
    print("travelInfo.relationshipCode");
    print(travelInfo.relationshipCode);

    for (var element in insuranceInitialData.value.lstPolicyRelationship) {
      if (element.id == travelInfo.relationshipCode) {
        return element.name;
      }
    }
  }

  void changePolicyDate(DateTime dateTime) {
    policyDate.value = dateTime;
    policyDateController.value.text = getFormattedDate(dateTime);
  }

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('dd-MM-yyyy');
    return f.format(dateTime);
  }

  Future<void> getPaymentGateways() async {
    isInsuranceSaveTravellerLoading.value = true;

    List<PaymentGateway> tempPaymentGateway =
        await insuranceBookingHttpService.getPaymentGateways(bookingRef.value);

    print("tempPaymentGateway");
    print(tempPaymentGateway.length);
    print(tempPaymentGateway[0]);
    paymentGateways.value = tempPaymentGateway;
    if (tempPaymentGateway.isNotEmpty) {
      updateProcessId(tempPaymentGateway[0].processID);
      Get.toNamed(Approute_insuranceSummary);
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isInsuranceSaveTravellerLoading.value = false;
  }

  Future<void> setPaymentGateway() async {
    isInsuranceSavePaymentGatewayLoading.value = true;

    PaymentGatewayUrlData paymentGatewayUrlData =
        await insuranceBookingHttpService.setPaymentGateway(
            processId.value, paymentCode.value, bookingRef.value);

    print("paymentGatewayUrlData");
    print(paymentGatewayUrlData.isOkRedirection);

    gatewayUrl.value = paymentGatewayUrlData.gatewayUrl;
    confirmationUrl.value = paymentGatewayUrlData.confirmationUrl;

    if (gatewayUrl.value != "") {
      // Get.toNamed(Approute_paymentPage,
      //         arguments: [gatewayUrl.value, confirmationUrl.value])
      //     ?.then((value) {
      //       if(value){
      //         checkGatewayStatus();
      //       }else{
      //         Get.offAllNamed(Approute_flightsSummary,
      //             predicate: (route) => Get.currentRoute == Approute_userDetailsSubmission);
      //         showSnackbar(Get.context!, "payment_capture_error".tr,"error");
      //       }
      //
      // });

      checkGatewayStatus();
    } else {
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isInsuranceSavePaymentGatewayLoading.value = false;
  }

  Future<void> checkGatewayStatus() async {
    isInsuranceGatewayStatusCheckLoading.value = true;
    bool isSuccess =
        await insuranceBookingHttpService.checkGatewayStatus(bookingRef.value);

    print("checkGatewayStatus isSuccess");
    print(isSuccess);

    if (isSuccess) {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      getConfirmationData();
    } else {

      int iter = 0;
      Get.offNamedUntil(Approute_insuranceSummary, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter ==1;
      });
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    }

    isInsuranceGatewayStatusCheckLoading.value = false;
  }

  Future<void> getConfirmationData() async {
    isInsuranceConfirmationDataLoading.value = true;

    PaymentConfirmationData paymentConfirmationData =
        await insuranceBookingHttpService.getConfirmationData(bookingRef.value);

    print("getConfirmationData");
    print(paymentConfirmationData.isIssued);
    print(paymentConfirmationData.pdfLink);
    print(paymentConfirmationData.alertMsg);

    if (paymentConfirmationData.isIssued) {
      pdfLink.value = paymentConfirmationData.pdfLink;
      // confirmationMessage.value = paymentConfirmationData.alertMsg;
      showSnackbar(Get.context!, "insurance_booking_success".tr, "info");
      int iter = 0;
      Get.offNamedUntil(Approute_insuranceConfirmation, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter ==3;
      });
    } else {
      showSnackbar(Get.context!, "booking_failed".tr, "error");

      int iter = 0;
      Get.offNamedUntil(Approute_insuranceSummary, (route) {
        print("Get.currentRoute");
        print(Get.currentRoute);
        return ++iter ==1;
      });

      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

    isInsuranceConfirmationDataLoading.value = false;
  }

  void updateProcessId(String? value) {
    if (value != null) {
      List<PaymentGateway> tempPaymentGateways = paymentGateways.value
          .where((element) => element.processID == value)
          .toList();

      if (tempPaymentGateways.isNotEmpty) {
        selectedPaymentGateway.value = tempPaymentGateways[0];

        processId.value = value;
        paymentCode.value = tempPaymentGateways[0].paymentCode;
        processingFee.value = tempPaymentGateways[0].processingFee;
      }
    }
  }

  void resetAndNavigateToHome() {
    bookingRef.value = "";
    selectedTravelInfo.value = [];

    int iter = 0;
    Get.offNamedUntil(Approute_insuranceLandingPage, (route) {
      print("Get.currentRoute");
      print(Get.currentRoute);
      return ++iter ==3;
    });

  }
}
