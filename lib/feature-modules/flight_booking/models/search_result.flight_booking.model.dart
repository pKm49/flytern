import 'package:flytern/feature-modules/flight_booking/models/search_response.flight_booking.model.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
 import 'package:flytern/shared-module/models/sorting_dcs.dart';

class FlightSearchResult {
  final List<FlightSearchResponse> searchResponses;
  final List<SortingDcs> sortingDcs;
  final List<RangeDcs> priceDcs;
  final List<SortingDcs> airlineDcs;
  final List<SortingDcs> departureTimeDcs;
  final List<SortingDcs> arrivalTimeDcs;
  final List<SortingDcs> stopDcs;
  final String alertMsg;
  final int pageSize;
  final int totalFlights;

  FlightSearchResult(
      {required this.searchResponses,
      required this.priceDcs,
      required this.sortingDcs,
      required this.airlineDcs,
      required this.departureTimeDcs,
      required this.arrivalTimeDcs,
      required this.alertMsg,
      required this.pageSize,
      required this.totalFlights,
      required this.stopDcs});
}
