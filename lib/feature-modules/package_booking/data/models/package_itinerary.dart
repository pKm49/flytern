import 'package:flytern/feature-modules/package_booking/data/models/package_data.dart';
import 'package:flytern/shared-module/data/models/business_models/country.dart';

import '../../../flight_booking/data/models/business_models/cabin_class.dart';

class PackageItinerary {
  final String day;
  final String content;
  final String displayName;
  final String contactNo;

  PackageItinerary({
    required this.day,
    required this.content,
    required this.displayName,
    required this.contactNo,
  });
}

PackageItinerary mapPackageItinerary(dynamic payload) {
  return PackageItinerary(
    day: payload["Day"] ?? "",
    content: payload["Content"] ?? "",
    displayName: payload["DisplayName"] ?? "",
    contactNo: payload["ContactNo"] ?? "",
  );
}
