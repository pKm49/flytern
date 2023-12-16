
import 'package:flytern/feature-modules/activity_booking/models/price_fetch_body.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/traveller_info.activity_booking.model.dart';
import 'package:intl/intl.dart';

class ActivitySubmissionData {

  final List<ActivityPriceFetchBody> eventlstInfo;
  final ActivityTravellerInfo  leadInfo;

  ActivitySubmissionData({
    required this.eventlstInfo,
    required this.leadInfo,
  });

  Map toJson() => {
        '_eventlstInfo': getEventlstInfo(),
        '_leadInfo': {
          "prefix": leadInfo.prefix,
          "firstName":leadInfo.firstName,
          "lastName": leadInfo.lastName,
          "email": leadInfo.email,
          "nationalityCode": leadInfo.nationalityCode,
          "mobile": leadInfo.mobile,
          "mobileCountryCode": leadInfo.mobileCountryCode,
          "specialRequest": leadInfo.specialRequest
        }
      };

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }

  List<dynamic> getEventlstInfo() {

    List<dynamic>  tEventlstInfo = [];
    eventlstInfo.forEach((element) {
      if(element != null){
        tEventlstInfo.add(element.toTravelDataJson());
      }
    });

    return tEventlstInfo;
  }

}
