import 'package:flytern/feature-modules/flight_booking/models/addons/seat/flight_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/passenger.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/route.flight_booking.model.dart';

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
    if(element != null){
      routes.add(mapFlightAddonRoute(element));
    }
  });

  payload["passengers"].forEach((element) {
    if(element != null){
      passengers.add(mapFlightAddonPassenger(element));
    }
  });

  payload["flightClass"].forEach((element) {
    if(element != null){
      flightClass.add(mapFlightAddonFlightClass(element));
    }
  });

  return FlightAddonGetSeat(
    routes :routes,
    passengers :passengers,
    flightClass :flightClass,
  );

}
