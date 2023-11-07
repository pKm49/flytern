class ActivityData {
  final int tourId;
  final int countryId;
  final int cityId;
  final int cityTourTypeId;
  final int contractId;
  final int reviewCount;
  final bool isSlot;
  final bool onlyChild;
  final String countryName;
  final String bestdeals;
  final String cityTourType;
  final String cityName;
  final String tourName;
  final String duration;
  final String cancellationPolicyName;
  final String tourShortDescription;

  final String imageCaptionName;
  final double price;
  final String currency;
  final String imagePath;
  final String rating;

  ActivityData(
      {required this.tourId,
      required this.countryId,
      required this.cityId,
      required this.cityTourTypeId,
      required this.contractId,
      required this.reviewCount,
      required this.isSlot,
      required this.onlyChild,
      required this.countryName,
      required this.bestdeals,
      required this.cityTourType,
      required this.cityName,
      required this.tourName,
      required this.duration,
      required this.cancellationPolicyName,
      required this.tourShortDescription,
      required this.imageCaptionName,
      required this.price,
      required this.currency,
      required this.imagePath,
      required this.rating});
}

ActivityData mapActivityData(dynamic payload) {
  return ActivityData(
    tourId: payload["tourId"] ?? -1,
    countryId: payload["countryId"] ?? -1,
    cityId: payload["cityId"] ?? -1,
    cityTourTypeId: payload["cityTourTypeId"] ?? -1,
    contractId: payload["contractId"] ?? -1,
    reviewCount: payload["reviewCount"] ?? -1,
    bestdeals: payload["bestdeals"] ?? "",
    countryName: payload["countryName"] ?? "",
    cityTourType: payload["cityTourType"] ?? "",
    cityName: payload["cityName"] ?? "",
    tourName: payload["tourName"] ?? "",
    currency: payload["currency"] ?? "",
    price: payload["price"] ?? 0.0,
    duration: payload["duration"] ?? "",
    cancellationPolicyName: payload["cancellationPolicyName"] ?? "",
    tourShortDescription: payload["tourShortDescription"] ?? "",
    imagePath: payload["imagePath"] ?? "",
    imageCaptionName: payload["imageCaptionName"] ?? "",
    rating: payload["rating"] ?? "",
    isSlot: payload["isSlot"] ?? false,
    onlyChild: payload["onlyChild"] ?? false,
  );
}
