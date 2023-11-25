import 'package:flytern/feature-modules/flight_booking/data/models/traveller_info.dart';

class FlightTravellerData {

  final List<TravelInfo> travellerinfo;
  final int objectID;
  final int detailID;
  final int cabinID;
  final String mobileCntry;
  final String mobileNumber;
  final String email;

  FlightTravellerData({
    required this.travellerinfo,
    required this.objectID,
    required this.detailID,
    required this.cabinID,
    required this.mobileCntry,
    required this.mobileNumber,
    required this.email,
  });

  Map toJson() => {
    '_Travellerinfo': getTravellerInfo(),
    'objectID': objectID,
    'detailID': detailID,
    'cabinID': cabinID,
    '_CntDc':{
      'mobileCntry': mobileCntry,
      'mobileNumber': mobileNumber,
      'email': email,
    }
  };

  getTravellerInfo() {
    List<dynamic> travellers = [];
    travellerinfo.forEach((element) {
      travellers.add(element.toJson());
    });
    return travellers;
  }

}

