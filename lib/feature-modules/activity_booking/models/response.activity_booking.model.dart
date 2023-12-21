
import 'package:flytern/feature-modules/activity_booking/models/data.activity_booking.model.dart';
 import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';

class ActivityResponse {

  final List<ActivityData> activities;
  final int objectID;
  final List<RangeDcs> priceDcs;
  final List<SortingDcs> sortingDcs;
  final List<SortingDcs> tourCategoryDcs;
  final List<SortingDcs> bestDealsDcs;

  ActivityResponse({
    required this.activities,
    required this.objectID,
    required this.priceDcs,
    required this.sortingDcs,
    required this.tourCategoryDcs,
    required this.bestDealsDcs
  });

}
