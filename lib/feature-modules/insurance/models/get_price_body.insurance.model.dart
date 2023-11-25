class InsurancePriceGetBody {

  final String covidtype;
  final String policyplan;
  final String policy_type;
  final String policyperiod;

  InsurancePriceGetBody({
    required this.covidtype,
    required this.policyplan,
    required this.policy_type,
    required this.policyperiod,
  });

  Map toJson() {
    Map<String, dynamic> insurancePriceGetBody = {};
    insurancePriceGetBody["covidtype"] =  covidtype.toString();
    insurancePriceGetBody["policyplan"] =  policyplan.toString();
    insurancePriceGetBody["policy_type"] =  policy_type.toString();
    insurancePriceGetBody["policyperiod"] =  policyperiod.toString();
    return  insurancePriceGetBody;
  }

}



InsurancePriceGetBody mapInsurancePriceGetBody(dynamic payload) {

  return InsurancePriceGetBody(
    covidtype: payload["covidtype"] ?? "N",
    policyplan: payload["policyplan"] ?? "0",
    policy_type: payload["policy_type"] ?? "0",
    policyperiod: payload["policyperiod"] ?? "0",
  );

}