
import 'package:flytern/shared-module/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared-module/data/models/business_models/gender.dart';
import 'package:intl/intl.dart';

class UserDetails {

  final bool isGuest;
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
  final List<Gender> genders;


  UserDetails({
    required this.isGuest,
    required this.gender, required this.firstName, required this.lastName,
    required this.phoneCountryCode, required this.imgUrl, required this.passportNumber,
    required this.dateOfBirth, required this.passportIssuerCountryCode, required this.passportIssuerCountryName,
    required this.nationalityCode, required this.nationalityName,
    required this.userName,
    required this.email,
    required this.passportExpiry,
    required this.phoneNumber,
    required this.genders,
  });

  Map toJson() => {
    'Email': email,
    'FirstName': firstName,
    'LastName': lastName,
    'dateOfBirth': getFormattedDate(dateOfBirth),
    'Gender': gender,
    'Nationality': nationalityCode,
    'PassportNumber': passportNumber,
    'ExpiryDate':getFormattedDate (passportExpiry),
    'IssueCountry': passportIssuerCountryCode,
  };

}

UserDetails mapUserDetails(dynamic payload,bool isGuest){

  List<Gender> tempGenders = [];
  if(payload["genderList"] != null){
    payload["genderList"].forEach((element) {
      tempGenders.add(mapGender(element));
    });
  }
  return UserDetails(
    isGuest:isGuest,
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
    genders: tempGenders,
  );
}

String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}
String getFormattedDate(DateTime dateTime){
  final f = DateFormat('dd-MM-yyyy');
  return f.format(dateTime);
}