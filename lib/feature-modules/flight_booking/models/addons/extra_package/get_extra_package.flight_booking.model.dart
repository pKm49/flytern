import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/extra_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/flight_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/passenger.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/route.flight_booking.model.dart';

class FlightAddonGetExtraPackage {

  final List<FlightAddonRoute> routes;
  final List<FlightAddonPassenger> passengers;
  final List<FlightAddonExtraPackage> extraPackages;

  FlightAddonGetExtraPackage({
    required this.routes,
    required this.passengers,
    required this.extraPackages
  });

}

FlightAddonGetExtraPackage mapFlightAddonGetExtraPackage(dynamic payload){

  List<FlightAddonRoute> routes = [];
  List<FlightAddonPassenger> passengers = [];
  List<FlightAddonExtraPackage> extraPackages = [];

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

  payload["extraPackages"].forEach((element) {
    if(element != null){
      extraPackages.add(mapFlightAddonExtraPackage(element));
    }
  });

  return FlightAddonGetExtraPackage(
    routes :routes,
    passengers :passengers,
    extraPackages :extraPackages,
  );

}
