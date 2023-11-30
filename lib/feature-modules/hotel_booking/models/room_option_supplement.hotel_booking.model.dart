class HotelRoomOptionSupplement {

  final int index; 
  final String type;
  final String description;
  final String currency;
  final double price;

  HotelRoomOptionSupplement({
    required this.index,
    required this.type,
    required this.description,
    required this.currency,
    required this.price
  });

}

HotelRoomOptionSupplement mapHotelRoomOptionSupplement(dynamic payload) {


  return HotelRoomOptionSupplement(
    index: payload["index"] ?? -1,
    type: payload["type"] ?? "",
    description: payload["description"] ?? "",
    currency: payload["currency"] ?? "",
    price: payload["price"] ?? 0.0,
  );
}
