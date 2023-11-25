class FlightAddonMeal {

  final String mealId;
  final String routeID;
  final String name;
  final double price;
  final String unit; 
  final bool isSelectedByDefault;

  FlightAddonMeal({
    required this.mealId,
    required this.routeID, 
    required this.name,
    required this.price,
    required this.unit,
    required this.isSelectedByDefault,
  });



}

FlightAddonMeal mapFlightAddonMeal(dynamic payload){
  return FlightAddonMeal(
    mealId :payload["mealId"]??"-1",
    routeID :payload["routeID"]??"-1",
    name :payload["name"]??"",
    price :payload["price"]??0.0,
    unit :payload["unit"]??"",
    isSelectedByDefault :payload["isSelectedByDefault"]??false,
  );
}
