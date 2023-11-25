class Gender {

  final String code;
  final String name;
  final bool isDefault;

  Gender({
    required this.code,
    required this.name,
    required this.isDefault,
  });

  Map toJson() => {
    'code': code,
    'name': name,
    'default': isDefault,
  };

}

Gender mapGender(dynamic payload){
  return Gender(
    code :payload["code"]??"",
    name :payload["name"]??"",
    isDefault :payload["default"]??false,
  );
}
