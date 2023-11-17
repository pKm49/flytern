import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:intl/intl.dart';

class HotelTravelInfo {
  final int roomId;
  final int hotelOptionid;
  final String title;
  final String firstName;
  final String lastName;
  final String gender;

  HotelTravelInfo(
      {required this.hotelOptionid,
      required this.roomId,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.gender });

  Map toJson() => {
        'roomid': roomId,
        'hotelOptionid': hotelOptionid,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender
      };
}

HotelTravelInfo mapHotelTravelInfo(dynamic payload) {

  print("mapHotelTravelInfo");
  print(payload);

  return HotelTravelInfo(
    roomId: payload["roomId"] ?? -1,
    hotelOptionid: payload["hotelOptionid"] ?? -1,
    title: payload["title"] ?? "",
    firstName: payload["firstName"] ?? "",
    lastName: payload["lastName"] ?? "",
    gender: payload["gender"] ?? "",
  );
}

