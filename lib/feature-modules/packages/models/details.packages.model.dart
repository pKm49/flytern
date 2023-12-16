import 'dart:convert';

import 'package:flytern/feature-modules/packages/models/data.packages.model.dart';
import 'package:flytern/feature-modules/packages/models/itinerary.packages.model.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';

class PackageDetails extends PackageData {
  final String headerimage;
  final List<String> subImages;
  final DateTime validFrom;
  final DateTime validTo;
  final List<PackageItinerary> itinerary;
  final String inclusion;
  final String notIncluded;
  final String termsConditions;
  final String notes;
  final String offeredServices;

  PackageDetails(
      {required this.headerimage,
      required this.subImages,
      required this.validFrom,
      required this.validTo,
      required this.itinerary,
      required this.inclusion,
      required this.notIncluded,
      required this.termsConditions,
      required this.notes,
      required this.offeredServices,
      required super.refID,
      required super.fromTo,
      required super.airline,
      required super.hotelName,
      required super.currency,
      required super.price,
      required super.name,
      required super.shortDesc,
      required super.destinations,
      required super.url,
      required super.urlType,
      required super.ratings});
}

PackageDetails mapPackageDetails(dynamic payload) {
  String headerimage = "";
  List<String> subImages = [];
  List<PackageData> packages = [];
  List<PackageItinerary> itinerary =[];
  DateTime validFrom = DefaultInvalidDate;
  DateTime validTo = DefaultInvalidDate;
  String inclusion = "";
  String notIncluded = "";
  String termsConditions = "";
  String notes = "";
  String offeredServices = "";

  if (payload["packages"] != null) {
    payload["packages"].forEach((element) {
      if(element != null){
        packages.add(mapPackageData(element));
      }

    });
  }

  if (payload["packageHeaderImage"] != null) {
    payload["packageHeaderImage"].forEach((element) {
      if(element != null){
        if(element["headerimage"] != null){
          subImages.add(element["headerimage"] ?? "");
        }
      }

    });
  }



  if (payload["packageSubImages"] != null) {
    payload["packageSubImages"].forEach((element) {
      if(element != null){
        subImages.add(element["image"] ?? "");
      }
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
      try{
        var ite = jsonDecode(element["itinerary"]);

        ite.forEach((element) {
          itinerary.add(mapPackageItinerary(element ?? {}));
        });

      }catch (e,stac){

      }
    });
  }

  return PackageDetails(
    refID: packages.isNotEmpty ? packages[0].refID : -1,
    fromTo: packages.isNotEmpty ? packages[0].fromTo : "",
    airline: packages.isNotEmpty ? packages[0].airline : "",
    hotelName: packages.isNotEmpty ? packages[0].hotelName : "",
    currency: packages.isNotEmpty ? packages[0].currency : "",
    price: packages.isNotEmpty ? packages[0].price : 0.0,
    name: packages.isNotEmpty ? packages[0].name : "",
    shortDesc: packages.isNotEmpty ? packages[0].shortDesc : "",
    destinations: packages.isNotEmpty ? packages[0].destinations : "",
    url: packages.isNotEmpty ? packages[0].url : "",
    urlType: packages.isNotEmpty ? packages[0].urlType : "",
    ratings: packages.isNotEmpty ? packages[0].ratings : "",
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
  );
}

PackageDetails getDefaultPackageDetails() {
  String headerimage = "";
  List<String> subImages = [];
  List<PackageData> packages = [];
  List<PackageItinerary> itinerary = [];

  DateTime validFrom = DefaultInvalidDate;
  DateTime validTo = DefaultInvalidDate;
  String inclusion = "";
  String notIncluded = "";
  String termsConditions = "";
  String notes = "";
  String offeredServices = "";

  return PackageDetails(

    refID: -1,
    fromTo: "",
    airline: "",
    hotelName: "",
    currency: "",
    price: 0.0,
    name: "",
    shortDesc: "",
    destinations: "",
    url: "",
    urlType: "",
    ratings: "",
    headerimage: headerimage,
    subImages: subImages,
    validFrom: validFrom,
    validTo: validTo,
    itinerary: itinerary,
    inclusion: inclusion,
    notIncluded: notIncluded,
    termsConditions: termsConditions,
    notes: notes,
    offeredServices: offeredServices

  );
}
