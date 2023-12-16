import 'package:flytern/feature-modules/hotel_booking/models/search_item_room_data.hotel_booking.model.dart';
import 'package:intl/intl.dart';

class HotelSearchData {
  final String countryCode;
  final String hotelCode;
  final String cityCode;
  final String destination;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String nationalityCode;
  final List<HotelSearchItemRoomData> rooms;

  HotelSearchData(
      {required this.countryCode,
      required this.hotelCode,
      required this.cityCode,
      required this.destination,
      required this.checkInDate,
      required this.checkOutDate,
      required this.nationalityCode,
      required this.rooms});

  Map toJson() => {
        'countryCode': countryCode,
        'hotelCode': hotelCode,
        'cityCode': cityCode,
        'destination': destination,
        'checkInDate': getFormattedDate(checkInDate),
        'checkOutDate': getFormattedDate(checkOutDate),
        'nationalityCode': nationalityCode,
        'rooms': getRooms(rooms)
      };

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }

  List<dynamic> getRooms(List<HotelSearchItemRoomData> searchList) {
    List<dynamic> searchLists = [];
    searchList.forEach((element) {
      if(element != null){
        searchLists.add(element.toJson());
      }

    });
    return searchLists;
  }
}

HotelSearchData mapHotelSearchData(dynamic payload) {
  List<HotelSearchItemRoomData> rooms = [];

  if (payload["rooms"] != null) {
    payload["rooms"].forEach((element) {
      if(element != null){
        rooms.add(mapHotelSearchItem(element));
      }

    });
  }

  return HotelSearchData(
      countryCode: payload["countryCode"] ?? "",
      hotelCode: payload["hotelCode"] ?? "",
      cityCode: payload["cityCode"] ?? "",
      destination: payload["destination"] ?? "",
      checkInDate: payload["checkInDate"] != null
          ? DateTime.parse(payload["checkInDate"])
          : DateTime.now(),
      checkOutDate: payload["checkInDate"] != null
          ? DateTime.parse(payload["checkInDate"])
          : DateTime.now().add(Duration(days: 1)),
      nationalityCode: payload["nationalityCode"] ?? "",
      rooms: rooms);
}

HotelSearchData getDefaultHotelSearchData() {
  return HotelSearchData(
      destination: "",
      cityCode: "",
      countryCode:"",
      hotelCode: "",
      checkInDate: DateTime.now(),
      checkOutDate: DateTime.now().add(Duration(days: 1)),
      nationalityCode: "KWT",
      rooms: [getDefaultHotelSearchItem()]);
}
