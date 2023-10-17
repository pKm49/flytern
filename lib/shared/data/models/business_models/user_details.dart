
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';

class UserDetails {


  final String  userName;
  final String  email;
  final String phoneNumber;
  final String gender;
  final String firstName;
  final String lastName;
  final String phoneCountryCode;
  final String imgUrl;
  final String passportNumber;
  final DateTime passportExpiry;
  final DateTime dateOfBirth;
  final String passportIssuerCountryCode;
  final String passportIssuerCountryName;
  final String nationalityCode;
  final String nationalityName;


  UserDetails({
    required this.gender, required this.firstName, required this.lastName,
    required this.phoneCountryCode, required this.imgUrl, required this.passportNumber,
    required this.dateOfBirth, required this.passportIssuerCountryCode, required this.passportIssuerCountryName,
    required this.nationalityCode, required this.nationalityName,
    required this.userName,
    required this.email,
    required this.passportExpiry,
    required this.phoneNumber,
  });

  Map toJson() => {
    'Email': email,
    'FirstName': firstName,
    'LastName': lastName,
    'dateOfBirth': dateOfBirth,
    'Gender': gender,
    'Nationality': nationalityCode,
    'PassportNumber': passportNumber,
    'ExpiryDate': passportExpiry,
    'IssueCountry': passportIssuerCountryCode,
  };

}

UserDetails mapUserDetails(dynamic payload){
  return UserDetails(
    phoneNumber:payload["phoneNumber"]??"",
    userName :payload["userName"]??"",
    email :payload["email"]??"",
    passportExpiry :(payload["passportExpiry"] != null && payload["passportExpiry"] != "")?

    DateTime.parse(getParsableDateString(payload["passportExpiry"])): DefaultInvalidDate,
    gender: payload["gender"]??"",
    firstName: payload["firstName"]??"",
    lastName: payload["lastName"]??"",
    phoneCountryCode: payload["phoneCountryCode"]??"",
    imgUrl: payload["imgUrl"]??"",
    passportNumber: payload["passportNumber"]??"",
    dateOfBirth: (payload["dateOfBirth"] != null && payload["dateOfBirth"] != "")?
    DateTime.parse(getParsableDateString(payload["dateOfBirth"])): DefaultInvalidDate,
    passportIssuerCountryCode: payload["passportIssuerCountryCode"]??"",
    passportIssuerCountryName: payload["passportIssuerCountryName"]??"",
    nationalityCode:payload["nationalityCode"]??"",
    nationalityName: payload["nationalityName"]??"",
  );
}

String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}
