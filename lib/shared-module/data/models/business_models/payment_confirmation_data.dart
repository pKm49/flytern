 
class PaymentConfirmationData {
  final String pdfLink;
  final String alertMsg;
  final bool isIssued;

  PaymentConfirmationData(
      {required this.pdfLink,
      required this.alertMsg,
      required this.isIssued  });
}

PaymentConfirmationData mapPaymentpdfLinkData(dynamic payload) {
  return PaymentConfirmationData(
      pdfLink: payload["pdfLink"] ?? "",
      alertMsg: payload["alertMsg"]!=null?payload["alertMsg"][0] : "",
      isIssued: payload["isIssued"] ?? false );
}
