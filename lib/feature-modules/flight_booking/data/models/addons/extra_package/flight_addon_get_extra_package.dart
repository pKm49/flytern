import 'package:flytern/feature-modules/flight_booking/data/models/addons/extra_package/flight_addon_extra_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_flight_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_passenger.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_route.dart';

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
    routes.add(mapFlightAddonRoute(element));
  });

  payload["passengers"].forEach((element) {
    passengers.add(mapFlightAddonPassenger(element));
  });

  payload["extraPackages"].forEach((element) {
    extraPackages.add(mapFlightAddonExtraPackage(element));
  });

  return FlightAddonGetExtraPackage(
    routes :routes,
    passengers :passengers,
    extraPackages :extraPackages,
  );

}
