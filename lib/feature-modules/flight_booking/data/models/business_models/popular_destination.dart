class PopularDestination {

  final int refId;
  final String name;
  final String shortDesc;
  final double price;
  final String currency;
  final String destinations;
  final String url;
  final String urlType;
  final String ratings;

  PopularDestination({
    required this.refId,
    required this.name,
    required this.shortDesc,
    required this.price,
    required this.currency,
    required this.destinations,
    required this.url,
    required this.urlType,
    required this.ratings,
  });

  Map toJson() => {
    'refId': refId,
    'name': name,
    'shortDesc': shortDesc,
    'price': price,
    'currency': currency,
    'destinations': destinations,
    'url': url,
    'urlType': urlType,
    'ratings': ratings,
  };

}

PopularDestination mapPopularDestination(dynamic payload){
  return PopularDestination(
    refId :payload["refId"]??-1,
    name :payload["name"]??"",
    shortDesc :payload["shortDesc"]??"",
    price :payload["price"]??0.0,
    currency :payload["currency"]??"",
    destinations :payload["destinations"]??"",
    url :payload["url"]??"",
    urlType :payload["urlType"]??"",
    ratings :payload["ratings"]??"",
  );
}
