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

  Map toJson() => {
    'covidtype': covidtype,
    'policyplan': policyplan,
    'policy_type': policy_type,
    'policyperiod': policyperiod,
  };

}

