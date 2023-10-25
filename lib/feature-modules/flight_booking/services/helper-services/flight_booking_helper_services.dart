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


}