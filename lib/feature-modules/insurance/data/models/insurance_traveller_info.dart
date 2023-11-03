import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:intl/intl.dart';

class InsuranceTravellerInfo {
 
  final String relationshipCode;
  final String firstName;
  final String lastName;
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


String getFormattedDate(DateTime dateTime) {
  final f = DateFormat('dd-MM-yyyy');
  return f.format(dateTime);
}
