class Translation {
  String? name;
  String? code;
  Map<String, String>? texts;

  Translation(
      {this.name, this.code, this.texts});

  Translation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    if (json['texts'] != null) {
      texts = Map<String, String>.from(json['texts']);
    }
  }
}