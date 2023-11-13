class HotelCabinClass {

  final int id;
  final String name;
  final String value;
  final bool isDefault;
  final String lang; 

  HotelCabinClass({
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

HotelCabinClass mapCabinClass(dynamic payload){
  return HotelCabinClass(
    id :payload["id"]??-1,
    name :payload["name"]??"",
    value :payload["value"]??"",
    isDefault :payload["isDefault"]??false,
    lang :payload["lang"]??"En",
  );
}
