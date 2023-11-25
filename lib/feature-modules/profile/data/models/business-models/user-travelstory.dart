
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';

class UserTravelStory {

  final int  id;
  final String  title;
  final String rating;
  final String tripSummary;
  final String firstName;
  final String fileUrl;
  final String status;
  final String bookingRef;
  final String fileType;
  final DateTime createdOn;
  final String profileUrl;

  UserTravelStory({
    required this.tripSummary, required this.firstName, required this.fileUrl,
    required this.status, required this.bookingRef, required this.fileType,  required this.profileUrl,
    required this.id,
    required this.title,
    required this.createdOn,
    required this.rating,
  });

  Map toJson() => {
    'Title': title,
    'Rating': rating,
    'TripSummary': tripSummary,
  };

}

UserTravelStory mapUserTravelStory(dynamic payload){
  return UserTravelStory(
    rating:payload["rating"]??-1,
    id :payload["id"]??-1,
    title :payload["title"]??"",
    createdOn :(payload["createdOn"] != null && payload["createdOn"] != "")?
    DateTime.parse(payload["createdOn"]): DefaultInvalidDate,
    tripSummary: payload["tripSummary"]??"",
    firstName: payload["firstName"]??"",
    fileUrl: payload["fileUrl"]??"",
    status: payload["status"]??"",
    bookingRef: payload["bookingRef"]??"",
    fileType: payload["fileType"]??"",
    profileUrl: payload["profileUrl"]??"",
  );
}


