class GeneralItem {

  final String id;
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
    id :payload["id"]??"",
    name :payload["name"]??"",
  );
}
