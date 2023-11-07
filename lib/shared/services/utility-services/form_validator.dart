
String? checkIfEmailValid(String? email) {
  String validOtpPattern = r'(^$)|(^.*@.*\..*$)';
  RegExp validOtpRegex = new RegExp(validOtpPattern);

  if (email!.isEmpty || !validOtpRegex.hasMatch(email)) {
    return "Provide a valid Email";
  }


  return null;
}

String? checkIfMobileNumberValid(String? mobile) {
  String validMobilePattern = r'^([0-9])+$';
  RegExp validMobileRegex = new RegExp(validMobilePattern);

  if (mobile!.isEmpty || !validMobileRegex.hasMatch(mobile)) {
    return "Provide valid mobile";
  }

  return null;
}

String? checkIfPasswordFieldValid(String? password) {
  String validPasswordPattern =
      r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\S{5,}$';
  RegExp validPasswordRegex = new RegExp(validPasswordPattern);

  if (password!.isEmpty || !validPasswordRegex.hasMatch(password)) {
    return "Minimum 5 characters with atleast 1 digit and 1 letter";
  }

  return null;
}

String? checkIfConfirmPasswordFieldValid(
    String? confirmPassword, String? password) {
  String validPasswordPattern =
      r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\S{5,}$';
  RegExp validPasswordRegex = new RegExp(validPasswordPattern);

  if (confirmPassword!.isEmpty ||
      !validPasswordRegex.hasMatch(confirmPassword)) {
    return "Minimum 5 characters with atleast 1 digit and 1 letter";
  }

  if (confirmPassword != password) {
    return "Confirm password must be same as password";
  }

  return null;
}

checkIfLoginFormValid(mobile, password) {
  String validMobilePattern = r'^([0-9])+$';
  String validPasswordPattern =
      r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\S{5,}$';
  RegExp validMobileRegex = RegExp(validMobilePattern);
  RegExp validPasswordRegex = RegExp(validPasswordPattern);

  if (mobile.isEmpty || !validMobileRegex.hasMatch(mobile)) {
    return "Provide valid mobile";
  }

  if (password.isEmpty || !validPasswordRegex.hasMatch(password)) {
    return "Password must be minimum 5 characters with atleast 1 digit and 1 letter";
  }

  return "";
}

checkIfRegisterFormValid(name, mobile, password, dob, mob, yob, place, gender) {
  String validNamePattern = r'^[A-Za-z ]{3,}$';
  String validMobilePattern = r'^([0-9])+$';
  String validPasswordPattern =
      r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\S{5,}$';
  RegExp validMobileRegex = new RegExp(validMobilePattern);
  RegExp validPasswordRegex = new RegExp(validPasswordPattern);
  RegExp validNameRegex = new RegExp(validNamePattern);

  if (name.isEmpty || !validNameRegex.hasMatch(name)) {
    return "Please provide a valid name";
  }

  if (mobile.isEmpty || !validMobileRegex.hasMatch(mobile)) {
    return "Please provide a valid mobile number";
  }

  if (password.isEmpty || !validPasswordRegex.hasMatch(password)) {
    return "Password must be minimum 5 characters with atleast 1 digit and 1 letter";
  }

  if (place.isEmpty) {
    return "Please provide a valid Place";
  }

  if (place.isEmpty || gender == "Gender") {
    return "Please provide a valid Gender Type";
  }

  if (dob.isEmpty || dob == "DD") {
    return "Please provide a valid Date Of Birth";
  }

  if (mob.isEmpty || mob == "MM") {
    return "Please provide a valid Month Of Birth";
  }

  if (yob.isEmpty || yob == "YYYY") {
    return "Please provide a valid Year Of Birth";
  }

  return "";
}

String? checkIfOtpInputFormValid(String? otp) {
  String validOtpPattern = r'^[0-9]{1}$';
  RegExp validOtpRegex = new RegExp(validOtpPattern);

  if (otp!.isEmpty || !validOtpRegex.hasMatch(otp)) {
    return "Must be 1 digits";
  }

  return null;
}

String? checkIfOtpFormValid(String? otp) {
  String validOtpPattern = r'^[0-9]{6}$';
  RegExp validOtpRegex = new RegExp(validOtpPattern);

  if (otp!.isEmpty || !validOtpRegex.hasMatch(otp)) {
    return "Must be 6 digits";
  }

  return null;
}

String? checkIfNameFormValid(String? name, String fieldName) {

  if ( name!.isEmpty) {
    return "Provide valid "+fieldName;
  }

  return null;
}

