import 'package:flytern/feature-modules/hotel_booking/models/search_item_room_data.hotel_booking.model.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';

class HotelPretravellerData {

  final List<Gender> genderList;
  final List<Gender> titleList;
  final List<HotelSearchItemRoomData> rooms;

  HotelPretravellerData(
      {
        required this.rooms,
      required this.genderList,
      required this.titleList});
}

HotelPretravellerData mapHotelPretravellerData(dynamic payload) {

  List<Gender> genderList = [];
  List<Gender> titleList = [];
  List<HotelSearchItemRoomData> rooms = [];

  if (payload["rooms"] != null) {
    payload["rooms"].forEach((element) {
      rooms.add(mapHotelSearchItem(element));
    });
  }
  if (payload["genderList"] != null) {
    payload["genderList"].forEach((element) {
      genderList.add(mapGender(element));
    });
  }

  if (payload["titleList"] != null) {
    payload["titleList"].forEach((element) {
      titleList.add(mapGender(element));
    });
  }

  return HotelPretravellerData(
    rooms:rooms,
    genderList: genderList,
    titleList: titleList,
  );



}
String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}