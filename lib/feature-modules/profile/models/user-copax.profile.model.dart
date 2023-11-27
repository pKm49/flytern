
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:intl/intl.dart';

class UserCoPax {

  final int id;
  final String gender;
  final String title;
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
    required this.id,
    required this.title,
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

    'id': id,
    'title': title,
    'firstName': firstName,
    'lastName': lastName,
    'dateOfBirth': getFormattedDate(dateOfBirth),
    'gender': gender,
    'nationalityCode': nationalityCode,
    'passportNumber': passportNumber,
    'passportExp':getFormattedDate (passportExp),
    'passportIssuedCountryCode': passportIssuedCountryCode,
  };

}

UserCoPax mapUserCoPax(dynamic payload){
  return UserCoPax(
    passportExp :(payload["passportExp"] != null && payload["passportExp"] != "")?
    DateTime.parse(getParsableDateString(payload["passportExp"])): DefaultInvalidDate,
    title: payload["title"]??"Mr",
    gender: payload["gender"]??"",
    id: payload["id"]??-1,
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
