import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
 import 'package:flytern/shared-module/models/sorting_dcs.dart';

class HotelSearchResult {
  int objectID;
  final List<HotelSearchResponse> searchResponses;
  final List<SortingDcs> sortingDcs;
  final List<RangeDcs> priceDcs;
  final List<SortingDcs> ratingDcs;
  final List<SortingDcs> locationDcs;

  HotelSearchResult(
      {required this.searchResponses,
      required this.objectID,
      required this.priceDcs,
      required this.sortingDcs,
      required this.ratingDcs,
      required this.locationDcs  });
}