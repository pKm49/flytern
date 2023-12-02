 
import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';

class PaymentConfirmationData {
  final String pdfLink; 
  final bool isIssued;
  final bool isSuccess;
  final FlightDetails flightDetails;
  final ActivityDetails activityDetails;
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
        required this.activityDetails,
        required this.hotelDetails,
        required this.bookingInfo });
}

PaymentConfirmationData mapPaymentpdfLinkData(dynamic payload,bool isSuccess) {

  List<BookingInfo>  paymentInfo = [];
  List<BookingInfo>  bookingInfo = [];
  List<String> alertMsg = [];
  FlightDetails flightDetails = mapFlightDetails({});
  HotelDetails hotelDetails = mapHotelDetails({});
  ActivityDetails activityDetails = mapActivityDetails({},[]);


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
      alertMsg.add(element);
    });
  }
  if (payload["_bookingInfo"]!=null) {
    payload["_bookingInfo"].forEach((element) {
      bookingInfo.add(mapBookingInfo(element));
    });
  }

  if (payload["_paymentInfo"]!=null) {
    payload["_paymentInfo"].forEach((element) {
      paymentInfo.add(mapBookingInfo(element));
    });
  }

  if (payload["_activityservice"] != null) {
    if (payload["_activityservice"]["_eventdetails"] != null) {
      activityDetails = mapActivityDetails(
          payload["_activityservice"]["_eventdetails"],
          payload["_activityservice"]["_eventimages"]??[]
      );
    }
  }

  return PaymentConfirmationData(
      hotelDetails:hotelDetails,
      isSuccess:isSuccess,
      paymentInfo:paymentInfo,
      activityDetails:activityDetails,
      bookingInfo:bookingInfo,
      flightDetails:flightDetails,
      pdfLink: payload["pdfLink"] ?? "error",
      alertMsg: alertMsg,
      isIssued: payload["isIssued"] ?? false );
}
