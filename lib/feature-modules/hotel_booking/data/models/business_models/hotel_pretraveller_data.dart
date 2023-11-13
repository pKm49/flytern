import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';

class HotelPretravellerData {
  final int adult;
  final int child;
  final int infant;
  final DateTime adultMinDOB;
  final DateTime childMinDOB;
  final DateTime infantMinDOB;
  final DateTime adultMaxDOB;
  final DateTime childMaxDOB;
  final DateTime infantMaxDOB;
  final List<Country> countriesList;
  final List<Country> mobileCountryList;
  final List<Gender> genderList;
  final List<Gender> titleList;

  HotelPretravellerData(
      {required this.adult,
      required this.child,
      required this.infant,
      required this.adultMinDOB,
      required this.childMinDOB,
      required this.infantMinDOB,
      required this.adultMaxDOB,
      required this.childMaxDOB,
      required this.infantMaxDOB,
      required this.countriesList,
      required this.mobileCountryList,
      required this.genderList,
      required this.titleList});
}

HotelPretravellerData mapHotelPretravellerData(dynamic payload) {
  List<Country> countriesList = [];
  List<Country> mobileCountryList = [];
  List<Gender> genderList = [];
  List<Gender> titleList = [];

  if (payload["countriesList"] != null) {
    payload["countriesList"].forEach((element) {
      countriesList.add(mapCountry(element));
    });
  }

  if (payload["mobileCountryList"] != null) {
    payload["mobileCountryList"].forEach((element) {
      mobileCountryList.add(mapCountry(element));
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
    adult: payload["adult"] ?? 0,
    child: payload["child"] ?? 0,
    infant: payload["infant"] ?? 0,
    adultMinDOB: payload["adultMinDOB"] != null
        ? DateTime.parse(getParsableDateString(payload["adultMinDOB"] ))
        : DefaultAdultMinimumDate,
    adultMaxDOB: payload["adultMaxDOB"] != null
        ? DateTime.parse(  getParsableDateString(payload["adultMaxDOB"] ))
        : DefaultAdultMaximumDate,
    infantMinDOB: payload["infantMinDOB"] != null
        ? DateTime.parse(   getParsableDateString(payload["infantMinDOB"] ))
        : DefaultAdultMaximumDate,
    infantMaxDOB: payload["infantMaxDOB"] != null
        ? DateTime.parse( getParsableDateString(payload["infantMaxDOB"] ))
        : DefaultAdultMaximumDate,
    childMinDOB: payload["childMinDOB"] != null
        ? DateTime.parse(  getParsableDateString(payload["childMinDOB"]) )
        : DefaultAdultMaximumDate,
    childMaxDOB: payload["childMaxDOB"] != null
        ? DateTime.parse( getParsableDateString(payload["childMaxDOB"])  )
        : DefaultAdultMaximumDate,
    countriesList: countriesList,
    mobileCountryList: mobileCountryList,
    genderList: genderList,
    titleList: titleList,
  );



}
String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}