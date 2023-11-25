class RecommendedPackage {

  final int refId;
  final String name;
  final String shortDesc;
  final String destinations;
  final String url;
  final String urlType;
  final String ratings;

  RecommendedPackage({
    required this.refId,
    required this.name,
    required this.shortDesc,
    required this.destinations,
    required this.url,
    required this.urlType,
    required this.ratings,
  });

  Map toJson() => {
    'refId': refId,
    'name': name,
    'shortDesc': shortDesc,
    'destinations': destinations,
    'url': url,
    'urlType': urlType,
    'ratings': ratings,
  };

}

RecommendedPackage mapRecommendedPackage(dynamic payload){
  return RecommendedPackage(
    refId :payload["refID"]??-1,
    name :payload["name"]??"",
    shortDesc :payload["shortDesc"]??"",
    destinations :payload["destinations"]??"",
    url :payload["url"]??"",
    urlType :payload["urlType"]??"",
    ratings :payload["ratings"]??"",
  );
}
