
import 'package:get/get.dart';

String? checkIfEmailValid(String? email) {
  String validOtpPattern = r'(^$)|(^.*@.*\..*$)';
  RegExp validOtpRegex = new RegExp(validOtpPattern);

  if (email!.isEmpty || !validOtpRegex.hasMatch(email)) {
    return "provide_valid_item".tr.replaceAll("item", "email".tr);
  }


  return null;
}

String? checkIfMobileNumberValid(String? mobile) {
  String validMobilePattern = r'^([0-9])+$';
  RegExp validMobileRegex = new RegExp(validMobilePattern);

  if (mobile!.isEmpty || !validMobileRegex.hasMatch(mobile)) {
    return "provide_valid_item".tr.replaceAll("item", "mobile".tr);

  }

  return null;
}

String? checkIfPasswordFieldValid(String? password) {
  String validPasswordPattern =
      r'^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)\S{5,}$';
  RegExp validPasswordRegex = new RegExp(validPasswordPattern);

  if (password!.isEmpty || !validPasswordRegex.hasMatch(password)) {
    return "password_criteria".tr;
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
    return "password_criteria".tr;
  }

  if (confirmPassword != password) {
    return "confirm_password_error".tr;
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
    return "provide_valid_item".tr.replaceAll("item", "mobile".tr);
  }

  if (password.isEmpty || !validPasswordRegex.hasMatch(password)) {
    return "password_criteria".tr;
  }

  return "";
}

String? checkIfNameFormValid(String? name, String fieldName) {

  if ( name!.isEmpty) {
    return "provide_valid_item".tr.replaceAll("item", fieldName);
  }

  if(fieldName== "first_name".tr || fieldName== "last_name".tr){
    if(name.length <3){
      return "provide_valid_item".tr.replaceAll("item", fieldName);
    }
  }

  return null;
}

String? checkIfDropDownFormValid(String? selectedId,String DefaultId, String fieldName) {

  if ( selectedId == DefaultId) {
    return "provide_valid_item".tr.replaceAll("item", fieldName);

  }

  return null;
}
