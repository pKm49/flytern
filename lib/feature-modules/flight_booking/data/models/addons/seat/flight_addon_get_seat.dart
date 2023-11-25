import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_flight_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_passenger.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_route.dart';

class FlightAddonGetSeat {

  final List<FlightAddonRoute> routes;
  final List<FlightAddonPassenger> passengers;
  final List<FlightAddonFlightClass> flightClass;

  FlightAddonGetSeat({
    required this.routes,
    required this.passengers,
    required this.flightClass
  });

}

FlightAddonGetSeat mapFlightAddonGetSeat(dynamic payload){

  List<FlightAddonRoute> routes = [];
  List<FlightAddonPassenger> passengers = [];
  List<FlightAddonFlightClass> flightClass = [];

  payload["routes"].forEach((element) {
    routes.add(mapFlightAddonRoute(element));
  });

  payload["passengers"].forEach((element) {
    passengers.add(mapFlightAddonPassenger(element));
  });

  payload["flightClass"].forEach((element) {
    flightClass.add(mapFlightAddonFlightClass(element));
  });

  return FlightAddonGetSeat(
    routes :routes,
    passengers :passengers,
    flightClass :flightClass,
  );

}
