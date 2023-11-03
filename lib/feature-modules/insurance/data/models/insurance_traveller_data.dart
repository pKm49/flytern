 import 'package:flytern/feature-modules/insurance/data/models/insurance_traveller_info.dart';

class InsuranceTravellerData {

  final List<InsuranceTravellerInfo> travellerinfo;

  final String covid;
  final String policyType;
  final String contributor;
  final String son;
  final String daughter;
  final String spouse;
  final String policyPlan;
  final String policyDuration;
  final String policyDate;

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

    '_PolicyInfo':{
      'covid': covid,
      'policyType': policyType,
      'contributor': contributor,
      'son': son,
      'daughter': daughter,
      'spouse': spouse,
      'policyPlan': policyPlan,
      'policyDuration': policyDuration,
      'policyDate': policyDate,
    },
    '_ContactInfo':{
      'mobileCntry': mobileCntry,
      'mobileNumber': mobileNumber,
      'email': email,
    }
  };

  getTravellerInfo() {
    List<dynamic> travellers = [];
    travellerinfo.forEach((element) {
      travellers.add(element.toJson());
    });
    return travellers;
  }

}

