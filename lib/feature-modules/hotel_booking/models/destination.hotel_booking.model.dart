
import 'package:get/get.dart';

class HotelDestination {

  final String countryCode;
  final String hotelCode;
  final String cityCode;
  final String cityName;
  final String uniqueCombination;
  final int sort;
  final String flag;

  HotelDestination({
    required this.countryCode,
    required this.hotelCode,
    required this.cityCode,
    required this.cityName,
    required this.uniqueCombination,
    required this.sort,
    required this.flag,
  });

  Map toJson() => {
    'cityCode': cityCode,
    'hotelCode': hotelCode,
    'cityName': cityName,
    'uniqueCombination': uniqueCombination,
    'sort': sort,
    'countryCode': countryCode,
    'flag': flag,
  };

}

HotelDestination mapHotelDestination(dynamic payload){

  String cityName = payload["cityName"]??("select_destination".tr);
  String uniqueCombination = payload["uniqueCombination"]??("select_destination".tr);

  return HotelDestination(
    hotelCode :payload["hotelCode"]??"",
    cityCode :payload["cityCode"]??"",
    cityName :cityName,
    uniqueCombination :uniqueCombination,
    sort :payload["sort"]??-1,
    countryCode :payload["countryCode"]??"",
    flag :payload["flag"]??"",
  );
}

