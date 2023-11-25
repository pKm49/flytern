class FlightAddonExtraPackage {

  final String extraLuaggeId;
  final String routeID;
  final String name;
  final double weight;
  final String unit; 
  final bool isSelectedByDefault;

  FlightAddonExtraPackage({
    required this.extraLuaggeId,
    required this.routeID, 
    required this.name,
    required this.weight,
    required this.unit,
    required this.isSelectedByDefault,
  });



}

FlightAddonExtraPackage mapFlightAddonExtraPackage(dynamic payload){
  return FlightAddonExtraPackage(
    extraLuaggeId :payload["extraLuaggeId"]??"-1",
    routeID :payload["routeID"]??"-1",
    name :payload["name"]??"",
    weight :payload["weight"]??"",
    unit :payload["unit"]??"",
    isSelectedByDefault :payload["isSelectedByDefault"]??false,
  );
}
