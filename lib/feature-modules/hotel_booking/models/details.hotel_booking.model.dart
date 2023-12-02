import 'package:flytern/feature-modules/hotel_booking/models/amenity.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/basic_detail.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room.hotel_booking.model.dart';

class HotelDetails {

  final double fromPrice;
  final double rating;
  final String priceUnit;
  final String checkIn;
  final String checkOut;
  final String duration;
  final String cancellationpolicy;
  final String descriptionInfo;
  final String hotelName;
  final String address;
  final String alertMsg;
  final String location;
  final String locationurl;
  final int hotelId;
  final List<HotelBasicDetail> basicDetails;
  final List<HotelAmenity> amenitys;
  final List<HotelRoom> rooms;
  final List<String> imageUrls;

  HotelDetails(
      {required this.priceUnit,
      required this.fromPrice,
      required this.alertMsg,
      required this.rating,
      required this.checkIn,
      required this.checkOut,
      required this.duration,
      required this.cancellationpolicy,
      required this.hotelName,
      required this.descriptionInfo,
      required this.address,
      required this.location,
      required this.locationurl,
      required this.hotelId,
      required this.imageUrls,
      required this.basicDetails,
      required this.amenitys,
      required this.rooms});

}

HotelDetails mapHotelDetails(dynamic payload) {
  List<HotelBasicDetail> basicDetails = [];
  List<HotelAmenity> amenitys = [];
  List<HotelRoom> rooms = [];
  List<String> imageUrls = [];


  if (payload["imageUrl"] != null) {
    payload["imageUrl"].forEach((element) {
      imageUrls.add(element);
    });
  }
  if (payload["_lstBasicDetails"] != null) {
    payload["_lstBasicDetails"].forEach((element) {
      basicDetails.add(mapHotelBasicDetail(element));
    });
  }

  if (payload["_lstamenitys"] != null) {
    payload["_lstamenitys"].forEach((element) {
      amenitys.add(mapHotelAmenity(element));
    });
  }

  if (payload["_lstRooms"] != null) {
    payload["_lstRooms"].forEach((element) {
      rooms.add(mapHotelRoom(element));
    });
  }

  return HotelDetails(
    rating: payload["rating"] ?? 0.0,
    fromPrice: payload["fromPrice"] ?? 0.0,
    priceUnit: payload["priceUnit"] ?? "",
    alertMsg: payload["alertMsg"] ?? "",
    duration: payload["duration"] ?? "",
    checkOut: payload["checkOut"] ?? "",
    checkIn: payload["checkIn"] ?? "",
    address: payload["address"] ?? "",
    location: payload["location"] ?? "",
    locationurl: payload["locationurl"] ?? "",
    hotelId: payload["hotelId"] ?? -1,
    cancellationpolicy:payload["cancellationpolicy"] ?? "",
    hotelName: payload["hotelName"] ?? "",
    descriptionInfo: payload["descriptionInfo"] ?? "",
    imageUrls: imageUrls,
    basicDetails: basicDetails,
    amenitys: amenitys,
    rooms: rooms,
  );
}

HotelDetails getDefaultHotelDetails() {


  return HotelDetails(
    priceUnit: "",
    rating: 0.0,
    fromPrice: 0.0,
    duration: "",
    checkOut: "",
    checkIn: "",
    cancellationpolicy: '',
    hotelName: '',
    alertMsg:'',
    descriptionInfo: '',
    imageUrls: [],
    basicDetails: [],
    amenitys: [],
    rooms: [],
    address: '',
    location: '',
    locationurl: '',
    hotelId: -1,
  );
}
