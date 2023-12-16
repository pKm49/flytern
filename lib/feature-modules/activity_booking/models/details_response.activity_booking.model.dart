import 'package:flytern/feature-modules/activity_booking/models/details.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/option.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/transfer_type.activity_booking.model.dart';

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
