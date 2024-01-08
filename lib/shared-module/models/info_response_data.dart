
class InfoResponseData {


  final String  content;
  final String  twitter;
  final String facebook;
  final String instagram;
  final String linkedIn;

  InfoResponseData({
    required this.content,
    required this.twitter,
    required this.facebook,
    required this.instagram,
    required this.linkedIn,
  });

  Map toJson() => {
    'content': content,
    'twitter': twitter,
    'facebook': facebook,
    'instagram': instagram,
    'linkedIn': linkedIn,
  };

}

InfoResponseData mapInfoResponseData(dynamic payload){
  return InfoResponseData(
    instagram:payload["instagram"]??"",
    content :payload["content"]??"",
    twitter :payload["twitter"]??"",
    facebook :payload["facebook"] ??"",
    linkedIn :payload["linkedIn"] ??"",
  );
}
