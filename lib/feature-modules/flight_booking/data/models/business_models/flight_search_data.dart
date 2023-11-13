import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_allowed_cabin.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';

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
      searchLists.add(element.toJson());
    });
    return searchLists;
  }

  List<dynamic> getAllowedCabins(List<FlightAllowedCabin> allowedCabins) {
    List<dynamic> allowedCabinsList = [];
    allowedCabins.forEach((element) {
      allowedCabinsList.add(element.toJson());
    });
    return allowedCabinsList;
  }





}

FlightSearchData getDefaultFlightSearchData() {
  return FlightSearchData(
      promoCode: "",
      adults:1,
      child: 0,
      infants: 0,
      searchList: [getDefaultFlightSearchItem()],
      allowedCabins: [],
      mode: FlightMode.ONEWAY,
      isDirectFlight: false
  );
}