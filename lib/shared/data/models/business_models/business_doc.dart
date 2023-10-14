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
    terms :payload["terms"]??"",
    privacy :payload["privacy"]??"",
  );
}
