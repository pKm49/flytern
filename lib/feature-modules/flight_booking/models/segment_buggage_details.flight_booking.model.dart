class FlightSegmentBuggageDetails {
  final String cabin;
  final String passTy;

  FlightSegmentBuggageDetails({
    required this.cabin,
    required this.passTy,
  });
}

FlightSegmentBuggageDetails mapFlightSegmentBuggageDetails(dynamic payload) {
  return FlightSegmentBuggageDetails(
    cabin: payload["cabin"] ?? "",
    passTy: payload["passTy"] ?? "",
  );
}
