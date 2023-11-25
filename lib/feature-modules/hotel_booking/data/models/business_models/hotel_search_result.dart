import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_response.dart';
import 'package:flytern/shared-module/data/models/business_models/range_dcs.dart';
 import 'package:flytern/shared-module/data/models/business_models/sorting_dcs.dart';

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
