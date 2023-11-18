class FlightAddonExtraPackageSelection {

  final String routeID;
  final String passengerID;
  final String extraLuaggageId;

  FlightAddonExtraPackageSelection({
    required this.routeID,
    required this.passengerID,
    required this.extraLuaggageId,
  });

  Map toJson() => {
    'routeID': routeID,
    'passengerID': passengerID,
    'extraLuaggageId': extraLuaggageId,
  };

}

