class HotelSegmentDetails {
  final String promoCode;
  final String depatureTerminal;
  final String arrivalTerminal;
  final bool isOperatedBy;
  final String operatingCarrier;
  final String operatingCarrierHotelNumber;
  final String originTerminal;
  final String destinationTerminal;
  final String stopover;
  final String layover;
  final String arrivalcntry;
  final String depaturecntry;
  final String arrival;
  final String depature;

  final String depaturedt;
  final String arrivaldt;
  final String depaturetime;
  final String arrivaltime;
  final String duration;
  final String cabin;
  final String flightNumber;
  final String flightName;
  final String carrier;
  final String bookingCounts;

  HotelSegmentDetails(
      {required this.depaturecntry,
      required this.promoCode,
      required this.depatureTerminal,
      required this.arrivalTerminal,
      required this.isOperatedBy,
      required this.operatingCarrier,
      required this.operatingCarrierHotelNumber,
      required this.originTerminal,
      required this.destinationTerminal,
      required this.stopover,
      required this.layover,
      required this.arrivalcntry,
      required this.arrival,
      required this.depature,
      required this.depaturedt,
      required this.arrivaldt,
      required this.depaturetime,
      required this.arrivaltime,
      required this.duration,
      required this.cabin,
      required this.flightNumber,
      required this.flightName,
      required this.carrier,
      required this.bookingCounts});
}

HotelSegmentDetails mapHotelSegmentDetails(dynamic payload) {


  return HotelSegmentDetails(
    depaturecntry: payload["depaturecntry"] ?? "-1",
    promoCode: payload["promoCode"] ?? "",
    layover: payload["layover"] ?? "",
    arrivalcntry: payload["arrivalcntry"] ?? "",
    arrival: payload["arrival"] ?? "",
    depature:payload["depature"] ?? "",
    arrivalTerminal: payload["arrivalTerminal"] ?? "",
    depatureTerminal: payload["depatureTerminal"] ?? "",
    destinationTerminal: payload["destinationTerminal"] ??"",
    isOperatedBy: payload["isOperatedBy"] ?? false,
    operatingCarrier: payload["operatingCarrier"] ?? "",
    operatingCarrierHotelNumber:
        payload["operatingCarrierHotelNumber"] ?? "",
    originTerminal: payload["originTerminal"] ??"",
    stopover: payload["stopover"] ??"",
    depaturedt: payload["depaturedt"] ??"",
    arrivaldt: payload["arrivaldt"] ??"",
    depaturetime: payload["depaturetime"] ??"",
    arrivaltime: payload["arrivaltime"] ??"",
    duration: payload["duration"] ??"",
    cabin: payload["cabin"] ??"",
    flightNumber: payload["flightNumber"] ??"",
    flightName: payload["flightName"] ??"",
    carrier: payload["carrier"] ??"",
    bookingCounts: payload["bookingCounts"] ??"",
  );
}
