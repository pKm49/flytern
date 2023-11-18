class FlightAddonSeatSelection {

  final String routeID;
  final int rowID;
  final String passengerID;
  final String seatId;

  FlightAddonSeatSelection({
    required this.routeID,
    required this.rowID,
    required this.passengerID,
    required this.seatId,
  });

  Map toJson() => {
    'routeID': routeID,
    'rowID': rowID,
    'passengerID': passengerID,
    'seatId': seatId,
  };

}

