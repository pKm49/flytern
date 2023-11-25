import 'package:flytern/feature-modules/flight_booking/data/models/addons/extra_package/flight_addon_extra_package.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/extra_package/flight_addon_extra_package_selection.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/seat/flight_addon_flight_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_passenger.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/addons/flight_addon_route.dart';

class FlightAddonSetExtraPackage {
  final String bookingRef;
  final List<FlightAddonExtraPackageSelection> listOfSelection;

  FlightAddonSetExtraPackage(
      {required this.bookingRef, required this.listOfSelection});

  Map toJson() => {
        'bookingRef': bookingRef,
        '_listOfSelection': getListOfSelection(listOfSelection),
      };
}

List<dynamic> getListOfSelection(List<FlightAddonExtraPackageSelection> listOfSelection) {
  List<dynamic> tLstOfSelection = [];

  listOfSelection.forEach((element) {
    tLstOfSelection.add(element.toJson());
  });

  return tLstOfSelection;
}



FlightAddonSetExtraPackage getDummyFlightAddonSetExtraPackage(dynamic payload){
  return FlightAddonSetExtraPackage(
      bookingRef:"",
      listOfSelection:[]
  );
}