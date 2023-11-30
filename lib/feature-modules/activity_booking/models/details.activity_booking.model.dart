import 'dart:convert';

import 'package:flytern/feature-modules/activity_booking/models/data.activity_booking.model.dart';
import 'package:flytern/feature-modules/activity_booking/models/itinerary.activity_booking.model.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';

class ActivityDetails extends ActivityData {

  final String departurePoint;
  final String reportingTime;
  final String tourLanguage;
  final String tourDescription;
  final String tourInclusion;
  final String raynaToursAdvantage;
  final String whatsInThisTour;
  final String importantInformation;
  final String itenararyDescription;
  final String usefulInformation;
  final String faqDetails;
  final String termsAndConditions;
  final String cancellationPolicyDescription;
  final String childCancellationPolicyName;
  final String childCancellationPolicyDescription;
  final String childAge;
  final String infantAge;
  final String infantCount;
  final String isSeat;
  final String latitude;
  final String longitude;
  final String startTime;
  final String meal;
  final String videoUrl;
  final String googleMapUrl;
  final String tourExclusion;
  final String howToRedeem;
  final String questions;
  final int amount;
  final int discount;
  final int rewardPoints;
  final List<String> subImages;
  final int result_Id;
  final int root_Id;

  ActivityDetails({required this.subImages,
    required this.departurePoint,
    required this.reportingTime,
    required this.tourLanguage,
    required this.tourDescription,
    required this.tourInclusion,
    required this.raynaToursAdvantage,
    required this.whatsInThisTour,
    required this.importantInformation,
    required this.itenararyDescription,
    required this.usefulInformation,
    required this.faqDetails,
    required this.termsAndConditions,
    required this.cancellationPolicyDescription,
    required this.childCancellationPolicyName,
    required this.childCancellationPolicyDescription,
    required this.childAge,
    required this.infantAge,
    required this.infantCount,
    required this.isSeat,
    required this.latitude,
    required this.longitude,
    required this.startTime,
    required this.meal,
    required this.videoUrl,
    required this.googleMapUrl,
    required this.tourExclusion,
    required this.howToRedeem,
    required this.result_Id,
    required this.questions,
    required this.root_Id,
    required this.amount,
    required this.discount,
    required this.rewardPoints,
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
    required super.price,
    required super.currency,
    required super.imagePath,
    required super.rating});
}

ActivityDetails mapActivityDetails(dynamic payload, List<dynamic> tSubImages) {

  List<String> subImages = [];

  for (var element in tSubImages) {
    subImages.add(element["imagePath"] ?? "");
  }

  return ActivityDetails(
    subImages:  subImages,
    departurePoint: payload["departurePoint"] ?? "",
    reportingTime: payload["reportingTime"] ?? "",
    tourLanguage: payload["tourLanguage"] ?? "",
    tourDescription: payload["tourDescription"] ?? "",
    tourInclusion: payload["tourInclusion"] ?? "",
    raynaToursAdvantage: payload["raynaToursAdvantage"] ?? "",
    whatsInThisTour: payload["whatsInThisTour"] ?? "",
    importantInformation: payload["importantInformation"] ?? "",
    itenararyDescription: payload["itenararyDescription"] ?? "",
    usefulInformation: payload["usefulInformation"] ?? "",
    faqDetails: payload["faqDetails"] ?? "",
    termsAndConditions: payload["termsAndConditions"] ?? "",
    cancellationPolicyDescription: payload["cancellationPolicyDescription"] ?? "",
    childCancellationPolicyName: payload["childCancellationPolicyName"] ?? "",
    childCancellationPolicyDescription: payload["childCancellationPolicyDescription"] ?? "",
    childAge: payload["childAge"] ?? "",
    infantAge: payload["infantAge"] ?? "",
    infantCount: payload["infantCount"] ?? "",
    isSeat: payload["isSeat"] ?? "",
    latitude: payload["latitude"] ?? "",
    longitude: payload["longitude"] ?? "",
    startTime: payload["startTime"] ?? "",
    meal: payload["meal"] ?? "",
    videoUrl: payload["videoUrl"] ?? "",
    googleMapUrl: payload["googleMapUrl"] ?? "",
    tourExclusion: payload["tourExclusion"] ?? "",
    howToRedeem: payload["howToRedeem"] ?? "",
    result_Id: payload["result_Id"] ?? -1,
    questions: payload["questions"] ?? "",
    root_Id: payload["root_Id"] ?? -1,
    amount:int.parse(payload["amount"]!=null?payload["amount"].toString():"0"),
    discount: payload["discount"] ?? 0,
    rewardPoints: payload["rewardPoints"] ?? 0,
    tourId: int.parse(payload["tourId"]!=null?payload["tourId"].toString():"0"),
    countryId: int.parse(payload["countryId"]!=null?payload["countryId"].toString():"0"),
    cityId: int.parse(payload["cityId"]!=null?payload["cityId"].toString():"0"),
    cityTourTypeId: int.parse(payload["cityTourTypeId"]!=null?payload["cityTourTypeId"].toString():"0"),
    contractId: int.parse(payload["contractId"]!=null?payload["contractId"].toString():"0"),
    reviewCount: int.parse(payload["reviewCount"]!=null?payload["reviewCount"].toString():"0"),
    isSlot: bool.parse(payload["isSlot"]!=null?payload["isSlot"].toString():"false"),
    onlyChild: bool.parse(payload["onlyChild"]!=null?payload["onlyChild"].toString():"false"),

    countryName: payload["countryName"] ?? "",
    bestdeals: payload["bestdeals"] ?? "",
    cityTourType: payload["cityTourType"] ?? "",
    cityName: payload["cityName"] ?? "",
    tourName: payload["tourName"] ?? "",
    duration: payload["duration"] ?? "",
    cancellationPolicyName: payload["cancellationPolicyName"] ?? "",
    tourShortDescription: payload["tourShortDescription"] ?? "",
    imageCaptionName: payload["imageCaptionName"] ?? "",
    price: double.parse(payload["amount"]!=null?payload["amount"].toString():"0"),
    rating: double.parse(payload["rating"]!=null?payload["rating"].toString():"0"),

    currency: payload["currency"] ?? "",
    imagePath: payload["imagePath"] ?? "",

  );
}

ActivityDetails getDefaultActivityDetails() {

  return ActivityDetails(
    subImages: [],
      departurePoint: "",
      reportingTime: "",
      tourLanguage: "",
      tourDescription: "",
      tourInclusion: "",
      raynaToursAdvantage: "",
      whatsInThisTour: "",
      importantInformation: "",
      itenararyDescription: "",
      usefulInformation: "",
      faqDetails: "",
      termsAndConditions: "",
      cancellationPolicyDescription: "",
      childCancellationPolicyName: "",
      childCancellationPolicyDescription: "",
      childAge: "",
      infantAge: "",
      infantCount: "",
      isSeat: "",
      latitude: "",
      longitude: "",
      startTime: "",
      meal: "",
      videoUrl: "",
      googleMapUrl: "",
      tourExclusion: "",
      howToRedeem: "",
      result_Id: -1,
      questions: "",
      root_Id: -1,
      amount: -1,
      discount: -1,
      rewardPoints: -1,
      tourId: -1,
      countryId: -1,
      cityId: -1,
      cityTourTypeId: -1,
      contractId: -1,
      reviewCount: -1,
      isSlot: false,
      onlyChild: false,
      countryName: "",
      bestdeals: "",
      cityTourType: "",
      cityName: "",
      tourName: "",
      duration: "",
      cancellationPolicyName: "",
      tourShortDescription: "",
      imageCaptionName: "",
      price: -1,
      currency: "",
      imagePath: "",
      rating: 0.0
  );

}
