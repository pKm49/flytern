 
import 'package:flytern/feature-modules/flight_booking/models/details.flight_booking.model.dart';
import 'package:flytern/shared-module/models/booking_info.dart';

class PaymentConfirmationData {
  final String pdfLink; 
  final bool isIssued;
  final FlightDetails flightDetails;
  final List<BookingInfo> bookingInfo;
  final List<String> alertMsg;
  
  PaymentConfirmationData(
      {required this.pdfLink,
      required this.alertMsg,
      required this.isIssued ,
        required this.flightDetails,
        required this.bookingInfo });
}

PaymentConfirmationData mapPaymentpdfLinkData(dynamic payload) {

  List<BookingInfo>  bookingInfo = [];
  List<String> alertMsg = [];
  FlightDetails flightDetails = mapFlightDetails({});

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

  return PaymentConfirmationData(
      bookingInfo:bookingInfo,
      flightDetails:flightDetails,
      pdfLink: payload["pdfLink"] ?? "",
      alertMsg: alertMsg,
      isIssued: payload["isIssued"] ?? false );
}
