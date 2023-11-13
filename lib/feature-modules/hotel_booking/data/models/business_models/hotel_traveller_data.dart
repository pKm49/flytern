
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_traveller_info.dart';

class HotelTravellerData {

  final List<HotelTravelInfo> travellerinfo;
  final int objectID;
  final int detailID;
  final int cabinID;
  final String mobileCntry;
  final String mobileNumber;
  final String email;

  HotelTravellerData({
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

