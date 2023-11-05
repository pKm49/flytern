 
class PaymentGatewayUrlData {
  final String gatewayUrl;
  final String confirmationUrl;
  final bool isOkRedirection;
  final String bookingRef;

  PaymentGatewayUrlData(
      {required this.gatewayUrl,
      required this.confirmationUrl,
      required this.isOkRedirection,
      required this.bookingRef });
}

PaymentGatewayUrlData mapPaymentGatewayUrlData(dynamic payload) {
  return PaymentGatewayUrlData(
      gatewayUrl: payload["gatewayUrl"] ?? "",
      confirmationUrl: payload["confirmationUrl"] ?? "",
      isOkRedirection: payload["isOkRedirection"] ?? "",
      bookingRef: payload["bookingRef"] ?? "");
}
