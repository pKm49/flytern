class HotelRoomOption {

  final int roomOptionid;
  final List<String> shortdesc;
  final String currency;
  final double perNightPrice;
  final double totalPrice;
  final String roomName;

  HotelRoomOption({
    required this.roomOptionid,
    required this.currency,
    required this.perNightPrice,
    required this.roomName,
    required this.shortdesc,
    required this.totalPrice,
  });
}

HotelRoomOption mapHotelRoomDetails(dynamic payload) {

  List<String> shortdesc = [];

  payload["shortdesc"].forEach((element) {
    shortdesc.add(element);
  });

  return HotelRoomOption(
    roomOptionid: payload["roomOptionid"] ?? "",
    currency: payload["currency"] ?? "",
    perNightPrice: payload["perNightPrice"] ?? 0.0,
    roomName: payload["roomName"] ?? "",
    shortdesc: shortdesc,
    totalPrice: payload["totalPrice"] ?? 0.0,
  );
}
