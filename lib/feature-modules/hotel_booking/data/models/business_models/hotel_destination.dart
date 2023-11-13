import 'package:get/get.dart';

class HotelDestination {

  final String cityCode;
  final String cityName;
  final String uniqueCombination;
  final int sort;
  final String countryCode; 
  final String flag;

  HotelDestination({
    required this.cityCode,
    required this.cityName, 
    required this.uniqueCombination,
    required this.sort,
    required this.countryCode,
    required this.flag,
  });

  Map toJson() => {
    'cityCode': cityCode,
    'cityName': cityName,
    'uniqueCombination': uniqueCombination,
    'sort': sort,
    'countryCode': countryCode,
    'flag': flag,
  };

}

HotelDestination mapHotelDestination(dynamic payload){
  return HotelDestination(
    cityCode :payload["cityCode"]??"",
    cityName :payload["cityName"]??"select_destination".tr,
    uniqueCombination :payload["uniqueCombination"]??"",
    sort :payload["sort"]??-1,
    countryCode :payload["countryCode"]??"",
    flag :payload["flag"]??"",
  );
}

