import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
 import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';

class FlightSearchResult {
  final List<FlightSearchResponse> searchResponses;
  final List<SortingDcs> sortingDcs;
  final List<RangeDcs> priceDcs;
  final List<SortingDcs> airlineDcs;
  final List<SortingDcs> departureTimeDcs;
  final List<SortingDcs> arrivalTimeDcs;
  final List<SortingDcs> stopDcs;

  FlightSearchResult(
      {required this.searchResponses,
      required this.priceDcs,
      required this.sortingDcs,
      required this.airlineDcs,
      required this.departureTimeDcs,
      required this.arrivalTimeDcs,
      required this.stopDcs});
}
