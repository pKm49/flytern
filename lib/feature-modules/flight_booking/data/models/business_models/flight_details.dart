import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_info.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_segment.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_segment_buggage_details.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_segment_details.dart';

class FlightDetails {
  final String priceChangedMessage;
  final String scheduleChangedMessage;
  final String selectedCabinId;
  final String selectedCabinName;
  final String errorMessage;
  final String fareRule;
  final String warningMessage;
  final bool isRefund;
  final bool priceChanged;
  final bool scheduleChanged;
  final int objectId;
  final int detailId;
  final int adult;
  final int child;
  final int infant;
  final List<FlightSegment> flightSegments;
  final List<CabinInfo> cabinInfos;

  FlightDetails(
      {required this.priceChangedMessage,
      required this.scheduleChangedMessage,
      required this.selectedCabinId,
      required this.selectedCabinName,
      required this.errorMessage,
      required this.warningMessage,
      required this.fareRule,
      required this.isRefund,
      required this.priceChanged,
      required this.scheduleChanged,
      required this.objectId,
      required this.detailId,
      required this.adult,
      required this.child,
      required this.infant,
      required this.flightSegments,
      required this.cabinInfos});
}

FlightDetails mapFlightDetails(dynamic payload) {
  List<FlightSegment> flightSegments = [];
  List<CabinInfo> cabinInfos = [];
  String fareRule = "";
  String errorMessage = "";
  String warningMessage = "";

  if (payload["flightSegments"] != null) {
    payload["flightSegments"].forEach((element) {
      flightSegments.add(mapFlightSegment(element));
    });
  }
  if (payload["_lstCabinInfos"] != null) {
    payload["_lstCabinInfos"].forEach((element) {
      cabinInfos.add(mapCabinInfo(element));
    });
  }

  if (payload["fareRule"] != null) {
    if (payload["fareRule"] is String) {
      fareRule = payload["fareRule"];
    } else {
      payload["fareRule"].forEach((element) {
        fareRule += payload["fareRule"];
      });
    }
  }

  if (payload["errorMessage"] != null) {
    if (payload["errorMessage"] is String) {
      errorMessage = payload["errorMessage"];
    } else {
      payload["errorMessage"].forEach((element) {
        errorMessage += payload["errorMessage"];
      });
    }
  }

  if (payload["warningMessage"] != null) {
    if (payload["warningMessage"] is String) {
      warningMessage = payload["warningMessage"];
    } else {
      payload["warningMessage"].forEach((element) {
        warningMessage += payload["warningMessage"];
      });
    }
  }

  return FlightDetails(
    priceChangedMessage: payload["priceChangedMessage"] ?? "",
    selectedCabinName: payload["selectedCabinName"] ?? "",
    selectedCabinId: payload["selectedCabinId"] ?? "",
    scheduleChangedMessage: payload["scheduleChangedMessage"] ?? "",
    flightSegments: flightSegments,
    cabinInfos: cabinInfos,
    fareRule: fareRule,
    errorMessage: errorMessage,
    warningMessage: warningMessage,
    isRefund: payload["isRefund"] ?? false,
    priceChanged: payload["priceChanged"] ?? false,
    scheduleChanged: payload["scheduleChanged"] ?? false,
    objectId: payload["objectId"] ?? -1,
    detailId: payload["detailId"] ?? -1,
    adult: payload["adult"] ?? -1,
    child: payload["child"] ?? -1,
    infant: payload["infant"] ?? -1,
  );
}
