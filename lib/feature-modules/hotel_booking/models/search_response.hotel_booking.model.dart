class HotelSearchResponse {
  final int hotelId;
  final String imageUrl;
  final String hotelName;
  final double fromPrice;
  final String priceUnit;
  final double rating;
  final String description;
  final String location;
  final String locationFilter;
  final List<String> information;

  HotelSearchResponse(
      {required this.locationFilter,
      required this.fromPrice,
      required this.rating,
      required this.imageUrl,
      required this.location,
      required this.hotelName,
      required this.priceUnit,
      required this.description,
      required this.hotelId,
      required this.information});
}

HotelSearchResponse mapHotelSearchResponse(dynamic payload) {
  List<String> information = [];

  if(payload["information"] !=null){
    payload["information"].forEach((element) {
      if(element != null){
        information.add(element);
      }

    });
  }

  return HotelSearchResponse(
    locationFilter: payload["locationFilter"] ?? "",
    fromPrice: payload["fromPrice"] ?? 0.0,
    rating: payload["rating"] ?? 0.0,
    imageUrl: payload["imageUrl"] ?? "",
    location: payload["location"] ?? "",
    hotelName: payload["hotelName"] ?? "",
    priceUnit: payload["priceUnit"] ?? "",
    description: payload["description"] ?? "",
    hotelId: payload["hotelId"] ?? -1,
    information:information,
  );
}

getBoolean(payload) {
  if (payload == null) {
    return false;
  }
  if (payload is bool) {
    return payload;
  }

  if (payload is String && (payload == "true" || payload == "false")) {
    return bool.parse(payload);
  }
  return false;
}
