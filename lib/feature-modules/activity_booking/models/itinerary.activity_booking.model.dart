
class ActivityItinerary {
  final String day;
  final String content;
  final String displayName;
  final String contactNo;

  ActivityItinerary({
    required this.day,
    required this.content,
    required this.displayName,
    required this.contactNo,
  });
}

ActivityItinerary mapActivityItinerary(dynamic payload) {
  return ActivityItinerary(
    day: payload["Day"] ?? "",
    content: payload["Content"] ?? "",
    displayName: payload["DisplayName"] ?? "",
    contactNo: payload["ContactNo"] ?? "",
  );
}
