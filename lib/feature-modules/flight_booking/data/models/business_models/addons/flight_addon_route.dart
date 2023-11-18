class FlightAddonRoute {

  final String routeID;
  final String groupName;
  final String groupCode;
  final String from;
  final String to; 

  FlightAddonRoute({
    required this.routeID,
    required this.groupName, 
    required this.groupCode,
    required this.from,
    required this.to,
  });



}

FlightAddonRoute mapFlightAddonRoute(dynamic payload){
  return FlightAddonRoute(
    routeID :payload["routeID"]??"-1",
    groupName :payload["groupName"]??"",
    groupCode :payload["groupCode"]??"",
    from :payload["from"]??"",
    to :payload["to"]??"",
  );
}
