
import 'package:flytern/feature-modules/hotel_booking/data/models/hotel_amenitys.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/hotel_room_option.dart';

class HotelBasicDetail {
  
  final String policyName;
  final String policyText;

  HotelBasicDetail(
      {required this.policyName,
      required this.policyText, });
}

HotelBasicDetail mapHotelBasicDetail(dynamic payload) {

  return HotelBasicDetail(
    policyName: payload["policyName"] ?? "",
    policyText: payload["policyText"] ?? "",
  );
}
