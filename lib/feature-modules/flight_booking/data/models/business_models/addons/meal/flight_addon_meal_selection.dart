class FlightAddonMealSelection {

  final String routeID;
  final String passengerID;
  final String mealId;

  FlightAddonMealSelection({
    required this.routeID,
    required this.passengerID,
    required this.mealId,
  });

  Map toJson() => {
    'routeID': routeID,
    'passengerID': passengerID,
    'mealId': mealId,
  };

}

