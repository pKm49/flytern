class GeneralItem {

  final String? imageUrl;
  final String id;
  final String name;

  GeneralItem({
   this.imageUrl,
    required this.id,
    required this.name,
  });

  Map toJson() => {
    'imageUrl': imageUrl??"",
    'id': id,
    'name': name,
  };

}

GeneralItem mapGeneralItem(dynamic payload){
  return GeneralItem(
    imageUrl :payload["imageUrl"]??"",
    id :payload["id"]??"",
    name :payload["name"]??"",
  );
}
