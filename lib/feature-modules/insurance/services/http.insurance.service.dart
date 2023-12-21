  import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
 import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/feature-modules/insurance/constants/http_request_endpoints.insurance.constant.dart';
import 'package:flytern/feature-modules/insurance/models/initial_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/price_data.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/get_price_body.insurance.model.dart';
import 'package:flytern/feature-modules/insurance/models/traveller_data.insurance.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';
 import 'package:flytern/shared-module/models/flytern_http_response.dart';
import 'package:flytern/shared-module/models/get_gateway_data.shared.model.dart';
import 'package:flytern/shared-module/models/payment_confirmation_data.dart';
import 'package:flytern/shared-module/models/payment_gateway.dart';
import 'package:flytern/shared-module/models/payment_gateway_url_data.dart';
import 'package:flytern/shared-module/services/http-services/http_request_handler.shared.service.dart';

class InsuranceBookingHttpService {

  Future<InsuranceInitialData> getInitialInfo() async {
    try{
      FlyternHttpResponse response =
      await getRequest(InsuranceBookingHttpRequestEndpointGetInitalInfo, null);
      InsuranceInitialData insuranceInitialData;
      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          InsuranceInitialData insuranceInitialData = mapInsuranceInitialData(response.data);
          return insuranceInitialData;
        }
      }

      return mapInsuranceInitialData({});
    }catch (e){
      return mapInsuranceInitialData({});
    }

  }

  Future<InsurancePriceData> getPrice(InsurancePriceGetBody insurancePriceGetBody) async {

    try{

      FlyternHttpResponse response =
      await postRequest(InsuranceBookingHttpRequestEndpointGetPrice, insurancePriceGetBody.toJson());

      if (response.success) {
        if (response.data != null) {
          InsurancePriceData insurancePriceData = mapInsurancePriceData(response.data);
          return insurancePriceData;
        }
      }

      return mapInsurancePriceData({});
    }catch (e){
      return mapInsurancePriceData({});
    }
  }

  Future<String> setUserData(InsuranceTravellerData insuranceTravellerData) async {

    try{


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
    }catch (e){
      return "";
    }
  }


  Future<GetGatewayData> getPaymentGateways(
      String bookingRef) async {
    List<PaymentGateway> paymentGateways = [];
    List<BookingInfo>  bookingInfo = [];
    List<String> alertMsg = [];
    FlightDetails flightDetails = mapFlightDetails({});
    HotelDetails hotelDetails = mapHotelDetails({});
    ActivityDetails activityDetails = mapActivityDetails({},[]);

    try{
      FlyternHttpResponse response = await postRequest(
          InsuranceBookingHttpRequestEndpointGetGateways,
          {
            "bookingRef": bookingRef
          });


      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isGateway"]) {
            response.data["_gatewaylist"].forEach((element) {
              if(element !=null){
                paymentGateways.add(mapPaymentGateway(element));
              }

            });
          }

          if (response.data["alertMsg"]!=null) {
            response.data["alertMsg"].forEach((element) {
              if(element !=null){
                alertMsg.add(element);
              }

            });
          }

          if (response.data["_bookingInfo"]!=null) {
            response.data["_bookingInfo"].forEach((element) {
              if(element !=null){
                bookingInfo.add(mapBookingInfo(element));
              }

            });
          }
        }
      }

      return GetGatewayData(
          hotelDetails:hotelDetails,
          activityDetails: activityDetails,
          paymentGateways: paymentGateways,
          alert: alertMsg,
          bookingInfo: bookingInfo,
          flightDetails: flightDetails);
    }catch (e){
      return GetGatewayData(
          hotelDetails:hotelDetails,
          activityDetails: activityDetails,
          paymentGateways: paymentGateways,
          alert: alertMsg,
          bookingInfo: bookingInfo,
          flightDetails: flightDetails);
    }



  }

  Future<PaymentGatewayUrlData> setPaymentGateway(String processID,
      String paymentCode,
      String bookingRef) async {

    try{

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
    }catch (e){
      return mapPaymentGatewayUrlData({});
    }
  }

  Future<bool> checkGatewayStatus(
      String bookingRef) async {

    try{
      FlyternHttpResponse response = await postRequest(
          InsuranceBookingHttpRequestEndpointCheckGatewayStatus,
          {
            "bookingRef": bookingRef
          });

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          if (response.data["isSuccess"] !=null) {
            return response.data["isSuccess"];
          }
        }
      }

      return false;
    }catch (e){
      return false;
    }

  }

  Future<PaymentConfirmationData> getConfirmationData(
      String bookingRef) async {

    try{
      FlyternHttpResponse response = await postRequest(
          InsuranceBookingHttpRequestEndpointConfirmation,
          {
            "bookingRef": bookingRef
          });

      if (response.success && response.statusCode == 200) {
        if (response.data != null) {
          PaymentConfirmationData paymentConfirmationData = mapPaymentpdfLinkData(response.data,true);
          return paymentConfirmationData;
        }
      }

      return mapPaymentpdfLinkData({},false);
    }catch (e){
      return mapPaymentpdfLinkData({},false);
    }

  }

}
