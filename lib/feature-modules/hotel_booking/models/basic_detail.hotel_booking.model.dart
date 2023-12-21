
class HotelBasicDetail {
  
  final String policyName;
  final String policyText;

  HotelBasicDetail(
      {required this.policyName,
      required this.policyText, });
}

HotelBasicDetail mapHotelBasicDetail(dynamic payload) {

  return HotelBasicDetail(
    policyName: payload["policyName"] ?? "",
    policyText: payload["policyText"] ?? "",
  );
}
