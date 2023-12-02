import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/models/initial_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/price_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/get_price_body.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/traveller_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/traveller_info.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/services/http.insurance.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
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
  var isSmartPaymentCheckLoading = false.obs;

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
  var isIssued = false.obs;
  var paymentInfo = <BookingInfo>[].obs;
  var bookingInfo = <BookingInfo>[].obs;
  var alert = <String>[].obs;
  var confirmationMessage = "".obs;
  var confirmationUrl = "".obs;
  var policyDate = DefaultInvalidDate.obs;
  var selectedTravelInfo = <InsuranceTravellerInfo>[].obs;


  Rx<TextEditingController> policyDateController = TextEditingController().obs;
  var paymentGateways = <PaymentGateway>[].obs;
  var selectedPaymentGateway = mapPaymentGateway({}).obs;

  @override
  void onInit() {
    super.onInit();
    // getInitialInfo();
  }

  Future<void> getInitialInfo() async {

    if(insuranceInitialData.value.lstPolicyType.isNotEmpty) {
      await Future.delayed(const Duration(seconds: 1));
    }
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
      if (travelInfo[i].firstName == "") {
        validityString = "enter_firstname_copax"
            .tr
            .replaceAll("user", "  ${getUserId(travelInfo[i], i)}");

        break;
      }

      if (travelInfo[i].lastName == "") {
        validityString = "enter_lastname_copax"
            .tr
            .replaceAll("user", "${getUserId(travelInfo[i], i)} ");

        break;
      }


      if (travelInfo[i].dateOfBirth == DefaultInvalidDate) {
        validityString = "enter_dob_copax"
            .tr
            .replaceAll("user", "${getUserId(travelInfo[i], i)}  ");

        break;
      }


      if (travelInfo[i].nationalityCode == "") {
        validityString = "enter_nationality_copax"
            .tr
            .replaceAll("user", "${getUserId(travelInfo[i], i)} ");

        break;
      }

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

       InsuranceTravellerData insuranceTravellerData = InsuranceTravellerData(
          covid: policyHeaderObj.value.id,
          policyType: policyTypeObj.value.id,
          contributor: contributor.value,
          son: son.value,
          daughter: daughter.value,
          spouse: spouse.value,
          policyPlan: policyOptionObj.value.id,
          policyDuration: policyPeriodObj.value.id,
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
        getPaymentGateways(false,bookingRef.value);
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
      if (value == "1") {
        updateFamilyMembersCount(0, 0, 0);
      } else {
        updateFamilyMembersCount(1, 0, 0);
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

  checkSmartPayment(String tempBookingRef) async {
    isSmartPaymentCheckLoading.value = true;

    bool isSuccess =
    await insuranceBookingHttpService.checkSmartPayment(tempBookingRef);

    if (isSuccess) {
      bookingRef.value = tempBookingRef;
      getPaymentGateways(true,tempBookingRef);
    } else {
      isSmartPaymentCheckLoading.value = false;
      showSnackbar(Get.context!, "couldnt_find_booking".tr, "error");
    }
  }


  Future<void> getPaymentGateways(bool isSmartpayment, String tempBookingRef) async {

    if(isSmartpayment){
      bookingRef.value = tempBookingRef;
    }
    isInsuranceSaveTravellerLoading.value = true;
    paymentGateways.value = [];
    alert.value = [];
    alert.value = [];
    GetGatewayData getGatewayData =
        await insuranceBookingHttpService.getPaymentGateways(bookingRef.value);

    paymentGateways.value = getGatewayData.paymentGateways;
    bookingInfo.value = getGatewayData.bookingInfo;
    alert.value = getGatewayData.alert;

    if (getGatewayData.paymentGateways.isNotEmpty) {
      updateProcessId(getGatewayData.paymentGateways[0].processID);
    }

    Get.toNamed(Approute_insuranceSummary);
    isSmartPaymentCheckLoading.value= false;
    isInsuranceSaveTravellerLoading.value = false;
  }

  Future<void> setPaymentGateway() async {
    isInsuranceSavePaymentGatewayLoading.value = true;

    PaymentGatewayUrlData paymentGatewayUrlData =
        await insuranceBookingHttpService.setPaymentGateway(
            selectedPaymentGateway.value.processID, selectedPaymentGateway.value.paymentCode, bookingRef.value);

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

    if (isSuccess) {
      showSnackbar(Get.context!, "payment_capture_success".tr, "info");
      getConfirmationData(bookingRef.value,false);
    } else {
      int iter = 0;
      Get.offNamedUntil(Approute_insuranceSummary, (route) {

        return ++iter == 1;
      });
      showSnackbar(Get.context!, "payment_capture_error".tr, "error");
    }

    isInsuranceGatewayStatusCheckLoading.value = false;
  }

  Future<void> getConfirmationData(String bookingRef,bool isBookingFinder) async {
    isInsuranceConfirmationDataLoading.value = true;
    bookingInfo.value = [];
    paymentInfo.value = [];
    alert.value = [];
    pdfLink.value = "";
    isIssued.value = false;
    PaymentConfirmationData paymentConfirmationData =
        await insuranceBookingHttpService.getConfirmationData(bookingRef);


    if (paymentConfirmationData.isSuccess) {
      pdfLink.value = paymentConfirmationData.pdfLink;
      pdfLink.value = paymentConfirmationData.pdfLink;
      isIssued.value = paymentConfirmationData.isIssued;
      paymentInfo.value = paymentConfirmationData.paymentInfo;
      bookingInfo.value = paymentConfirmationData.bookingInfo;
      alert.value = paymentConfirmationData.alertMsg;
      // confirmationMessage.value = paymentConfirmationData.alertMsg;

      if(isBookingFinder){
        Get.toNamed(Approute_insuranceConfirmation, arguments: [
          {"mode": "edit"}
        ]);
      }else{
        showSnackbar(Get.context!, "insurance_booking_success".tr, "info");
        int iter = 0;
        Get.offNamedUntil(Approute_insuranceConfirmation,arguments:[
          {"mode": "view"}
        ], (route) {

          return ++iter == 3;
        });
      }
    } else {
      if(!isBookingFinder){
        showSnackbar(Get.context!, "booking_failed".tr, "error");

        int iter = 0;
        Get.offNamedUntil(Approute_insuranceSummary, (route) {

          return ++iter == 1;
        });
      }

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

      }
    }
  }

  void resetAndNavigateToHome() {
    bookingRef.value = "";
    selectedTravelInfo.value = [];
    Get.offAllNamed(Approute_landingpage);

  }


}
