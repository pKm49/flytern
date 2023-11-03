import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_allowed_cabin.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response_dto_segment.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';

class InsuranceInitialData {
  final String maxPolicyDate;
  final String minPolicyDate;
  final String maxDateOfBirth;
  final String minDateOfBirth;
  final String knowYourPolicy;
  final List<GeneralItem> lstPolicyRelationship;
  final List<GeneralItem> lstPolicyHeaderType;
  final List<GeneralItem> lstPolicyType;
  final List<GeneralItem> lstPolicyOption;
  final List<GeneralItem> lstPolicyPeriod;
  final List<GeneralItem> lstPolicyNationality;

  InsuranceInitialData(
      {required this.maxPolicyDate,
      required this.minPolicyDate,
      required this.maxDateOfBirth,
      required this.minDateOfBirth,
      required this.knowYourPolicy,
      required this.lstPolicyRelationship,
      required this.lstPolicyHeaderType,
      required this.lstPolicyType,
      required this.lstPolicyOption,
      required this.lstPolicyPeriod,
      required this.lstPolicyNationality});
}

InsuranceInitialData mapInsuranceInitialData(dynamic payload) {
  List<GeneralItem> lstPolicyRelationship = [];
  List<GeneralItem> lstPolicyHeaderType = [];
  List<GeneralItem> lstPolicyType = [];
  List<GeneralItem> lstPolicyOption = [];
  List<GeneralItem> lstPolicyPeriod = [];
  List<GeneralItem> lstPolicyNationality = [];

  if (payload["_lstPolicyRelationship"] != null) {
    payload["_lstPolicyRelationship"].forEach((element) {
      lstPolicyRelationship.add(GeneralItem(
          id: element["code"] ?? "", name: element["information"] ?? ""));
    });
  }

  if (payload["_lstPolicyHeaderType"] != null) {
    payload["_lstPolicyHeaderType"].forEach((element) {
      lstPolicyHeaderType.add(GeneralItem(
          id: element["code"] ?? "", name: element["information"] ?? ""));
    });
  }

  if (payload["_lstPolicyType"] != null) {
    payload["_lstPolicyType"].forEach((element) {
      lstPolicyType.add(GeneralItem(
          id: element["typeCode"].toString(),
          name: element["information"] ?? ""));
    });
  }

  if (payload["_lstPolicyOption"] != null) {
    payload["_lstPolicyOption"].forEach((element) {
      lstPolicyOption.add(GeneralItem(
          id: element["optionCode"].toString(),
          name: element["information"] ?? ""));
    });
  }

  if (payload["_lstPolicyPeriod"] != null) {
    payload["_lstPolicyPeriod"].forEach((element) {
      lstPolicyPeriod.add(GeneralItem(
          id: element["periodCode"].toString(),
          name: element["information"] ?? ""));
    });
  }

  if (payload["_lstPolicyNationality"] != null) {
    payload["_lstPolicyNationality"].forEach((element) {
      lstPolicyNationality.add(GeneralItem(
          id: element["code"].toString(),
          name: element["information"] ?? ""));
    });
  }

  return InsuranceInitialData(
    maxPolicyDate: payload["maxPolicyDate"] ?? "",
    minPolicyDate: payload["minPolicyDate"] ?? "",
    maxDateOfBirth: payload["maxDateOfBirth"] ?? "",
    minDateOfBirth: payload["minDateOfBirth"] ?? "",
    knowYourPolicy: payload["knowYourPolicy"] ?? "",
    lstPolicyRelationship: lstPolicyRelationship,
    lstPolicyHeaderType: lstPolicyHeaderType,
    lstPolicyType: lstPolicyType,
    lstPolicyOption: lstPolicyOption,
    lstPolicyPeriod: lstPolicyPeriod,
    lstPolicyNationality: lstPolicyNationality,
  );
}
