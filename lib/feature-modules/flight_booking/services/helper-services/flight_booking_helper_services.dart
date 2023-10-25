import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';

class FlightBookingHelperServices{

  List<FlightSearchItem> getUpdatedSearchList(FlightSearchData flightSearchData,
      FlightDestination flightDestination, bool isArrival, int index) {
    List<FlightSearchItem> flightSearchItems = [];


    for (var i = 0; i < flightSearchData.searchList.length; i++) {
      if (index != i) {
        flightSearchItems.add(flightSearchData.searchList[i]);
      } else {
        FlightSearchItem flightSearchItem = FlightSearchItem(
            departure: !isArrival ? flightDestination : flightSearchData.searchList[i].departure ,
            arrival: isArrival ? flightDestination : flightSearchData .searchList[i].arrival,
            departureDate: flightSearchData.searchList[i].departureDate,
            returnDate: flightSearchData.searchList[i].returnDate
        );
        flightSearchItems.add(flightSearchItem);
      }
    }
    return flightSearchItems;
  }

  FlightSearchData setFlightMode(FlightSearchData flightSearchData,FlightMode newMode){

    return FlightSearchData(
        promoCode: flightSearchData.promoCode,
        adults: flightSearchData.adults,
        child: flightSearchData.child,
        infants: flightSearchData.infants,
        searchList: flightSearchData.searchList,
        allowedCabins: flightSearchData.allowedCabins,
        mode: newMode,
        isDirectFlight: flightSearchData.isDirectFlight);

  }

  FlightSearchData addFlightSearchItem(FlightSearchData flightSearchData ){

    List<FlightSearchItem> flightSearchItems = flightSearchData.searchList;

    FlightSearchItem flightSearchItem = FlightSearchItem(
        departure: flightSearchData.searchList[flightSearchData.searchList.length-1].arrival ,
        arrival: flightSearchData.searchList[flightSearchData.searchList.length-1].departure,
        departureDate: DateTime.now(),
        returnDate:DateTime.now()
    );
    flightSearchItems.add(flightSearchItem);
    return FlightSearchData(
        promoCode: flightSearchData.promoCode,
        adults: flightSearchData.adults,
        child: flightSearchData.child,
        infants: flightSearchData.infants,
        searchList: flightSearchItems,
        allowedCabins: flightSearchData.allowedCabins,
        mode: flightSearchData.mode,
        isDirectFlight: flightSearchData.isDirectFlight);

  }

  FlightSearchData removeFlightSearchItem(FlightSearchData flightSearchData, int index ){

    List<FlightSearchItem> flightSearchItems = [];

    for (var i = 0; i < flightSearchData.searchList.length; i++) {
      if (index != i) {
        flightSearchItems.add(flightSearchData.searchList[i]);
      }
    }
    return FlightSearchData(
        promoCode: flightSearchData.promoCode,
        adults: flightSearchData.adults,
        child: flightSearchData.child,
        infants: flightSearchData.infants,
        searchList: flightSearchItems,
        allowedCabins: flightSearchData.allowedCabins,
        mode: flightSearchData.mode,
        isDirectFlight: flightSearchData.isDirectFlight);

  }
}