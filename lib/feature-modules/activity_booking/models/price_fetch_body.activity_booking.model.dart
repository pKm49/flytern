import 'package:intl/intl.dart';

class ActivityPriceFetchBody {

  final int contractId;
  final int objectID;
  final int transferId;
  final int tourid;
  final int cityid;
  final int touroptionid;
  final DateTime travelDate;
  final String noOfAdult;
  final String noOfChildren;
  final String noOfInfant;
  final String tourGuide;
  final String startTime;
  final String timeSlotId;

  ActivityPriceFetchBody({
    required this.contractId,
    required this.objectID,
    required this.transferId,
    required this.tourid,
    required this.cityid,
    required this.touroptionid,
    required this.travelDate,
    required this.noOfAdult,
    required this.noOfChildren,
    required this.noOfInfant,
    required this.tourGuide,
    required this.startTime,
    required this.timeSlotId,
  });

  Map toJson() => {
    'transferId': transferId,
    'tourid': tourid,
    'cityid': cityid,
    'touroptionid': touroptionid,
    'travelDate': getFormattedDate(travelDate),
    'noOfAdult': noOfAdult,
    'noOfChildren': noOfChildren,
    'noOfInfant': noOfInfant,
  };

  Map toOptionTimingJson() => {
    'contractId': contractId,
    'objectID': objectID,
    'transferId': transferId,
    'tourid': tourid,
    'cityid': cityid,
    'touroptionid': touroptionid,
    'travelDate': getFormattedDate(travelDate),
    'noOfAdult': noOfAdult,
    'noOfChildren': noOfChildren,
    'noOfInfant': noOfInfant,
  };

  Map toActivityConfirmJson() => {
    'adult': noOfAdult,
    'child': noOfChildren,
    'infant': noOfInfant,
    'contractId': contractId,
    'tourGuide': tourGuide,
    'startTime': startTime,
    'timeSlotId': timeSlotId,
    'transferId': transferId,
    'tourId': tourid,
    'tourOptionId': touroptionid,
    'travelDate': getFormattedDate(travelDate),
  };

  Map toTravelDataJson() => {
    'adult': noOfAdult,
    'child': noOfChildren,
    'infant': noOfInfant,
    'contractId': contractId,
    'objectID': objectID,
    'startTime': startTime,
    'timeSlotId': timeSlotId,
    'transferId': transferId,
    'tourId': tourid,
    'tourOptionId': touroptionid,
    'travelDate': getFormattedDate(travelDate),
  };

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }
}

