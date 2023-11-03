import 'package:flytern/feature-modules/flight_booking/data/models/business_models/explore_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_traveller_data.dart';
import 'package:flytern/feature-modules/insurance/data/constants/app_specific/insurance_booking_http_request_endpoints.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_initial_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_price_get_body.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_data.dart';
import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';
import 'package:flytern/shared/data/models/app_specific/flytern_http_response.dart';
import 'package:flytern/shared/services/http-services/http_request_handler.dart';

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
    await getRequest(InsuranceBookingHttpRequestEndpointGetPrice, insurancePriceGetBody.toJson());

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

}
