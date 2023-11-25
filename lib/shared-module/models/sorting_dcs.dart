class SortingDcs {

  final String name;
  final String value;
  final bool isDefault;
  SortingDcs({
    required this.name, 
    required this.value,
    required this.isDefault
  });

  Map toJson() => {
    'name': name,
    'value': value,
    'isDefault': isDefault
  };

}

SortingDcs mapSortingDcs(dynamic payload){
  return SortingDcs(
    name :payload["name"]??"",
    value :payload["value"]??"",
    isDefault :payload["isDefault"]??false,
  );
}
