import 'package:flytern/feature-modules/flight_booking/constants/flight_mode.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/allowed_cabin.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_item.flight_booking.model.dart';

class FlightSearchData {

  final String promoCode;
  final int adults;
  final int child;
  final int infants;
  final List<FlightSearchItem> searchList;
  final List<FlightAllowedCabin> allowedCabins;
  final FlightMode mode;
  final bool isDirectFlight;

  FlightSearchData({
    required this.promoCode,
    required this.adults,
    required this.child,
    required this.infants,
    required this.searchList,
    required this.allowedCabins,
    required this.mode,
    required this.isDirectFlight,
  });

  Map toJson() =>
      {
        'promoCode': promoCode,
        'adults': adults,
        'child': child,
        'infants': infants,
        'searchList': getSearchList(searchList),
        'allowedCabins': getAllowedCabins(allowedCabins),
        'mode': mode.name,
        'isDirectFlight': isDirectFlight,
      };

  List<dynamic> getSearchList(List<FlightSearchItem> searchList) {
    List<dynamic> searchLists = [];
    searchList.forEach((element) {
      if(element != null){
        searchLists.add(element.toJson());
      }

    });
    return searchLists;
  }

  List<dynamic> getAllowedCabins(List<FlightAllowedCabin> allowedCabins) {
    List<dynamic> allowedCabinsList = [];
    allowedCabins.forEach((element) {
      if(element != null){
        allowedCabinsList.add(element.toJson());
      }
    });
    return allowedCabinsList;
  }

}


FlightSearchData mapFlightSearchData(dynamic payload){

  List<FlightSearchItem> searchList = [];
  List<FlightAllowedCabin> allowedCabins = [];

  if(payload["searchList"] != null){
    payload["searchList"].forEach((element) {
      if(element != null){
        searchList.add(mapFlightSearchItem(element));
      }

    });
  }


  if(payload["allowedCabins"] != null){
    payload["allowedCabins"].forEach((element) {
      if(element != null){
        allowedCabins.add(mapFlightAllowedCabin(element));
      }

    });
  }

  return FlightSearchData(
      promoCode: payload["promoCode"]??"",
      adults:payload["adults"]??0,
      child: payload["child"]??0,
      infants: payload["infants"]??0,
      searchList: searchList,
      allowedCabins: allowedCabins,
      mode: getMode(payload["mode"]),
      isDirectFlight: payload["isDirectFlight"]??false,
  );
}

getMode(mode) {

  if(mode == FlightMode.ONEWAY.name ){
    return FlightMode.ONEWAY;
  }
  if(mode == FlightMode.ROUNDTRIP.name ){
    return FlightMode.ROUNDTRIP;
  }
  if(mode == FlightMode.MULTICITY.name ){
    return FlightMode.MULTICITY;
  }
  return FlightMode.ROUNDTRIP;

}

FlightSearchData getDefaultFlightSearchData() {
  return FlightSearchData(
      promoCode: "",
      adults:1,
      child: 0,
      infants: 0,
      searchList: [getDefaultFlightSearchItem()],
      allowedCabins: [],
      mode: FlightMode.ROUNDTRIP,
      isDirectFlight: false
  );
}