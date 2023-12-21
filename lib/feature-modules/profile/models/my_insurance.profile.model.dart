import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:intl/intl.dart';

class MyInsuranceBooking {
  final String bookingRef;
  final String status;
  final List<MyInsuranceBookingListRecord> myInsuranceBookingListRecords;

  MyInsuranceBooking(
      {
      required this.bookingRef,
      required this.status,
      required this.myInsuranceBookingListRecords});
}

MyInsuranceBooking mapMyInsuranceBooking(dynamic payload) {
  List<MyInsuranceBookingListRecord> myHotelBookingListRecords = [];


  if (payload["_Listrecords"] != null) {
    payload["_Listrecords"].forEach((element) {
      if(element != null){
        myHotelBookingListRecords.add(mapMyInsuranceBookingListRecord(element));
      }

    });
  }

  return MyInsuranceBooking(
    bookingRef: payload["bookingRef"] ?? "",
    status: payload["status"] ?? "",
    myInsuranceBookingListRecords: myHotelBookingListRecords,
  );
}


class MyInsuranceBookingListRecord {
  final String title;
  final String information;

  MyInsuranceBookingListRecord({
    required this.title,
    required this.information,
  });
}
MyInsuranceBookingListRecord mapMyInsuranceBookingListRecord(dynamic payload)
{
  return MyInsuranceBookingListRecord(
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
