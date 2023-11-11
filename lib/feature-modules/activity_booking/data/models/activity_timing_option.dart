class ActivityTimingOption {
  final int tourOptionId;
  final int timeSlotId;
  final String timeSlot;
  final String available;
  final String adultPrice;
  final String childPrice;
  final String currency;
  final bool isDynamicPrice;
  final String companyBuyingPriceDynamic;
  final int root_Id;

  ActivityTimingOption({
    required this.tourOptionId,
    required this.timeSlotId,
    required this.timeSlot,
    required this.available,
    required this.adultPrice,
    required this.childPrice,
    required this.currency,
    required this.isDynamicPrice,
    required this.companyBuyingPriceDynamic,
    required this.root_Id,
  });
}

ActivityTimingOption mapActivityTimingOption(dynamic payload) {
  return ActivityTimingOption(
    tourOptionId:payload["tourOptionId"]!=null? int.parse(payload["tourOptionId"].toString()):-1,
      timeSlotId:payload["timeSlotId"]!=null? int.parse(payload["timeSlotId"].toString()):-1,

    timeSlot: payload["timeSlot"] ?? "",
    available: payload["available"] ?? "",
    adultPrice: payload["adultPrice"] ?? "",
    childPrice: payload["childPrice"] ?? "",
    currency: payload["currency"] ?? "",
    root_Id:payload["root_Id"]!=null? int.parse(payload["root_Id"].toString()):-1,
    isDynamicPrice:payload["isDynamicPrice"]!=null? bool.parse(payload["isDynamicPrice"].toString()):false,

    companyBuyingPriceDynamic: payload["companyBuyingPriceDynamic"] ?? "",
  );
}
