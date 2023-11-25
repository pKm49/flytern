class BusinessDoc {

  final String terms;
  final String privacy;

  BusinessDoc({
    required this.terms,
    required this.privacy,
  });

  Map toJson() => {
    'terms': terms,
    'privacy': privacy,
  };

}

BusinessDoc mapBusinessDoc(dynamic payload){
  return BusinessDoc(
    terms :payload["terms"] != null?payload["terms"][0]["content"]:"",
    privacy :payload["privacy"] != null?payload["privacy"][0]["content"]:""
  );
}
