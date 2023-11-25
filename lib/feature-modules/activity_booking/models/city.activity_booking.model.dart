class ActivityCity {

  final String cityID;
  final String cityName;
  final String imageUrl;


  ActivityCity({
    required this.cityID,
    required this.cityName,
    required this.imageUrl
  });

}

ActivityCity mapActivityCity(dynamic payload){
  return ActivityCity(
    cityID :payload["cityID"].toString()??"-1",
    cityName :payload["cityName"]??"",
    imageUrl :payload["imageUrl"]??""
  );
}
