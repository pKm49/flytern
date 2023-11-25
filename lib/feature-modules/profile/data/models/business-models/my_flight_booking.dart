import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:intl/intl.dart';

class MyFlightBooking {
  final String paidAmount;
  final String bookingRef;
  final String flightName;
  final String cabinClass;
  final String refundStatus;
  final String currency;
  final String airlineCode;
  final String airlineImgUrl;
  final List<MyFlightBookingListflight> myFlightBookingListflights;
  final List<MyFlightBookingListRecord> myFlightBookingListRecords;

  MyFlightBooking(
      {required this.paidAmount,
      required this.bookingRef,
      required this.flightName,
      required this.cabinClass,
      required this.refundStatus,
      required this.airlineCode,
      required this.airlineImgUrl,
      required this.currency,
      required this.myFlightBookingListflights,
      required this.myFlightBookingListRecords});
}

MyFlightBooking mapMyFlightBooking(dynamic payload) {
  List<MyFlightBookingListflight> myFlightBookingListflights = [];
  List<MyFlightBookingListRecord> myFlightBookingListRecords = [];

  if (payload["_Listflight"] != null) {
    payload["_Listflight"].forEach((element) {
      myFlightBookingListflights.add(mapMyFlightBookingListflight(element));
    });
  }

  if (payload["_Listrecords"] != null) {
    payload["_Listrecords"].forEach((element) {
      myFlightBookingListRecords.add(mapMyFlightBookingListRecord(element));
    });
  }

  return MyFlightBooking(
    currency: payload["currency"] ?? "",
    bookingRef: payload["bookingRef"] ?? "",
    paidAmount: payload["paidAmount"].toString() ?? "",
    flightName: payload["flightName"] ?? "",
    cabinClass: payload["cabinClass"] ?? "",
    refundStatus: payload["refundStatus"] ?? "",
    airlineCode: payload["airlineCode"] ?? "",
    airlineImgUrl: payload["airlineImgUrl"] ?? "",
    myFlightBookingListflights: myFlightBookingListflights,
    myFlightBookingListRecords: myFlightBookingListRecords,
  );
}

class MyFlightBookingListflight {
  final String deptAirport;
  final String deptAirportDtl;
  final String arvlAirport;
  final String arvlAirportDtl;
  final String depDate;
  final String depArvlDate;

  MyFlightBookingListflight(
      {required this.deptAirport,
      required this.deptAirportDtl,
      required this.arvlAirport,
      required this.arvlAirportDtl,
      required this.depDate,
      required this.depArvlDate});
}

MyFlightBookingListflight mapMyFlightBookingListflight(dynamic payload) {
  return MyFlightBookingListflight(
    deptAirport: payload["deptAirport"] ?? "",
    deptAirportDtl: payload["deptAirportDtl"] ?? "",
    arvlAirport: payload["arvlAirport"] ?? "",
    arvlAirportDtl: payload["arvlAirportDtl"] ?? "",
    depDate: payload["depDate"] ?? "",
    depArvlDate: payload["depArvlDate"] ?? "",
  );
}

class MyFlightBookingListRecord {
  final String title;
  final String information;

  MyFlightBookingListRecord({
    required this.title,
    required this.information,
  });
}
MyFlightBookingListRecord mapMyFlightBookingListRecord(dynamic payload)
{
  return MyFlightBookingListRecord(
    title: payload["title"] ?? "",
    information: payload["information"] ?? ""
  );
}

String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}

String getFormattedDate(DateTime dateTime) {
  final f = DateFormat('dd-MM-yyyy');
  return f.format(dateTime);
}
