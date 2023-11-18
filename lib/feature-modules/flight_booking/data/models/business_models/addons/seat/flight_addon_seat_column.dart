class  FlightAddonSeatColumn {

  final String seatId;
  final bool isSpaceGap;
  final String position;
  final bool isAvailable;
  final double amount;
  final String currency;
  final bool isSelectedByDefault;

   FlightAddonSeatColumn({
    required this.seatId,
    required this.isSpaceGap, 
    required this.position,
    required this.isAvailable,
    required this.amount,
    required this.currency,
    required this.isSelectedByDefault,
  });


}

FlightAddonSeatColumn mapFlightAddonSeatColumn(dynamic payload){
  return FlightAddonSeatColumn(
    seatId :payload["seatId"]??"-1",
    isSpaceGap :payload["isSpaceGap"]??false,
    position :payload["position"]??"",
    isAvailable :payload["isAvailable"]??false,
    amount :payload["amount"]??1.0,
    currency :payload["currency"]??"",
    isSelectedByDefault :payload["isSelectedByDefault"]??false,
  );
}
