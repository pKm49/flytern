import 'dart:io';

class RegisterCredential {

  final String FirstName;
  final String LastName;
  final String Email;
  final String PhoneNumber;
  final String CountryCode;
  final bool IsEmailSubscription;
  final String Password;

  RegisterCredential({
    required this.FirstName,
    required this.LastName,
    required this.Email,
    required this.PhoneNumber,
    required this.CountryCode,
    required this.Password,
    required this.IsEmailSubscription,
  });

  Map toJson() => {
    'FirstName': FirstName,
    'LastName': LastName,
    'Email': Email,
    'PhoneNumber': PhoneNumber,
    'CountryCode': CountryCode,
    'Password': Password,
    'IsEmailSubscription': IsEmailSubscription,
  };

}

RegisterCredential mapRegisterCredential(dynamic payload){
  return RegisterCredential(
    FirstName :payload["FirstName"]??"",
    LastName :payload["LastName"]??"",
    Email :payload["Email"]??"",
    PhoneNumber :payload["PhoneNumber"]??"",
    CountryCode :payload["CountryCode"]??"",
    Password :payload["Password"]??"",
    IsEmailSubscription :payload["IsEmailSubscription"]??false,
  );
}
