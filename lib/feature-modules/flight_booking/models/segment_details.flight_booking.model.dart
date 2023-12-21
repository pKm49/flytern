class FlightSegmentDetails {

  final String carrierImageUrl;
  final String operatingCarrierImageUrl;
  final String operatingCarrierName;
  final String promoCode;
  final String departureTerminal;
  final String arrivalTerminal;
  final bool isOperatedBy;
  final String operatingCarrier;
  final String operatingCarrierFlightNumber;
  final String originTerminal;
  final String destinationTerminal;
  final String stopover;
  final String layover;
  final String arrivalcntry;
  final String departurecntry;
  final String arrival;
  final String departure;

  final String departuredt;
  final String arrivaldt;
  final String departuretime;
  final String arrivaltime;
  final String duration;
  final String cabin;
  final String flightNumber;
  final String flightName;
  final String carrier;
  final String bookingCounts;

  FlightSegmentDetails(
      {required this.departurecntry,
      required this.promoCode,
      required this.carrierImageUrl,
      required this.operatingCarrierImageUrl,
      required this.operatingCarrierName,


      required this.departureTerminal,
      required this.arrivalTerminal,
      required this.isOperatedBy,
      required this.operatingCarrier,
      required this.operatingCarrierFlightNumber,
      required this.originTerminal,
      required this.destinationTerminal,
      required this.stopover,
      required this.layover,
      required this.arrivalcntry,
      required this.arrival,
      required this.departure,
      required this.departuredt,
      required this.arrivaldt,
      required this.departuretime,
      required this.arrivaltime,
      required this.duration,
      required this.cabin,
      required this.flightNumber,
      required this.flightName,
      required this.carrier,
      required this.bookingCounts});
}

FlightSegmentDetails mapFlightSegmentDetails(dynamic payload) {
  print("carrierImageUrl");
  print(payload);
  return FlightSegmentDetails(
    carrierImageUrl: payload["carrierImageUrl"] ?? "",
    operatingCarrierImageUrl: payload["operatingCarrierImageUrl"] ?? "",
    operatingCarrierName: payload["operatingCarrierName"] ?? "",
    departurecntry: payload["depaturecntry"] ?? "",
    promoCode: payload["promoCode"] ?? "",
    layover: payload["layover"] ?? "",
    arrivalcntry: payload["arrivalcntry"] ?? "",
    arrival: payload["arrival"] ?? "",
    departure:payload["depature"] ?? "",
    arrivalTerminal: payload["arrivalTerminal"] ?? "",
    departureTerminal: payload["depatureTerminal"] ?? "",
    destinationTerminal: payload["destinationTerminal"] ??"",
    isOperatedBy: payload["isOperatedBy"] ?? false,
    operatingCarrier: payload["operatingCarrier"] ?? "",
    operatingCarrierFlightNumber:
        payload["operatingCarrierFlightNumber"] ?? "",
    originTerminal: payload["originTerminal"] ??"",
    stopover: payload["stopover"] ??"",
    departuredt: payload["depaturedt"] ??"",
    arrivaldt: payload["arrivaldt"] ??"",
    departuretime: payload["depaturetime"] ??"",
    arrivaltime: payload["arrivaltime"] ??"",
    duration: payload["duration"] ??"",
    cabin: payload["cabin"] ??"",
    flightNumber: payload["flightNumber"] ??"",
    flightName: payload["flightName"] ??"",
    carrier: payload["carrier"] ??"",
    bookingCounts: payload["bookingCounts"] ??"",
  );
}
