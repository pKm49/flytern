 
 import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';

class PaymentConfirmationData {
  final String pdfLink; 
  final bool isIssued;
  final bool isSuccess;
  final FlightDetails flightDetails;
  final HotelDetails hotelDetails;
  final List<BookingInfo> bookingInfo;
  final List<BookingInfo> paymentInfo;
  final List<String> alertMsg;
  
  PaymentConfirmationData(
      {required this.pdfLink,
      required this.isSuccess,
      required this.alertMsg,
      required this.isIssued ,
      required this.paymentInfo ,
        required this.flightDetails,
        required this.hotelDetails,
        required this.bookingInfo });
}

PaymentConfirmationData mapPaymentpdfLinkData(dynamic payload,bool isSuccess) {

  List<BookingInfo>  paymentInfo = [];
  List<BookingInfo>  bookingInfo = [];
  List<String> alertMsg = [];
  FlightDetails flightDetails = mapFlightDetails({});
  HotelDetails hotelDetails = mapHotelDetails({});


  if (payload["_hotelservice"] != null) {
    hotelDetails = mapHotelDetails(
        payload["_hotelservice"] );
  }

  if (payload["_flightservice"] != null) {
    if (payload["_flightservice"]["_flightDetail"] != null) {
      flightDetails = mapFlightDetails(
          payload["_flightservice"]["_flightDetail"]);
    }
  }


  if (payload["alertMsg"]!=null) {
    payload["alertMsg"].forEach((element) {
      if(element != null){
        alertMsg.add(element);
      }
    });
  }
  if (payload["_bookingInfo"]!=null) {
    payload["_bookingInfo"].forEach((element) {
      if(element != null){
        bookingInfo.add(mapBookingInfo(element));
      }

    });
  }

  if (payload["_paymentInfo"]!=null) {
    payload["_paymentInfo"].forEach((element) {
      if(element != null){
        paymentInfo.add(mapBookingInfo(element));
      }

    });
  }


  return PaymentConfirmationData(
      hotelDetails:hotelDetails,
      isSuccess:isSuccess,
      paymentInfo:paymentInfo,
      bookingInfo:bookingInfo,
      flightDetails:flightDetails,
      pdfLink: payload["pdfLink"] ?? "error",
      alertMsg: alertMsg,
      isIssued: payload["isIssued"] ?? false );
}
