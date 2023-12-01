import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';

class MyActivityBooking {


  final String travelmateID;
  final String eventName;
  final DateTime eventDate;
  final String bookingReference;
  final String bookingStatus;
  final String address;
  final String leadClientName;
  final double grossSellingPrice;
  final String tmSaleCurrency;
  final String hotelImageUrl;




  MyActivityBooking({
    required this.bookingReference,
    required this.hotelImageUrl,
    required this.eventName,
    required this.eventDate,
    required this.tmSaleCurrency,
    required this.grossSellingPrice,
    required this.address,
    required this.leadClientName,
    required this.travelmateID,
    required this.bookingStatus,
  });

}

MyActivityBooking mapMyActivityBooking(dynamic payload){
  print("mapMyActivityBooking");
  print(payload["travelmateid"]);
  return MyActivityBooking(
    bookingReference :payload["bookingReference"]??-1,
    hotelImageUrl :payload["hotelImageUrl"]??"",
    eventName :payload["eventName"]??"",
    tmSaleCurrency :payload["tmSaleCurrency"]??"",
    grossSellingPrice :payload["grossSellingPrice"]??0.0,
    address :payload["address"]??"",
    leadClientName :payload["leadClientName"]??"",
    travelmateID :payload["travelmateid"]??"",
    eventDate :payload["eventDate"] !=null? DateTime.parse(payload["eventDate"]):DefaultInvalidDate,
    bookingStatus :payload["bookingStatus"]??"",
  );
}
