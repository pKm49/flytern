class FlightAddonExtraPackageSelection {

  final String routeID;
  final String passengerID;
  final String extraLuaggageId;
  final double amount;
  final String currency;

  FlightAddonExtraPackageSelection({
    required this.routeID,
    required this.passengerID,
    required this.extraLuaggageId,
    required this.amount,
    required this.currency,
  });

  Map toJson() => {
    'routeID': routeID,
    'passengerID': passengerID,
    'extraLuaggageId': extraLuaggageId,
  };

}

