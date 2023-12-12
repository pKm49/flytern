import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:intl/intl.dart';

class InsuranceTravellerInfo {
 
  final String relationshipCode;
  final String firstName;
  final String lastName;
  final String selectedCopaxId;
  final String gender;
  final DateTime dateOfBirth;
  final String passportNumber;
  final String nationalityCode;
  final String civilID; 

  InsuranceTravellerInfo(
      {
      required this.relationshipCode,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.selectedCopaxId,
      required this.dateOfBirth,
      required this.passportNumber,
      required this.nationalityCode,
      required this.civilID });

  Map toJson() => {
        'relationshipCode': relationshipCode,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'dateOfBirth': getFormattedDate(dateOfBirth),
        'passportNumber': passportNumber,
        'nationalityCode': nationalityCode,
        'civilID': civilID,
      };
}

InsuranceTravellerInfo mapInsuranceTravellerInfo(dynamic payload) {
  return InsuranceTravellerInfo(
    firstName: payload["firstName"] ?? "",
    lastName: payload["lastName"] ?? "",
    gender: payload["gender"] ?? "",
    selectedCopaxId: payload["selectedCopaxId"] ?? "0",
    dateOfBirth: payload["dateOfBirth"] != null
        ? DateTime.parse(getParsableDateString(payload["dateOfBirth"]))
        : DefaultAdultMinimumDate,
    passportNumber: payload["passportNumber"] ?? "",
    nationalityCode: payload["nationalityCode"] ?? "",
    relationshipCode: payload["relationshipCode"] ?? "",
    civilID: payload["civilID"] ?? "",
  );
}

String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}

String getFormattedDate(DateTime dateTime) {
  final f = DateFormat('dd-MM-yyyy');
  return f.format(dateTime);
}
