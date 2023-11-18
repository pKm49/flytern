class FlightAddonSeatSelection {

  final String routeID;
  final int rowID;
  final String passengerID;
  final String seatId;
  final double amount;
  final String currency;

  FlightAddonSeatSelection({
    required this.routeID,
    required this.rowID,
    required this.passengerID,
    required this.seatId,
    required this.amount,
    required this.currency,
  });

  Map toJson() => {
    'routeID': routeID,
    'rowID': rowID,
    'passengerID': passengerID,
    'seatId': seatId,
  };

}

