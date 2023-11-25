import 'package:flytern/shared-module/data/constants/app_specific/default_values.dart';

class MyPackageBooking {

  final int refID;
  final String fromTo;
  final String airline;
  final String hotelName;
  final double price;
  final String currency; 
  final String name;
  final String shortDesc;
  final String destinations;
  final String url;
  final String urlType;
  final String ratings;
  final String travelmateID;
  final DateTime enquiredOn;
  final String enquiryStatus;


  MyPackageBooking({
    required this.refID,
    required this.fromTo,
    required this.airline,
    required this.hotelName,
    required this.currency,
    required this.price,
    required this.name,
    required this.shortDesc,
    required this.destinations,
    required this.url,
    required this.urlType,
    required this.ratings,
    required this.travelmateID,
    required this.enquiredOn,
    required this.enquiryStatus,
  });

}

MyPackageBooking mapMyPackageBooking(dynamic payload){
  return MyPackageBooking(
    refID :payload["refID"]??-1,
    fromTo :payload["fromTo"]??"",
    airline :payload["airline"]??"",
    hotelName :payload["hotelName"]??"",
    currency :payload["currency"]??"",
    price :payload["price"]??0.0,
    name :payload["name"]??"",
    shortDesc :payload["shortDesc"]??"",
    destinations :payload["destinations"]??"",
    url :payload["url"]??"",
    urlType :payload["urlType"]??"",
    ratings :payload["ratings"]??"",
    travelmateID :payload["travelmateID"]??"",
    enquiredOn :payload["enquiredOn"] !=null? DateTime.parse(payload["enquiredOn"]):DefaultInvalidDate,
    enquiryStatus :payload["enquiryStatus"]??"",
  );
}
