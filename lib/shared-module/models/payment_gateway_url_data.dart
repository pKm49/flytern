 
class PaymentGatewayUrlData {
  final String gatewayUrl;
  final String confirmationUrl;
  final bool isOkRedirection;
  final String bookingRef;
  final String paymentRef;

  PaymentGatewayUrlData(
      {required this.gatewayUrl,
      required this.confirmationUrl,
      required this.isOkRedirection,
      required this.paymentRef,
      required this.bookingRef });
}

PaymentGatewayUrlData mapPaymentGatewayUrlData(dynamic payload) {
  return PaymentGatewayUrlData(
      gatewayUrl: payload["gatewayUrl"] ?? "",
      confirmationUrl: payload["confirmationUrl"] ?? "",
      paymentRef: payload["paymentRef"] ?? "",
      isOkRedirection: payload["isOkRedirection"] ?? false,
      bookingRef: payload["bookingRef"] ?? "");
}
