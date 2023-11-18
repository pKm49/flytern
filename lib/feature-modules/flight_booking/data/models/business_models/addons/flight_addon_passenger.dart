class FlightAddonPassenger {

  final String passengerID;
  final String fullName;
  final String passengerType;
  final String selectedInfo;

  FlightAddonPassenger({
    required this.passengerID,
    required this.fullName, 
    required this.passengerType,
    required this.selectedInfo,
  });
}

FlightAddonPassenger mapFlightAddonPassenger(dynamic payload){
  return FlightAddonPassenger(
    passengerID :payload["passengerID"]??-1,
    fullName :payload["fullName"]??"",
    passengerType :payload["passengerType"]??"",
    selectedInfo :payload["_SelectedInfo"]??"",
  );
}
