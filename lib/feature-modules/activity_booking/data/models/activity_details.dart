import 'dart:convert';

import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_itinerary.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';

class ActivityDetails extends ActivityData {
  final String headerimage;
  final List<String> subImages;
  final DateTime validFrom;
  final DateTime validTo;
  final List<ActivityItinerary> itinerary;
  final String inclusion;
  final String notIncluded;
  final String termsConditions;
  final String notes;
  final String offeredServices;

  ActivityDetails({
    required this.headerimage,
    required this.subImages,
    required this.validFrom,
    required this.validTo,
    required this.itinerary,
    required this.inclusion,
    required this.notIncluded,
    required this.termsConditions,
    required this.notes,
    required this.offeredServices,
    required super.currency,
    required super.price,
    required super.tourId,
    required super.countryId,
    required super.cityId,
    required super.cityTourTypeId,
    required super.contractId,
    required super.reviewCount,
    required super.isSlot,
    required super.onlyChild,
    required super.countryName,
    required super.bestdeals,
    required super.cityTourType,
    required super.cityName,
    required super.tourName,
    required super.duration,
    required super.cancellationPolicyName,
    required super.tourShortDescription,
    required super.imageCaptionName,
    required super.imagePath,
    required super.rating,
  });
}

ActivityDetails mapActivityDetails(dynamic payload) {
  String headerimage = "";
  List<String> subImages = [];
  List<ActivityData> packages = [];
  List<ActivityItinerary> itinerary = [];
  DateTime validFrom = DefaultInvalidDate;
  DateTime validTo = DefaultInvalidDate;
  String inclusion = "";
  String notIncluded = "";
  String termsConditions = "";
  String notes = "";
  String offeredServices = "";

  if (payload["packages"] != null) {
    payload["packages"].forEach((element) {
      packages.add(mapActivityData(element));
    });
  }

  if (payload["packageHeaderImage"] != null) {
    payload["packageHeaderImage"].forEach((element) {
      subImages.add(element["headerimage"] ?? "");
    });
  }

  if (payload["packageSubImages"] != null) {
    payload["packageSubImages"].forEach((element) {
      subImages.add(element["image"] ?? "");
    });
  }

  if (payload["packagesDtl"] != null) {
    payload["packagesDtl"].forEach((element) {
      validFrom = DateTime.parse(element["validFrom"]);
      validTo = DateTime.parse(element["validTo"]);
      inclusion = element["inclusion"];
      notIncluded = element["notIncluded"];
      termsConditions = element["termsConditions"];
      notes = element["notes"];
      offeredServices = element["offeredServices"];
      try {
        var ite = jsonDecode(element["itinerary"]);

        ite.forEach((element) {
          itinerary.add(mapActivityItinerary(element ?? {}));
        });
        print("decoded itenerary is");
        print("decoded itenerary is");
      } catch (e, stac) {
        print(e);
        print(stac);
      }
    });
  }

  return ActivityDetails(
    currency: packages.isNotEmpty ? packages[0].currency : "",
    price: packages.isNotEmpty ? packages[0].price : 0.0,
    headerimage: headerimage,
    subImages: subImages,
    validFrom: validFrom,
    validTo: validTo,
    itinerary: itinerary,
    inclusion: inclusion,
    notIncluded: notIncluded,
    termsConditions: termsConditions,
    notes: notes,
    offeredServices: offeredServices,
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

ActivityDetails getDefaultActivityDetails() {
  String headerimage = "";
  List<String> subImages = [];
  List<ActivityData> packages = [];
  List<ActivityItinerary> itinerary = [];

  DateTime validFrom = DefaultInvalidDate;
  DateTime validTo = DefaultInvalidDate;
  String inclusion = "";
  String notIncluded = "";
  String termsConditions = "";
  String notes = "";
  String offeredServices = "";

  return ActivityDetails(
      tourId: -1,
      countryId: -1,
      cityId: -1,
      cityTourTypeId: -1,
      contractId: -1,
      reviewCount: -1,
      bestdeals: "",
      countryName: "",
      cityTourType: "",
      cityName: "",
      tourName: "",
      currency: "",
      price: 0.0,
      duration: "",
      cancellationPolicyName: "",
      tourShortDescription: "",
      imagePath: "",
      imageCaptionName: "",
      rating: 0.0,
      isSlot: false,
      onlyChild: false,
      headerimage: headerimage,
      subImages: subImages,
      validFrom: validFrom,
      validTo: validTo,
      itinerary: itinerary,
      inclusion: inclusion,
      notIncluded: notIncluded,
      termsConditions: termsConditions,
      notes: notes,
      offeredServices: offeredServices);
}
