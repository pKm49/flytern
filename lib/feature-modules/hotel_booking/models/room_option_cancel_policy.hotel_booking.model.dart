import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';

class HotelRoomOptionCancelPolicy {

  final DateTime fromDate;
  final String chargeType;
  final double cancellationCharge;

  HotelRoomOptionCancelPolicy({
    required this.fromDate,
    required this.chargeType,
    required this.cancellationCharge
  });
}

HotelRoomOptionCancelPolicy mapHotelRoomOptionCancelPolicy(dynamic payload) {


  return HotelRoomOptionCancelPolicy(
    fromDate: payload["fromDate"]!=null?DateTime.parse(getParsableDateString(payload["fromDate"])) :DefaultInvalidDate,
    chargeType: payload["chargeType"] ?? "",
    cancellationCharge: payload["cancellationCharge"] ?? 0.0,
  );


}
String getParsableDateString(String payload) {
  return payload.split(" ").toList()[0].split("-").toList().reversed.join("-");
}