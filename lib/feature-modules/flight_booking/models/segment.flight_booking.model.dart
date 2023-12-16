import 'package:flytern/feature-modules/flight_booking/models/segment_buggage_details.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/segment_details.flight_booking.model.dart';

class FlightSegment {
  final String travelTime;
  final String departureDate;
  final String arrivalDate;
  final String arrival;
  final String departure;
  final List<FlightSegmentDetails> flightSegmentDetails;
  final List<FlightSegmentBuggageDetails> flightSegmentBaggages;

  FlightSegment(
      {required this.travelTime,
      required this.departureDate,
      required this.arrivalDate,
      required this.arrival,
      required this.departure,
      required this.flightSegmentDetails,
      required this.flightSegmentBaggages});
}

FlightSegment mapFlightSegment(dynamic payload) {
  List<FlightSegmentDetails> flightSegmentDetails = [];
  List<FlightSegmentBuggageDetails> flightSegmentBaggages = [];
  if (payload["flightSegmentDetails"] != null) {
    payload["flightSegmentDetails"].forEach((element) {
      if(element != null){
        flightSegmentDetails.add(mapFlightSegmentDetails(element));
      }

    });
  }
  if (payload["baggage"] != null) {
    payload["baggage"].forEach((element) {
      if(element != null){
        flightSegmentBaggages.add(mapFlightSegmentBuggageDetails(element));
      }

    });
  }
  return FlightSegment(
    travelTime: payload["travelTime"] ?? "",
    arrival: payload["arrival"] ?? "",
    departure: payload["departure"] ?? "",
    arrivalDate: payload["arrivalDate"] ?? "",
    departureDate: payload["departureDate"] ?? "",
    flightSegmentDetails: flightSegmentDetails,
    flightSegmentBaggages: flightSegmentBaggages,
  );
}
