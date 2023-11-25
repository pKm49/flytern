  import 'package:flytern/feature-modules/flight_booking/models/addons/meal/meal_selection.flight_booking.model.dart';

class FlightAddonSetMeal {
  final String bookingRef;
  final List<FlightAddonMealSelection> listOfSelection;

  FlightAddonSetMeal(
      {required this.bookingRef, required this.listOfSelection});

  Map toJson() => {
        'bookingRef': bookingRef,
        '_listOfSelection': getListOfSelection(listOfSelection),
      };
}

List<dynamic> getListOfSelection(List<FlightAddonMealSelection> listOfSelection) {
  List<dynamic> tLstOfSelection = [];

  listOfSelection.forEach((element) {
    tLstOfSelection.add(element.toJson());
  });

  return tLstOfSelection;
}

  FlightAddonSetMeal getDummyFlightAddonSetMeal(dynamic payload){
    return FlightAddonSetMeal(
        bookingRef:"",
        listOfSelection:[]
    );
  }