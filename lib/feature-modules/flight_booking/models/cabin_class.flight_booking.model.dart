class CabinClass {

  final int id;
  final String name;
  final String value;
  final bool isDefault;
  final String lang; 

  CabinClass({
    required this.id,
    required this.name, 
    required this.value,
    required this.isDefault,
    required this.lang,
  });

  Map toJson() => {
    'id': id,
    'name': name,
    'value': value,
    'isDefault': isDefault,
    'lang': lang,
  };

}

CabinClass mapCabinClass(dynamic payload){
  return CabinClass(
    id :payload["id"]??-1,
    name :payload["name"]??"",
    value :payload["value"]??"",
    isDefault :payload["isDefault"]??false,
    lang :payload["lang"]??"En",
  );
}
