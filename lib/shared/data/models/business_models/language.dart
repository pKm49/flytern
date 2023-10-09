class Language {

  final String name;
  final String code;

  Language({
    required this.name,
    required this.code,
  });

  Map toJson() => {
    'name': name,
    'code': code,
  };

}

Language mapLanguage(dynamic payload){
  return Language(
    name :payload["name"]??"",
    code :payload["code"] ??"",
  );
}
