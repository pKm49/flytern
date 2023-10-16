class RegisterCredential {

  final String FirstName;
  final String LastName;
  final String Email;
  final String PhoneNumber;
  final String CountryCode;
  final String File;
  final String Password;

  RegisterCredential({
    required this.FirstName,
    required this.LastName,
    required this.Email,
    required this.PhoneNumber,
    required this.CountryCode,
    required this.File,
    required this.Password,
  });

  Map toJson() => {
    'FirstName': FirstName,
    'LastName': LastName,
    'Email': Email,
    'PhoneNumber': PhoneNumber,
    'CountryCode': CountryCode,
    'File': File,
    'Password': Password,
  };

}

RegisterCredential mapRegisterCredential(dynamic payload){
  return RegisterCredential(
    FirstName :payload["FirstName"]??"",
    LastName :payload["LastName"]??"",
    Email :payload["Email"]??"",
    PhoneNumber :payload["PhoneNumber"]??"",
    CountryCode :payload["CountryCode"]??"",
    File :payload["File"]??"",
    Password :payload["Password"]??"",
  );
}
