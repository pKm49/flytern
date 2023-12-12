import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:intl/intl.dart';

class HotelTravelInfo {
  final int roomIndex;
  final int userIndex;
  final int typeIndex;
  final int roomId;
  final int hotelOptionid;
  final String selectedCopaxId;
  final String title;
  final String firstName;
  final String lastName;
  final String gender;
  final String travellerType;

  HotelTravelInfo(
      {required this.hotelOptionid,
      required this.roomId,
      required this.roomIndex,
      required this.selectedCopaxId,
      required this.typeIndex,
      required this.userIndex,
      required this.travellerType,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.gender});

  Map toJson() => {
        'roomid': roomId,
        'hotelOptionid': hotelOptionid,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'travellerType': travellerType,
        'gender': gender
      };
}

HotelTravelInfo mapHotelTravelInfo(dynamic payload) {
  return HotelTravelInfo(
    typeIndex: payload["typeIndex"] ?? -1,
    roomIndex: payload["roomIndex"] ?? -1,
    userIndex: payload["userIndex"] ?? -1,
    selectedCopaxId: payload["selectedCopaxId"] ?? "0",
    roomId: payload["roomId"] ?? -1,
    hotelOptionid: payload["hotelOptionid"] ?? -1,
    title: payload["title"] ?? "",
    travellerType: payload["travellerType"] ?? "",
    firstName: payload["firstName"] ?? "",
    lastName: payload["lastName"] ?? "",
    gender: payload["gender"] ?? "",
  );
}
