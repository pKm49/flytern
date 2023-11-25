import 'package:flytern/feature-modules/insurance/models/traveller_info.insurance.model.dart';
import 'package:intl/intl.dart';

class InsuranceTravellerData {
  final List<InsuranceTravellerInfo> travellerinfo;

  final String covid;
  final String policyType;
  final int contributor;
  final int son;
  final int daughter;
  final int spouse;
  final String policyPlan;
  final String policyDuration;
  final DateTime policyDate;

  final String mobileCntry;
  final String mobileNumber;
  final String email;

  InsuranceTravellerData({
    required this.travellerinfo,
    required this.covid,
    required this.policyType,
    required this.contributor,
    required this.son,
    required this.daughter,
    required this.spouse,
    required this.policyPlan,
    required this.policyDuration,
    required this.policyDate,
    required this.mobileCntry,
    required this.mobileNumber,
    required this.email,
  });

  Map toJson() => {
        '_Travellerinfo': getTravellerInfo(),
        '_PolicyInfo': {
          'covid': covid,
          'policyType': policyType,
          'contributor': contributor,
          'son': son,
          'daughter': daughter,
          'spouse': spouse,
          'policyPlan': policyPlan,
          'policyDuration': policyDuration,
          'policyDate': getFormattedDate(policyDate),
        },
        '_ContactInfo': {
          'mobileCntry': mobileCntry,
          'mobileNumber': mobileNumber,
          'email': email,
        }
      };

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }

  getTravellerInfo() {
    List<dynamic> travellers = [];
    travellerinfo.forEach((element) {
      travellers.add(element.toJson());
    });
    return travellers;
  }
}
