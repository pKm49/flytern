import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:intl/intl.dart';

class FlightSearchItem {

  final FlightDestination departure;
  final FlightDestination arrival;
  final DateTime departureDate;
  final DateTime returnDate; 

  FlightSearchItem({
    required this.departure,
    required this.arrival, 
    required this.departureDate,
    required this.returnDate 
  });

  Map toJson() => {
    'departure': departure.airportCode,
    'arrival': arrival.airportCode,
    'departureDate': getFormattedDate(departureDate),
    'returnDate': getFormattedDate(returnDate)
  };

  String getFormattedDate(DateTime dateTime){
    final f = DateFormat('dd-MM-yyyy');
    return f.format(dateTime);
  }
} 