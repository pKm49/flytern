class HotelAmenity {
  final String amenityName;
  final String description;
  final String imagePath;

  HotelAmenity({
    required this.amenityName,
    required this.description,
    required this.imagePath,
  });
}

HotelAmenity mapHotelAmenity(dynamic payload) {
  return HotelAmenity(
    amenityName: payload["amenityName"] ?? "",
    description: payload["description"] ?? "",
    imagePath: payload["imagePath"] ?? "",
  );
}
