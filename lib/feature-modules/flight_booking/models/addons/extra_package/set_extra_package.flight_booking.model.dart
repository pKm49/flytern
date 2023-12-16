import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/extra_package_selection.flight_booking.model.dart';

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
    if(element != null){
      tLstOfSelection.add(element.toJson());
    }
  });

  return tLstOfSelection;
}



FlightAddonSetExtraPackage getDummyFlightAddonSetExtraPackage(dynamic payload){
  return FlightAddonSetExtraPackage(
      bookingRef:"",
      listOfSelection:[]
  );
}