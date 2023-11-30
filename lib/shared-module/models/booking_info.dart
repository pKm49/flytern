

class BookingInfo {


  final String  groupName;
  final String  title;
  final String information;

  BookingInfo({
    required this.groupName,
    required this.title,
    required this.information
  });

  Map toJson() => {
    'groupName': groupName,
    'title': title,
    'information': information
  };

}

BookingInfo mapBookingInfo(dynamic payload){
  return BookingInfo(
    groupName :payload["groupName"]??"",
    title :payload["title"]??"",
    information :payload["information"]??""
  );
}
