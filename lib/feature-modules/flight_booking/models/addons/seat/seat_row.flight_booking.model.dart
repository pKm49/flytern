import 'package:flytern/feature-modules/flight_booking/models/addons/seat/seat_column.flight_booking.model.dart';

class FlightAddonSeatRow {
  final int row;
  final List<FlightAddonSeatColumn> columns;

  FlightAddonSeatRow({required this.row, required this.columns});
}

FlightAddonSeatRow mapFlightAddonSeatRow(dynamic payload) {

  List<FlightAddonSeatColumn> columns = [];

  payload["columns"].forEach((element) {
    columns.add(mapFlightAddonSeatColumn(element));
  });

  print("columns.length");
  print(columns.length);
  return FlightAddonSeatRow(row: payload["row"] ?? -1,
      columns: columns);
}
