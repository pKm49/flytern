import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';

class HotelPretravellerData {

  final List<Gender> genderList;
  final List<Gender> titleList;

  HotelPretravellerData(
      {
      required this.genderList,
      required this.titleList});
}

HotelPretravellerData mapHotelPretravellerData(dynamic payload) {

  List<Gender> genderList = [];
  List<Gender> titleList = [];


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

    genderList: genderList,
    titleList: titleList,
  );



}
String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}