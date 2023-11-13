
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_segment_buggage_details.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_segment_details.dart';

class HotelSegment {
  final String travelTime;
  final String departureDate;
  final String arrivalDate;
  final String arrival;
  final String depature;
  final List<HotelSegmentDetails> flightSegmentDetails;
  final List<HotelSegmentBuggageDetails> flightSegmentBaggages;

  HotelSegment(
      {required this.travelTime,
      required this.departureDate,
      required this.arrivalDate,
      required this.arrival,
      required this.depature,
      required this.flightSegmentDetails,
      required this.flightSegmentBaggages});
}

HotelSegment mapHotelSegment(dynamic payload) {
  List<HotelSegmentDetails> flightSegmentDetails = [];
  List<HotelSegmentBuggageDetails> flightSegmentBaggages = [];
  if (payload["flightSegmentDetails"] != null) {
    payload["flightSegmentDetails"].forEach((element) {
      flightSegmentDetails.add(mapHotelSegmentDetails(element));
    });
  }
  if (payload["baggage"] != null) {
    payload["baggage"].forEach((element) {
      flightSegmentBaggages.add(mapHotelSegmentBuggageDetails(element));
    });
  }
  return HotelSegment(
    travelTime: payload["travelTime"] ?? "",
    arrival: payload["arrival"] ?? "",
    depature: payload["depature"] ?? "",
    arrivalDate: payload["arrivalDate"] ?? "",
    departureDate: payload["departureDate"] ?? "",
    flightSegmentDetails: flightSegmentDetails,
    flightSegmentBaggages: flightSegmentBaggages,
  );
}
