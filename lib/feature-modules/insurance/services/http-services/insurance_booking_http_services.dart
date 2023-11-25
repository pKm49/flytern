import 'package:flytern/feature-modules/flight_booking/models/explore_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/traveller_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/insurance/data/constants/app_specific/insurance_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_initial_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_get_body.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';
import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

class InsuranceBookingHttpService {

  Future<InsuranceInitialData> getInitialInfo() async {
    FlyternHttpResponse response =
    await getRequest(InsuranceBookingHttpRequestEndpointGetInitalInfo, null);
    InsuranceInitialData insuranceInitialData;
    if (response.success) {
      if (response.data != null) {
        InsuranceInitialData insuranceInitialData = mapInsuranceInitialData(response.data);
        return insuranceInitialData;
      }
    }

    return mapInsuranceInitialData({});
  }

  Future<InsurancePriceData> getPrice(InsurancePriceGetBody insurancePriceGetBody) async {
    FlyternHttpResponse response =
    await postRequest(InsuranceBookingHttpRequestEndpointGetPrice, insurancePriceGetBody.toJson());

    if (response.success) {
      if (response.data != null) {
        InsurancePriceData insurancePriceData = mapInsurancePriceData(response.data);
        return insurancePriceData;
      }
    }

    return mapInsurancePriceData({});
  }

  Future<String> setUserData(InsuranceTravellerData insuranceTravellerData) async {

    FlyternHttpResponse response = await postRequest(
        InsuranceBookingHttpRequestEndpointSetUserData,
        insuranceTravellerData.toJson());

    String bookingRef;

    if (response.success && response.statusCode ==200) {
      if (response.data != null  ) {
        bookingRef = response.data["bookingRef"]??"";
        return bookingRef;
      }
    }

    return "";
  }


  Future<List<PaymentGateway>> getPaymentGateways(
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        InsuranceBookingHttpRequestEndpointGetGateways,
        {
          "bookingRef": bookingRef
        });

    List<PaymentGateway> paymentGateways = [];

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isGateway"]) {
          response.data["_gatewaylist"].forEach((element) {
            paymentGateways.add(mapPaymentGateway(element));
          });
          return paymentGateways;
        }
      }
    }

    return [];
  }

  Future<PaymentGatewayUrlData> setPaymentGateway(String processID,
      String paymentCode,
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        InsuranceBookingHttpRequestEndpointSetGateway,
        {
          "processID": processID,
          "paymentCode": paymentCode,
          "bookingRef": bookingRef
        });

    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentGatewayUrlData paymentGatewayUrlData = mapPaymentGatewayUrlData(response.data);
        return paymentGatewayUrlData;
      }
    }

    return mapPaymentGatewayUrlData({});
  }

  Future<bool> checkGatewayStatus(
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        InsuranceBookingHttpRequestEndpointCheckGatewayStatus,
        {
          "bookingRef": bookingRef
        });

    print("getPaymentGateways");
    print(response.data["isGateway"]);
    print(response.data["_gatewaylist"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        if (response.data["isSuccess"] !=null) {
          return response.data["isSuccess"];
        }
      }
    }

    return false;
  }

  Future<PaymentConfirmationData> getConfirmationData(
      String bookingRef) async {
    FlyternHttpResponse response = await postRequest(
        InsuranceBookingHttpRequestEndpointConfirmation,
        {
          "bookingRef": bookingRef
        });

    print("getConfirmationData");
    print(response.data["isIssued"]);
    print(response.data["pdfLink"]);
    if (response.success && response.statusCode == 200) {
      if (response.data != null) {
        PaymentConfirmationData paymentConfirmationData = mapPaymentpdfLinkData(response.data);
        return paymentConfirmationData;
      }
    }

    return mapPaymentpdfLinkData({});
  }

}
