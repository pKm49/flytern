import 'package:flytern/feature-modules/hotel_booking/models/room_option.hotel_booking.model.dart';

class HotelRoom {
  
  final int roomid;
  final String roomref;
  final String roomDisplayNo;
  final List<HotelRoomOption> roomOptions;

  HotelRoom({
    required this.roomid,
    required this.roomref,
    required this.roomDisplayNo,
    required this.roomOptions,
  });
}

HotelRoom mapHotelRoom(dynamic payload) {

  List<HotelRoomOption> roomOptions = [];
  if (payload["_lstRoomsDtls"] != null) {
    payload["_lstRoomsDtls"].forEach((element) {
      roomOptions.add(mapHotelRoomDetails(element));
    });
  }
  return HotelRoom(
    roomid: payload["roomid"] ?? -1,
    roomref: payload["roomref"] ?? "",
    roomDisplayNo: payload["roomDisplayNo"] ?? "",
    roomOptions: roomOptions,
  );
}
