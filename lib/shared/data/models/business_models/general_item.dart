class GeneralItem {

  final int id;
  final String name;

  GeneralItem({
    required this.id,
    required this.name,
  });

  Map toJson() => {
    'id': id,
    'name': name,
  };

}

GeneralItem mapGeneralItem(dynamic payload){
  return GeneralItem(
    id :payload["id"]??-1,
    name :payload["name"]??"",
  );
}
