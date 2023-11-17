class TravelStory {

  final int refId;
  final String name;
  final String shortDesc;
  final String profileUrl;
  final String url;
  final String urlType;
  final String ratings;

  TravelStory({
    required this.refId,
    required this.name,
    required this.shortDesc,
    required this.profileUrl,
    required this.url,
    required this.urlType,
    required this.ratings,
  });

  Map toJson() => {
    'refId': refId,
    'name': name,
    'shortDesc': shortDesc,
    'profileUrl': profileUrl,
    'url': url,
    'urlType': urlType,
    'ratings': ratings,
  };

}

TravelStory mapTravelStory(dynamic payload){
  return TravelStory(
    refId :payload["refID"]??-1,
    name :payload["name"]??"",
    shortDesc :payload["shortDesc"]??"",
    profileUrl :payload["profileUrl"]??"",
    url :payload["url"]??"",
    urlType :payload["urlType"]??"",
    ratings :payload["ratings"]??"",
  );
}
