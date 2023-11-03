import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:intl/intl.dart';

class TravelInfo {
  final int no;
  final String frequentFlyerNo;
  final String travellerType;
  final String title;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime dateOfBirth;
  final String passportNumber;
  final String nationalityCode;
  final String passportIssuedCountryCode;
  final DateTime passportExpiryDate;

  TravelInfo(
      {required this.no,
      required this.frequentFlyerNo,
      required this.travellerType,
      required this.title,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.dateOfBirth,
      required this.passportNumber,
      required this.nationalityCode,
      required this.passportIssuedCountryCode,
      required this.passportExpiryDate});

  Map toJson() => {
        'no': no,
        'frequentFlyerNo': frequentFlyerNo,
        'travellerType': travellerType,
        'title': title,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'passportExpiryDate': getFormattedDate(passportExpiryDate),
        'dateOfBirth': getFormattedDate(dateOfBirth),
        'passportNumber': passportNumber,
        'nationalityCode': nationalityCode,
        'passportIssuedCountryCode': passportIssuedCountryCode,
      };
}

TravelInfo mapTravelInfo(dynamic payload) {
  return TravelInfo(
    no: payload["no"] ?? -1,
    frequentFlyerNo: payload["frequentFlyerNo"] ?? "",
    travellerType: payload["travellerType"] ?? "",
    title: payload["title"] ?? "",
    firstName: payload["firstName"] ?? "",
    lastName: payload["lastName"] ?? "",
    gender: payload["gender"] ?? "",
    dateOfBirth: payload["dateOfBirth"] != null
        ? DateTime.parse(getParsableDateString(payload["dateOfBirth"]))
        : DefaultAdultMinimumDate,
    passportNumber: payload["passportNumber"] ?? "",
    nationalityCode: payload["nationalityCode"] ?? "",
    passportIssuedCountryCode: payload["passportIssuedCountryCode"] ?? "",
    passportExpiryDate: payload["passportExpiryDate"] != null
        ? DateTime.parse(getParsableDateString(payload["passportExpiryDate"]))
        : DefaultAdultMinimumDate,
  );
}

String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}

String getFormattedDate(DateTime dateTime) {
  final f = DateFormat('dd-MM-yyyy');
  return f.format(dateTime);
}
