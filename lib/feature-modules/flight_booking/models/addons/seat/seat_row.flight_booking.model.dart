import 'package:flytern/feature-modules/flight_booking/models/addons/seat/seat_column.flight_booking.model.dart';

class FlightAddonSeatRow {
  final int row;
  final List<FlightAddonSeatColumn> columns;

  FlightAddonSeatRow({required this.row, required this.columns});
}

FlightAddonSeatRow mapFlightAddonSeatRow(dynamic payload) {

  List<FlightAddonSeatColumn> columns = [];

  payload["columns"].forEach((element) {
    if(element != null){
      columns.add(mapFlightAddonSeatColumn(element));
    }
  });


  return FlightAddonSeatRow(row: payload["row"] ?? -1,
      columns: columns);
}
