import 'package:flytern/feature-modules/flight_booking/models/addons/seat/flight_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/meal/meal.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/passenger.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/route.flight_booking.model.dart';

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