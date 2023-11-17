class Notification {

  final bool isRedirection;
  final String redirectionUrl;
  final String header;
  final String information;
  final String entryOn; 

  Notification({
    required this.isRedirection,
    required this.redirectionUrl, 
    required this.header,
    required this.information,
    required this.entryOn,
  });

  Map toJson() => {
    'isRedirection': isRedirection,
    'redirectionUrl': redirectionUrl,
    'header': header,
    'information': information,
    'entryOn': entryOn,
  };

}

Notification mapNotification(dynamic payload){
  return Notification(
    isRedirection :payload["isRedirection"]??false,
    redirectionUrl :payload["redirectionUrl"]??"",
    header :payload["header"]??"",
    information :payload["information"]??"",
    entryOn :payload["entryOn"]??"En",
  );
}
