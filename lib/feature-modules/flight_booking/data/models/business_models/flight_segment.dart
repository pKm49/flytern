import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_segment_buggage_details.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_segment_details.dart';

class FlightSegment {
  final String travelTime;
  final String departureDate;
  final String arrivalDate;
  final String arrival;
  final String depature;
  final List<FlightSegmentDetails> flightSegmentDetails;
  final List<FlightSegmentBuggageDetails> flightSegmentBaggages;

  FlightSegment(
      {required this.travelTime,
      required this.departureDate,
      required this.arrivalDate,
      required this.arrival,
      required this.depature,
      required this.flightSegmentDetails,
      required this.flightSegmentBaggages});
}

FlightSegment mapFlightSegment(dynamic payload) {
  List<FlightSegmentDetails> flightSegmentDetails = [];
  List<FlightSegmentBuggageDetails> flightSegmentBaggages = [];
  if (payload["flightSegmentDetails"] != null) {
    payload["flightSegmentDetails"].forEach((element) {
      flightSegmentDetails.add(mapFlightSegmentDetails(element));
    });
  }
  if (payload["baggage"] != null) {
    payload["baggage"].forEach((element) {
      flightSegmentBaggages.add(mapFlightSegmentBuggageDetails(element));
    });
  }
  return FlightSegment(
    travelTime: payload["travelTime"] ?? "",
    arrival: payload["arrival"] ?? "",
    depature: payload["depature"] ?? "",
    arrivalDate: payload["arrivalDate"] ?? "",
    departureDate: payload["departureDate"] ?? "",
    flightSegmentDetails: flightSegmentDetails,
    flightSegmentBaggages: flightSegmentBaggages,
  );
}
