
import 'package:flytern/feature-modules/hotel_booking/models/amenity.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room_option.hotel_booking.model.dart';

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
