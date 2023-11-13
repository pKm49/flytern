class HotelSegmentBuggageDetails {
  final String cabin;
  final String passTy;

  HotelSegmentBuggageDetails({
    required this.cabin,
    required this.passTy,
  });
}

HotelSegmentBuggageDetails mapHotelSegmentBuggageDetails(dynamic payload) {
  return HotelSegmentBuggageDetails(
    cabin: payload["cabin"] ?? "",
    passTy: payload["passTy"] ?? "",
  );
}
