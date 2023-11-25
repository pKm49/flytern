import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_allowed_cabin.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/flight_search_response_dto_segment.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';

class InsuranceInitialData {
  final DateTime maxPolicyDate;
  final DateTime minPolicyDate;
  final DateTime maxDateOfBirth;
  final DateTime minDateOfBirth;
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
    maxPolicyDate: payload["maxPolicyDate"] != null
        ? DateTime.parse(getParsableDateString(payload["maxPolicyDate"] ))
        : DateTime.now().add(Duration(days: 180)),

    minPolicyDate: payload["minPolicyDate"] != null
        ? DateTime.parse(getParsableDateString(payload["minPolicyDate"] ))
        : DateTime.now() ,

    maxDateOfBirth: payload["maxDateOfBirth"] != null
        ? DateTime.parse(getParsableDateString(payload["maxDateOfBirth"] ))
        : DefaultMaximumDate ,
    minDateOfBirth: payload["minDateOfBirth"] != null
        ? DateTime.parse(getParsableDateString(payload["minDateOfBirth"] ))
        : DefaultMinimumDate ,

    knowYourPolicy: payload["knowYourPolicy"] ?? "",
    lstPolicyRelationship: lstPolicyRelationship,
    lstPolicyHeaderType: lstPolicyHeaderType,
    lstPolicyType: lstPolicyType,
    lstPolicyOption: lstPolicyOption,
    lstPolicyPeriod: lstPolicyPeriod,
    lstPolicyNationality: lstPolicyNationality,
  );
}
String getParsableDateString(String payload) {
  return payload.split("-").toList().reversed.join("-");
}