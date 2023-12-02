class Country {

  final String countryName;
  final String countryCode;
  final String countryISOCode;
  final String countryName_Ar;
  final String flag;
  final String code;
  final int isDefault;

  Country({
    required this.countryName,
    required this.countryCode,
    required this.countryISOCode,
    required this.countryName_Ar,
    required this.flag,
    required this.code,
    required this.isDefault,
  });

  Map toJson() => {
    'countryName': countryName,
    'countryCode': countryCode,
    'countryISOCode': countryISOCode,
    'countryName_Ar': countryName_Ar,
    'flag': flag,
    'code': code,
  };

}

Country mapCountry(dynamic payload){

  return Country(
    countryName :payload["countryName"]??"",
    countryCode :payload["countryCode"]??"",
    countryISOCode :payload["countryISOCode"].toString()??"",
    countryName_Ar :payload["countryName_Ar"]??"",
    flag :payload["flag"]??"",
    code :payload["code"] ??"",
    isDefault :payload["isDefault"] ??0,
  );
}
