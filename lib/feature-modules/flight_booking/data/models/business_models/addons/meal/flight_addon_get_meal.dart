import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/seat/flight_addon_flight_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/meal/flight_addon_meal.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/flight_addon_passenger.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/flight_addon_route.dart';

class FlightAddonGetMeal {

  final List<FlightAddonRoute> routes;
  final List<FlightAddonPassenger> passengers;
  final List<FlightAddonMeal> meals;

  FlightAddonGetMeal({
    required this.routes,
    required this.passengers,
    required this.meals
  });

}

FlightAddonGetMeal mapFlightAddonGetMeal(dynamic payload){

  List<FlightAddonRoute> routes = [];
  List<FlightAddonPassenger> passengers = [];
  List<FlightAddonMeal> meals = [];

  payload["routes"].forEach((element) {
    routes.add(mapFlightAddonRoute(element));
  });

  payload["passengers"].forEach((element) {
    passengers.add(mapFlightAddonPassenger(element));
  });

  payload["meals"].forEach((element) {
    meals.add(mapFlightAddonMeal(element));
  });

  return FlightAddonGetMeal(
    routes :routes,
    passengers :passengers,
    meals :meals,
  );

}
