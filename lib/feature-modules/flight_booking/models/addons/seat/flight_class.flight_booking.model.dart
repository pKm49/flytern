import 'package:flytern/feature-modules/flight_booking/models/addons/seat/seat_row.flight_booking.model.dart';

class FlightAddonFlightClass {
  final String routeID;
  final String columnPosition;
  final String ticketClassType;
  final bool wifi;
  final bool meal;
  final bool monitor;
  final List<FlightAddonSeatRow> seats;
  final int wingRowPositionFirstRow;
  final int wingRowPositionLastRow;
  final int exitRowPositionFirstRow;
  final int exitRowPositionLastRow;

  FlightAddonFlightClass({
    required this.routeID,
    required this.columnPosition,
    required this.ticketClassType,
    required this.wifi,
    required this.meal,
    required this.monitor,
    required this.seats,
    required this.wingRowPositionFirstRow,
    required this.wingRowPositionLastRow,
    required this.exitRowPositionFirstRow,
    required this.exitRowPositionLastRow,
  });
}

FlightAddonFlightClass mapFlightAddonFlightClass(dynamic payload) {
  List<FlightAddonSeatRow> seats = [];

  payload["seats"].forEach((element) {
    seats.add(mapFlightAddonSeatRow(element));
  });

  bool wifi = false;
  bool meal = false;
  bool monitor = false;
  int wingRowPositionFirstRow = -1;
  int wingRowPositionLastRow = -1;
  int exitRowPositionFirstRow = -1;
  int exitRowPositionLastRow = -1;

  if (payload["serviceAvailable"] != null) {
    wifi = payload["serviceAvailable"]["wifi"] ?? false;
    meal = payload["serviceAvailable"]["meal"] ?? false;
    monitor = payload["serviceAvailable"]["monitor"] ?? false;
  }

  if (payload["wingRowPosition"] != null) {
    wingRowPositionFirstRow = payload["wingRowPosition"]["firstRow"] ?? -1;
    wingRowPositionLastRow = payload["wingRowPosition"]["lastRow"] ?? -1;
  }
  if (payload["wingRowPosition"] != null) {
    exitRowPositionFirstRow = payload["exitRowPosition"]["firstRow"] ?? -1;
    exitRowPositionLastRow = payload["exitRowPosition"]["lastRow"] ?? -1;
  }


  return FlightAddonFlightClass(
    routeID: payload["routeID"] ?? "-1",
    columnPosition: payload["columnPosition"] ?? "-1",
    ticketClassType: payload["ticketClassType"] ?? "-1",
    seats: seats,
    wifi: wifi,
    meal: meal,
    monitor: monitor,
    wingRowPositionFirstRow: wingRowPositionFirstRow,
    wingRowPositionLastRow: wingRowPositionLastRow,
    exitRowPositionFirstRow: exitRowPositionFirstRow,
    exitRowPositionLastRow: exitRowPositionLastRow,
  );
}
