class FlightAddonMealSelection {

  final String routeID;
  final String passengerID;
  final String mealId;
  final double amount;
  final String currency;

  FlightAddonMealSelection({
    required this.routeID,
    required this.passengerID,
    required this.mealId,
    required this.amount,
    required this.currency,
  });

  Map toJson() => {
    'routeID': routeID,
    'passengerID': passengerID,
    'mealId': mealId,
  };

}

