
class InsurancePriceData {
  final String code;
  final double price; 

  InsurancePriceData(
      {required this.code,
      required this.price });
}

InsurancePriceData mapInsurancePriceData(dynamic payload) { 

  return InsurancePriceData(
    code: payload["code"] ?? "",
    price: payload["price"] ?? 0.0, 
  );

}
