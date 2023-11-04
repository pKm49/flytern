import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';
import 'package:intl/intl.dart';

class PackageSubmissionData {

  final int packageID;
  final String mobileCntry;
  final String mobileNumber;
  final String email;

  PackageSubmissionData({
    required this.packageID,
    required this.mobileCntry,
    required this.mobileNumber,
    required this.email,
  });

  Map toJson() => {
        'packageID': packageID,
        '_CntDc': {
          'mobileCntry': mobileCntry,
          'mobileNumber': mobileNumber,
          'email': email,
        }
      };

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }

}
