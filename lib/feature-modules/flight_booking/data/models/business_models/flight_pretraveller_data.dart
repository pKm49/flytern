import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_allowed_cabin.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/gender.dart';

class FlightPretravellerData {
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

  FlightPretravellerData(
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

FlightPretravellerData mapFlightPretravellerData(dynamic payload) {
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
      genderList.add(mapGender(element));
    });
  }

  return FlightPretravellerData(
    adult: payload["adult"] ?? 0,
    child: payload["child"] ?? 0,
    infant: payload["infant"] ?? 0,
    adultMinDOB: payload["adultMinDOB"] != null
        ? DateTime.parse(payload["adultMinDOB"])
        : DefaultAdultMinimumDate,
    adultMaxDOB: payload["adultMaxDOB"] != null
        ? DateTime.parse(payload["adultMaxDOB"])
        : DefaultAdultMaximumDate,
    infantMinDOB: payload["infantMinDOB"] != null
        ? DateTime.parse(payload["infantMinDOB"])
        : DefaultAdultMaximumDate,
    infantMaxDOB: payload["infantMaxDOB"] != null
        ? DateTime.parse(payload["infantMaxDOB"])
        : DefaultAdultMaximumDate,
    childMinDOB: payload["childMinDOB"] != null
        ? DateTime.parse(payload["childMinDOB"])
        : DefaultAdultMaximumDate,
    childMaxDOB: payload["childMaxDOB"] != null
        ? DateTime.parse(payload["childMaxDOB"])
        : DefaultAdultMaximumDate,
    countriesList: countriesList,
    mobileCountryList: mobileCountryList,
    genderList: genderList,
    titleList: titleList,
  );
}