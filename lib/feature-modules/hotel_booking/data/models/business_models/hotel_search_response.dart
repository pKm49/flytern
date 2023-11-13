
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_response_dto_segment.dart';

class HotelSearchResponse {

  final bool isSale;
  final double finalPrc;
  final double totalPrc;
  final String airlineImageUrl;
  final String airlinescode;
  final String airlineName;
  final String currency;
  final bool isOneway;
  final bool isRefund;
  final String cabin;
  final int index;
  final int objectId;
  final int moreOptioncount;
  final List<HotelSearchResponseDtoSegment> dTOSegments;


  HotelSearchResponse({
   required this.isSale,
   required this.finalPrc,
   required this.totalPrc,
   required this.airlineImageUrl,
   required this.airlinescode,
   required this.airlineName,
   required this.currency,
   required this.isOneway,
   required this.isRefund,
   required this.cabin,
   required this.index,
   required this.objectId,
   required this.moreOptioncount,
   required this. dTOSegments
  });

}

HotelSearchResponse mapHotelSearchResponse(dynamic payload) {

  List<HotelSearchResponseDtoSegment> flightSearchResponseDtoSegments = [];
  if(payload["dTOSegments"] != null){
    payload["dTOSegments"].forEach((element) {
      flightSearchResponseDtoSegments.add(mapHotelSearchResponseDtoSegment(element));
    });
  }
  return HotelSearchResponse(
     isSale:payload["isSale"]??false,
     finalPrc:payload["finalPrc"]??0.0,
     totalPrc:payload["totalPrc"]??0.0,
     airlineImageUrl:payload["airlineImageUrl"]??"",
     airlinescode:payload["airlinescode"]??"",
     airlineName:payload["airlineName"]??"",
     currency:payload["currency"]??"",
     isOneway:getBoolean(payload["isOneway"]),
     isRefund:payload["isRefund"]??false,
     cabin:payload["cabin"]??"",
     index:payload["index"]??-1,
     objectId:payload["objectId"]??-1,
     moreOptioncount:payload["moreOptioncount"]??0,
      dTOSegments:flightSearchResponseDtoSegments,
  );
}

getBoolean(payload) {
  if(payload ==null){
    return false;
  }
  if(payload is bool){
    return payload;
  }

  if (payload is String && (payload=="true"||payload =="false")){
    return bool.parse(payload);
  }
  return false;
}