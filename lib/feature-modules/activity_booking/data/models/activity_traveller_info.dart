import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:intl/intl.dart';

class ActivityTravellerInfo {
  final String prefix;
  final String firstName;
  final String lastName;
  final String nationalityCode;
  final String specialRequest;
  final String email;
  final String mobile;
  final String mobileCountryCode;

  ActivityTravellerInfo(
      {required this.prefix,
      required this.firstName,
      required this.lastName,
      required this.nationalityCode,
      required this.specialRequest,
      required this.email,
      required this.mobile,
      required this.mobileCountryCode});

  Map toJson() => {
        'prefix': prefix,
        'mobileCountryCode': mobileCountryCode,
        'mobile': mobile,
        'email': email,
        'specialRequest': specialRequest,
        'firstName': firstName,
        'lastName': lastName,
        'nationalityCode': nationalityCode,
      };
}

