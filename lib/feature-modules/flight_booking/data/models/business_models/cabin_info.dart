class CabinInfo {

  final String promoCode;
  final double discount;
  final double totalTax;
  final double totalPrice;
  final double adultBase;
  final double childBase;
  final double infantBase;
  final double totalBase;
  final double finalAmount;
  final String cabinClass;
  final String currency;
  final String id;
  final String infoTitle;
  final String infoDescription;

  CabinInfo({
    required this.id,
    required this.promoCode,
    required this.discount,
    required this.totalTax,
    required this.totalPrice,
    required this.adultBase,
    required this.childBase,
    required this.infantBase,
    required this.totalBase,
    required this.finalAmount,
    required this.cabinClass,
    required this.currency,
    required this.infoTitle,
    required this.infoDescription
  });

  Map toJson() => {
    'id': id,
    'promoCode': promoCode,
    'discount': discount,
    'totalTax': totalTax,
    'totalPrice': totalPrice,
    'adultBase': adultBase,
    'childBase': childBase,
    'infantBase': infantBase,
    'totalBase': totalBase,
    'finalAmount': finalAmount,
    'cabinClass': cabinClass,
    'currency': currency,
    'infoTitle': infoTitle,
    'infoDescription': infoDescription,
  };

}

CabinInfo mapCabinInfo(dynamic payload){

  String infoTitle = "";
  String infoDescription = "";
  if(payload["infos"] != null){
    Map<String,String> infos = payload["infos"];
    int i =0;
    for (String value in infos.values){
      infoTitle = i==0? value:infoTitle;
      infoDescription = i==1? value:infoTitle;
      i++;
    }
  }
  return CabinInfo(
    id :payload["id"]??"-1",
    promoCode :payload["promoCode"]??"",
    cabinClass :payload["class"]??"",
    currency :payload["currency"]??"",
    infoTitle :infoTitle,
    infoDescription :infoDescription,
    totalTax :payload["totalTax"]??0.0,
    discount :payload["discount"]??0.0,
    totalBase :payload["totalBase"]??0.0,
    totalPrice :payload["totalPrice"]??0.0,
    adultBase :payload["adultBase"]??0.0,
    childBase :payload["childBase"]??0.0,
    infantBase :payload["infantBase"]??0.0,
    finalAmount :payload["finalAmount"]??0.0,
  );
}
