import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:intl/intl.dart';

class MyHotelBooking {
  final String paidAmount;
  final String bookingRef;
  final String hotelTelephone;
  final String address;
  final String refundStatus;
  final String currency;
  final String hotelname;
  final String hotelimageurl;
  final String checkin;
  final String checkout;
  final String status;

  final List<MyHotelBookingListRecord> myHotelBookingListRecords;

  MyHotelBooking(
      {required this.paidAmount,
      required this.checkin,
      required this.checkout,
      required this.bookingRef,
      required this.status,
      required this.hotelTelephone,
      required this.address,
      required this.refundStatus,
      required this.hotelname,
      required this.hotelimageurl,
      required this.currency,
      required this.myHotelBookingListRecords});
}

MyHotelBooking mapMyHotelBooking(dynamic payload) {
  List<MyHotelBookingListRecord> myHotelBookingListRecords = [];


  if (payload["_Listrecords"] != null) {
    payload["_Listrecords"].forEach((element) {
      if(element != null){
        myHotelBookingListRecords.add(mapMyHotelBookingListRecord(element));
      }

    });
  }

  return MyHotelBooking(
    status: payload["status"] ?? "",
    currency: payload["currency"] ?? "",
    bookingRef: payload["bookingRef"] ?? "",
    paidAmount: payload["paidAmount"] ?? -1,
    hotelTelephone: payload["hotelTelephone"] ?? "",
    address: payload["address"] ?? "",
    refundStatus: payload["refundStatus"] ?? "",
    hotelname: payload["hotelname"] ?? "",
    hotelimageurl: payload["hotelimageurl"] ?? "",
    checkin: payload["checkin"] ?? "",
    checkout: payload["checkout"] ?? "",
    myHotelBookingListRecords: myHotelBookingListRecords,
  );
}

class MyHotelBookingListRecord {
  final String title;
  final String information;

  MyHotelBookingListRecord({
    required this.title,
    required this.information,
  });
}
MyHotelBookingListRecord mapMyHotelBookingListRecord(dynamic payload)
{
  return MyHotelBookingListRecord(
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
