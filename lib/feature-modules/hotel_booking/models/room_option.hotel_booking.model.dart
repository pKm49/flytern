import 'package:flytern/feature-modules/hotel_booking/models/room_option_cancel_policy.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room_option_supplement.hotel_booking.model.dart';

class HotelRoomOption {

  final List<String> imageURLs;
  final String bookingCode;
  final List<HotelRoomOptionCancelPolicy> cancelPolicies;
  final List<HotelRoomOptionSupplement> supplements;
  final int roomOptionid;
  final List<String> shortdesc;
  final List<String> roomsList;
  final String currency;
  final double perNightPrice;
  final double totalPrice;
  final double totalBase;
  final double totalTax;
  final String roomName;

  HotelRoomOption({
    required this.imageURLs,
    required this.bookingCode,
    required this.cancelPolicies,
    required this.roomOptionid,
    required this.supplements,
    required this.currency,
    required this.perNightPrice,
    required this.roomsList,
    required this.roomName,
    required this.shortdesc,
    required this.totalPrice,
    required this.totalBase,
    required this.totalTax,
  });
}

HotelRoomOption mapHotelRoomDetails(dynamic payload) {

  List<String> shortdesc = [];
  List<HotelRoomOptionCancelPolicy> cancelPolicies = [];
  List<HotelRoomOptionSupplement> supplements = [];
  List<String> imageUrls = [];
  List<String> roomsList = [];
  if(payload["imageURLs"] !=null){
    payload["imageURLs"].forEach((element) {
      if(element != null){
        imageUrls.add(element);
      }

    });
  }
  if(payload["roomsList"] !=null){
    payload["roomsList"].forEach((element) {
      if(element != null){
        roomsList.add(element);
      }

    });
  }

  if(payload["shortdesc"] !=null) {
    payload["shortdesc"].forEach((element) {
      if(element != null){
        shortdesc.add(element);
      }

    });
  }

  if(payload["cancelPolicies"] !=null) {
    if (payload["cancelPolicies"] != null) {
      payload["cancelPolicies"].forEach((element) {
        if(element != null){
          cancelPolicies.add(mapHotelRoomOptionCancelPolicy(element));
        }

      });
    }
  }


  if (payload["supplements"] != null) {
      payload["supplements"].forEach((element) {
        if (element != null) {
          if (element[0] != null) {
            supplements.add(mapHotelRoomOptionSupplement(element[0]));
          }
        }
      });
  }

  return HotelRoomOption(
    supplements:supplements,
    cancelPolicies: cancelPolicies,
    imageURLs: imageUrls,
    bookingCode: payload["bookingCode"] ?? "",
    roomOptionid: payload["roomOptionid"] ?? -1,
    totalTax: payload["totalTax"] ?? 0.0,
    currency: payload["currency"] ?? "",
    perNightPrice: payload["perNightPrice"] ?? 0.0,
    roomName: payload["roomName"] ?? "",
    shortdesc: shortdesc,
    roomsList: roomsList,
    totalPrice: payload["totalPrice"] ?? 0.0,
    totalBase: payload["totalBase"] ?? 0.0,
  );
}
