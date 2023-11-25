import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:intl/intl.dart';

class FlightSearchResponseDtoSegment {

  final String fromCountry;
  final String toCountry;
  final String cabin;
  final String baggageDisplay;
  final int stops;
  final String departureTime;
  final String departureDate;
  final String to;
  final String arrivalTime;
  final String arrivalDate;
  final String from;
  final String flightNumber;
  final String travelTime;

  FlightSearchResponseDtoSegment({
    required this.fromCountry,
    required this.toCountry,
    required this.cabin,
    required this.baggageDisplay,
    required this.stops,
    required this.departureTime,
    required this.departureDate,
    required this.to,
    required this.arrivalTime,
    required this.arrivalDate,
    required this.from,
    required this.flightNumber,
    required this.travelTime
  });



}

FlightSearchResponseDtoSegment mapFlightSearchResponseDtoSegment(dynamic payload) {
  return FlightSearchResponseDtoSegment(
      fromCountry:payload["fromCountry"]??"",
      toCountry:payload["toCountry"]??"",
      cabin:payload["cabin"]??"",
      baggageDisplay:payload["baggageDisplay"]??"",
      stops:payload["stops"]??0,
      departureTime:payload["departureTime"]??"",
      departureDate:payload["departureDate"]??"",
      to:payload["to"]??"",
      arrivalTime:payload["arrivalTime"]??"",
      arrivalDate:payload["arrivalDate"]??"",
      from:payload["from"]??"",
      flightNumber:payload["flightNumber"]??"",
      travelTime:payload["travelTime"]??""
  );
}