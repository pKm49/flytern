class GeneralItem {

  final int id;
  final String name;
  final String arabicName;

  GeneralItem.GeneralItem({
    required this.id,
    required this.name,
    required this.arabicName,
  });

  Map toJson() => {
    'id': id,
    'name': name,
    'arabicName': arabicName,
  };

}

GeneralItem mapGeneralItem(dynamic payload){
  return GeneralItem.GeneralItem(
    id :payload["id"]??-1,
    name :payload["name"]??"",
    arabicName :payload["arabic_name"] != null?payload["arabic_name"].toString():"",
  );
}
