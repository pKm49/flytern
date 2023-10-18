
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:intl/intl.dart';

class UserCoPax {

  final String gender;
  final String firstName;
  final String lastName;  
  final String passportNumber;
  final DateTime passportExp;
  final DateTime dateOfBirth;
  final String passportIssuedCountryCode;
  final String passportIssuedCountryName;
  final String nationalityCode;
  final String nationalityName;


  UserCoPax({
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.passportNumber,
    required this.dateOfBirth,
    required this.passportIssuedCountryCode,
    required this.passportIssuedCountryName,
    required this.nationalityCode,
    required this.nationalityName,
    required this.passportExp,
  });

  Map toJson() => {
    'FirstName': firstName,
    'LastName': lastName,
    'dateOfBirth': getFormattedDate(dateOfBirth),
    'Gender': gender,
    'Nationality': nationalityCode,
    'PassportNumber': passportNumber,
    'ExpiryDate':getFormattedDate (passportExp),
    'IssueCountry': passportIssuedCountryCode,
  };

}

UserCoPax mapUserCoPax(dynamic payload){
  return UserCoPax(
    passportExp :(payload["passportExp"] != null && payload["passportExp"] != "")?
    DateTime.parse(getParsableDateString(payload["passportExp"])): DefaultInvalidDate,
    gender: payload["gender"]??"",
    firstName: payload["firstName"]??"",
    lastName: payload["lastName"]??"",
    passportNumber: payload["passportNumber"]??"",
    dateOfBirth: (payload["dateOfBirth"] != null && payload["dateOfBirth"] != "")?
    DateTime.parse(getParsableDateString(payload["dateOfBirth"])): DefaultInvalidDate,
    passportIssuedCountryCode: payload["passportIssuedCountryCode"]??"",
    passportIssuedCountryName: payload["passportIssuedCountryName"]??"",
    nationalityCode:payload["nationalityCode"]??"",
    nationalityName: payload["nationalityName"]??"",
  );
}

String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}

String getFormattedDate(DateTime dateTime){
  final f = DateFormat('dd-MM-yyyy');
  return f.format(dateTime);
}
