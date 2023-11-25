

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
