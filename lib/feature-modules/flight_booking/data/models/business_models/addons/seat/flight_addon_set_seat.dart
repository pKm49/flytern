 import 'package:flytern/feature-modules/flight_booking/data/models/business_models/addons/seat/flight_addon_seat_selection.dart';

class FlightAddonSetSeat {
  final String bookingRef;
  final List<FlightAddonSeatSelection> listOfSelection;

  FlightAddonSetSeat(
      {required this.bookingRef, required this.listOfSelection});

  Map toJson() => {
        'bookingRef': bookingRef,
        '_listOfSelection': getListOfSelection(listOfSelection),
      };
}

List<dynamic> getListOfSelection(List<FlightAddonSeatSelection> listOfSelection) {
  List<dynamic> tLstOfSelection = [];

  listOfSelection.forEach((element) {
    tLstOfSelection.add(element.toJson());
  });

  return tLstOfSelection;
}

 FlightAddonSetSeat getDummyFlightAddonSetSeat(dynamic payload){
  return FlightAddonSetSeat(
      bookingRef:"",
      listOfSelection:[]
  );
 }