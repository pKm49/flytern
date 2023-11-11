class ActivityOption {
  final String tourId;
  final String tourOptionId;
  final String optionName;
  final String childAge;
  final String infantAge;
  final String optionDescription;
  final String cancellationPolicy;
  final String cancellationPolicyDescription;
  final String childPolicyDescription;
  final String xmlcode;
  final String xmloptioncode;
  final String countryId;
  final String cityId;
  final String minPax;
  final String maxPax;
  final String duration;
  final String timeZone;
  final String isWithoutAdult;
  final String isTourGuide;
  final String compulsoryOptions;
  final String isHideRateBreakup;
  final String isHourly;
  final String googleNavigation;
  final String address;
  final String termsAndConditions;
  final String displayName;
  final int resultId;

  ActivityOption(
      {required this.tourId,
      required this.tourOptionId,
      required this.optionName,
      required this.childAge,
      required this.infantAge,
      required this.optionDescription,
      required this.cancellationPolicy,
      required this.cancellationPolicyDescription,
      required this.childPolicyDescription,
      required this.xmlcode,
      required this.xmloptioncode,
      required this.countryId,
      required this.cityId,
      required this.minPax,
      required this.maxPax,
      required this.duration,
      required this.timeZone,
      required this.isWithoutAdult,
      required this.isTourGuide,
      required this.compulsoryOptions,
      required this.isHideRateBreakup,
      required this.isHourly,
      required this.googleNavigation,
      required this.address,
      required this.termsAndConditions,
      required this.displayName,
      required this.resultId});
}

ActivityOption mapActivityOption(dynamic payload) {
  return ActivityOption(
      tourId: payload["tourId"] ?? " ",
      tourOptionId: payload["tourOptionId"] ?? "",
      optionName: payload["optionName"] ?? "",
      childAge: payload["childAge"] ?? "",
      infantAge: payload["infantAge"] ?? "",
      optionDescription: payload["optionDescription"] ?? "",
      cancellationPolicy: payload["cancellationPolicy"] ?? "",
      cancellationPolicyDescription:
          payload["cancellationPolicyDescription"] ?? "",
      childPolicyDescription: payload["childPolicyDescription"] ?? "",
      xmlcode: payload["xmlcode"] ?? "",
      xmloptioncode: payload["xmloptioncode"] ?? "",
      countryId: payload["countryId"] ?? "",
      cityId: payload["cityId"] ?? "",
      minPax: payload["minPax"] ?? "",
      maxPax: payload["maxPax"] ?? "",
      duration: payload["duration"] ?? "",
      timeZone: payload["timeZone"] ?? "",
      isWithoutAdult: payload["isWithoutAdult"] ?? "",
      isTourGuide: payload["isTourGuide"] ?? "",
      compulsoryOptions: payload["compulsoryOptions"] ?? "",
      isHideRateBreakup: payload["isHideRateBreakup"] ?? "",
      isHourly: payload["isHourly"] ?? "",
      googleNavigation: payload["googleNavigation"] ?? "",
      address: payload["address"] ?? "",
      termsAndConditions: payload["termsAndConditions"] ?? "",
      displayName: payload["displayName"] ?? "",
      resultId: payload["resultId"] ?? 1);
}
