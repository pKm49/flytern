class ActivityTransferType {
  final String tourId;
  final String tourOptionId;
  final String transferId;
  final String transferName;
  final String adultPrice;
  final String childPrice;
  final String infantPrice;
  final String withoutDiscountAmount;
  final String finalAmount;
  final String startTime;
  final String departureTime;
  final String disableChild;
  final String disableInfant;
  final String allowTodaysBooking;
  final String cutOff;
  final bool isSlot;
  final String isSeat;
  final String isDefaultTransfer;
  final String rateKey;
  final String inventoryId;
  final String adultBuyingPrice;
  final String childBuyingPrice;
  final String infantBuyingPrice;
  final String adultSellingPrice;
  final String childSellingPrice;
  final String infantSellingPrice;
  final String companyBuyingPrice;
  final String companySellingPrice;
  final String agentBuyingPrice;
  final String agentSellingPrice;
  final String subAgentBuyingPrice;
  final String subAgentSellingPrice;
  final String finalSellingPrice;
  final String vatbuying;
  final String vatselling;
  final String currency;
  final String currencyFactor;
  final String agentPercentage;
  final String transferBuyingPrice;
  final String transferSellingPrice;
  final String serviceBuyingPrice;
  final String serviceSellingPrice;
  final String rewardPoints;
  final String tourChildAge;
  final String maxChildAge;
  final String maxInfantAge;
  final String minimumPax;
  final String pointRemark;
  final String adultRetailPrice;
  final String childRetailPrice;
  final int root_Id;
  final int contractId;
  final int dateFlag;
  final String selectedTravelDate;

  ActivityTransferType(
      {required this.tourId,
      required this.tourOptionId,
      required this.transferId,
      required this.transferName,
      required this.adultPrice,
      required this.childPrice,
      required this.infantPrice,
      required this.withoutDiscountAmount,
      required this.finalAmount,
      required this.startTime,
      required this.departureTime,
      required this.disableChild,
      required this.disableInfant,
      required this.allowTodaysBooking,
      required this.cutOff,
      required this.isSlot,
      required this.currency,
      required this.isSeat,
      required this.isDefaultTransfer,
      required this.rateKey,
      required this.inventoryId,
      required this.adultBuyingPrice,
      required this.childBuyingPrice,
      required this.infantBuyingPrice,
      required this.adultSellingPrice,
      required this.childSellingPrice,
      required this.infantSellingPrice,
      required this.companyBuyingPrice,
      required this.companySellingPrice,
      required this.agentBuyingPrice,
      required this.agentSellingPrice,
      required this.subAgentBuyingPrice,
      required this.subAgentSellingPrice,
      required this.finalSellingPrice,
      required this.vatbuying,
      required this.vatselling,
      required this.currencyFactor,
      required this.agentPercentage,
      required this.transferBuyingPrice,
      required this.transferSellingPrice,
      required this.serviceBuyingPrice,
      required this.serviceSellingPrice,
      required this.rewardPoints,
      required this.tourChildAge,
      required this.maxChildAge,
      required this.maxInfantAge,
      required this.minimumPax,
      required this.pointRemark,
      required this.adultRetailPrice,
      required this.childRetailPrice,
      required this.root_Id,
      required this.contractId,
      required this.dateFlag,
      required this.selectedTravelDate});
}

ActivityTransferType mapActivityTransferType(dynamic payload) {
  return ActivityTransferType(

      tourId: payload["tourId"] ?? "",
      tourOptionId: payload["tourOptionId"] ?? "",
      currency: payload["currency"] ?? "",
      transferId: payload["transferId"] ?? "",
      transferName: payload["transferName"] ?? "",
      adultPrice: payload["adultPrice"] ?? "",
      childPrice: payload["childPrice"] ?? "",
      infantPrice: payload["infantPrice"] ?? "",
      withoutDiscountAmount: payload["withoutDiscountAmount"] ?? "",
      finalAmount: payload["finalAmount"] ?? "",
      startTime: payload["startTime"] ?? "",
      departureTime: payload["departureTime"] ?? "",
      disableChild: payload["disableChild"] ?? "",
      disableInfant: payload["disableInfant"] ?? "",
      allowTodaysBooking: payload["allowTodaysBooking"] ?? "",
      cutOff: payload["cutOff"] ?? "",
      isSlot: payload["isSlot"] !=null? bool.parse(payload["isSlot"]):false,
      isSeat: payload["isSeat"] ?? "",
      isDefaultTransfer: payload["isDefaultTransfer"] ?? "",
      rateKey: payload["rateKey"] ?? "",
      inventoryId: payload["inventoryId"] ?? "",
      adultBuyingPrice: payload["adultBuyingPrice"] ?? "",
      childBuyingPrice: payload["childBuyingPrice"] ?? "",
      infantBuyingPrice: payload["infantBuyingPrice"] ?? "",
      adultSellingPrice: payload["adultSellingPrice"] ?? "",
      childSellingPrice: payload["childSellingPrice"] ?? "",
      infantSellingPrice: payload["infantSellingPrice"] ?? "",
      companyBuyingPrice: payload["companyBuyingPrice"] ?? "",
      companySellingPrice: payload["companySellingPrice"] ?? "",
      agentBuyingPrice: payload["agentBuyingPrice"] ?? "",
      agentSellingPrice: payload["agentSellingPrice"] ?? "",
      subAgentBuyingPrice: payload["subAgentBuyingPrice"] ?? "",
      subAgentSellingPrice: payload["subAgentSellingPrice"] ?? "",
      finalSellingPrice: payload["finalSellingPrice"] ?? "",
      vatbuying: payload["vatbuying"] ?? "",
      vatselling: payload["vatselling"] ?? "",
      currencyFactor: payload["currencyFactor"] ?? "",
      agentPercentage: payload["agentPercentage"] ?? "",
      transferBuyingPrice: payload["transferBuyingPrice"] ?? "",
      transferSellingPrice: payload["transferSellingPrice"] ?? "",
      serviceBuyingPrice: payload["serviceBuyingPrice"] ?? "",
      serviceSellingPrice: payload["serviceSellingPrice"] ?? "",
      rewardPoints: payload["rewardPoints"] ?? "",
      tourChildAge: payload["tourChildAge"] ?? "",
      maxChildAge: payload["maxChildAge"] ?? "",
      maxInfantAge: payload["maxInfantAge"] ?? "",
      minimumPax: payload["minimumPax"] ?? "",
      pointRemark: payload["pointRemark"] ?? "",
      adultRetailPrice: payload["adultRetailPrice"] ?? "",
      childRetailPrice: payload["childRetailPrice"] ?? "",
      root_Id: payload["root_Id"] ?? -1,
      contractId: payload["contractId"] ?? -1,
      dateFlag: payload["dateFlag"] ?? -1,
      selectedTravelDate: payload["selectedTravelDate"] ?? ""

  );
}
