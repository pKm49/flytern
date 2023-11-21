import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_item_room_data.dart';
import 'package:intl/intl.dart';

class HotelSearchData {
  final String destination;
  final String? destinationName;
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final String nationalityCode;
  final List<HotelSearchItemRoomData> rooms;

  HotelSearchData(
      {required this.destination,
      this.destinationName,
      required this.checkInDate,
      required this.checkOutDate,
      required this.nationalityCode,
      required this.rooms});

  Map toJson() => {
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
      searchLists.add(element.toJson());
    });
    return searchLists;
  }
}

HotelSearchData mapHotelSearchData(dynamic payload) {
  List<HotelSearchItemRoomData> rooms = [];

  if (payload["rooms"] != null) {
    payload["rooms"].forEach((element) {
      rooms.add(mapHotelSearchItem(element));
    });
  }

  return HotelSearchData(
      destination: payload["destination"] ?? "",
      destinationName: payload["destinationName"] ?? "DST",
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
      destinationName: "",
      checkInDate: DateTime.now(),
      checkOutDate: DateTime.now().add(Duration(days: 1)),
      nationalityCode: "KWT",
      rooms: [getDefaultHotelSearchItem()]);
}
