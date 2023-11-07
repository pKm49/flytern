
import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared/data/models/business_models/sorting_dcs.dart';

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
