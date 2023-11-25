import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';

//"displayName": "Credit Card",
//                 "processID": "2",
//                 "paymentCode": "CreditCard",
//                 "gatewayImageUrl": "https://travelmate.net/tmadms/cms/img/creditcard.png",
//                 "currencyCode": "KWD",
//                 "totalAmount": 100.0,
//                 "processingFee": 2.5,
//                 "discount": 1.0,
//                 "finalAmount": 96.5
class PaymentGateway {
  final String displayName;
  final String processID;
  final String paymentCode;
  final String gatewayImageUrl;
  final String currencyCode;
  final double totalAmount;
  final double processingFee;
  final double discount;
  final double finalAmount;

  PaymentGateway(
      {required this.displayName,
      required this.processID,
      required this.paymentCode,
      required this.gatewayImageUrl,
      required this.currencyCode,
      required this.totalAmount,
      required this.processingFee,
      required this.discount,
      required this.finalAmount});
}

PaymentGateway mapPaymentGateway(dynamic payload) {
  return PaymentGateway(
      displayName: payload["displayName"] ?? "",
      processID: payload["processID"] ?? "",
      paymentCode: payload["paymentCode"] ?? "",
      gatewayImageUrl: payload["gatewayImageUrl"] ?? "",
      currencyCode: payload["currencyCode"] ?? "",
      totalAmount: payload["totalAmount"] ?? 0.0,
      processingFee: payload["processingFee"] ?? 0.0,
      discount: payload["discount"] ?? 0.0,
      finalAmount: payload["finalAmount"] ?? 0.0);
}
