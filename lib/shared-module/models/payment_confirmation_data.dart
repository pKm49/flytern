 
import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/details.hotel_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';

class PaymentConfirmationData {
  final String pdfLink; 
  final bool isIssued;
  final FlightDetails flightDetails;
  final ActivityDetails activityDetails;
  final HotelDetails hotelDetails;
  final List<BookingInfo> bookingInfo;
  final List<BookingInfo> paymentInfo;
  final List<String> alertMsg;
  
  PaymentConfirmationData(
      {required this.pdfLink,
      required this.alertMsg,
      required this.isIssued ,
      required this.paymentInfo ,
        required this.flightDetails,
        required this.activityDetails,
        required this.hotelDetails,
        required this.bookingInfo });
}

PaymentConfirmationData mapPaymentpdfLinkData(dynamic payload) {

  List<BookingInfo>  paymentInfo = [];
  List<BookingInfo>  bookingInfo = [];
  List<String> alertMsg = [];
  FlightDetails flightDetails = mapFlightDetails({});
  HotelDetails hotelDetails = mapHotelDetails({});
  ActivityDetails activityDetails = mapActivityDetails({},[]);

  if (payload["_flightservice"] != null) {
    if (payload["_flightservice"]["_flightDetail"] != null) {
      flightDetails = mapFlightDetails(
          payload["_flightservice"]["_flightDetail"]);
      print("flightDetails");
      print(flightDetails.objectId);
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

  return PaymentConfirmationData(
      hotelDetails:hotelDetails,
      paymentInfo:paymentInfo,
      activityDetails:activityDetails,
      bookingInfo:bookingInfo,
      flightDetails:flightDetails,
      pdfLink: payload["pdfLink"] ?? "",
      alertMsg: alertMsg,
      isIssued: payload["isIssued"] ?? false );
}
