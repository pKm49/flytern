class PackageData {

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


  PackageData({
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
  });

}

PackageData mapPackageData(dynamic payload){
  return PackageData(
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
  );
}
