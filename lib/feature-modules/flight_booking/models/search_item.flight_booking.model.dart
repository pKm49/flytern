import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:intl/intl.dart';

class FlightSearchItem {
  final FlightDestination departure;
  final FlightDestination arrival;
  final DateTime departureDate;
  final DateTime? returnDate;

  FlightSearchItem(
      {required this.departure,
      required this.arrival,
      required this.departureDate,
      required this.returnDate});

  Map toJson() => {
        'departure': departure.airportCode,
        'arrival': arrival.airportCode,
        'departureDate': getFormattedDate(departureDate),
        'returnDate':
            returnDate == null ? returnDate : getFormattedDate(returnDate!)
      };

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }
}

FlightSearchItem mapFlightSearchItem(dynamic payload) {
  return FlightSearchItem(
      departure: FlightDestination(
        airportCode: payload["departure"] ?? "",
        airportName: "",
        uniqueCombination: payload["departure"] ?? "",
        sort: 1,
        countryISOCode: "",
        flag: "",
      ),
      arrival: FlightDestination(
        airportCode: payload["arrival"] ?? "",
        airportName: "",
        uniqueCombination: payload["arrival"] ?? "",
        sort: 1,
        countryISOCode: "",
        flag: "",
      ),
      departureDate: payload["departureDate"] != null
          ? DateTime.parse(payload["departureDate"])
          : DateTime.now(),
      returnDate: payload["returnDate"] != null
          ? DateTime.parse(payload["returnDate"])
          : DateTime.now());
}

FlightSearchItem getDefaultFlightSearchItem() {
  return FlightSearchItem(
      departure: getDefaultFlightDestination(false),
      arrival: getDefaultFlightDestination(true),
      departureDate: DateTime.now(),
      returnDate: DateTime.now().add(Duration(days: 1)));
}
