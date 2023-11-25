
class InfoResponseData {


  final String  content;
  final String  twitter;
  final String facebook;
  final String instagram;

  InfoResponseData({
    required this.content,
    required this.twitter,
    required this.facebook,
    required this.instagram,
  });

  Map toJson() => {
    'content': content,
    'twitter': twitter,
    'facebook': facebook,
    'instagram': instagram,
  };

}

InfoResponseData mapInfoResponseData(dynamic payload){
  return InfoResponseData(
    instagram:payload["instagram"]??"",
    content :payload["content"]??"",
    twitter :payload["twitter"]??"",
    facebook :payload["facebook"] ??"",
  );
}
