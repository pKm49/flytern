import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_details.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_option.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_transfer_type.dart';
import 'package:flytern/shared-module/data/models/business_models/country.dart';
import 'package:flytern/shared-module/data/models/business_models/range_dcs.dart';
import 'package:flytern/shared-module/data/models/business_models/sorting_dcs.dart';

class ActivityDetailsResponse {

  final ActivityDetails activityDetails;
  final List<ActivityOption> activityOptions;
  final List<ActivityTransferType> activityTransferTypes;

  ActivityDetailsResponse({
    required this.activityDetails,
    required this.activityOptions,
    required this.activityTransferTypes
  });


}

ActivityDetailsResponse getDefaultActivityDetailsResponse() {
  return ActivityDetailsResponse(
      activityDetails: mapActivityDetails({},[]),
      activityOptions: [],
      activityTransferTypes: []
  );
}
