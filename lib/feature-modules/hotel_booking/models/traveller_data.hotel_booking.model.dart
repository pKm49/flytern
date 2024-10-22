
import 'package:flytern/feature-modules/hotel_booking/models/traveller_info.hotel_booking.model.dart';

class HotelTravellerData {

  final List<HotelTravelInfo> travellerinfo;
  final int objectID;
  final String bookingCode;
  final int hotelID;
  final String mobileCntry;
  final String mobileNumber;
  final String email;

  HotelTravellerData({
    required this.travellerinfo,
    required this.objectID,
    required this.bookingCode,
    required this.hotelID,
    required this.mobileCntry,
    required this.mobileNumber,
    required this.email,
  });

  Map toJson() => {
    '_Travellerinfo': getTravellerInfo(),
    'objectID': objectID,
    'hotelID': hotelID,
    'bookingCode': bookingCode,
    '_CntDc':{
      'mobileCntry': mobileCntry,
      'mobileNumber': mobileNumber,
      'email': email,
    }
  };

  getTravellerInfo() {
    List<dynamic> travellers = [];
    travellerinfo.forEach((element) {
      if(element != null){
        travellers.add(element.toJson());
      }

    });
    return travellers;
  }

}

