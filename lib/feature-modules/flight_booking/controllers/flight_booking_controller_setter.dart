part of 'flight_booking_controller.dart';

extension FlightBookingControllerSetter on FlightBookingController {

  setDestination(
      FlightDestination flightDestination, bool isArrival, int index) {
    FlightSearchData newFlightSearchData = FlightSearchData(
        promoCode: flightSearchData.value.promoCode,
        adults: flightSearchData.value.adults,
        child: flightSearchData.value.child,
        infants: flightSearchData.value.infants,
        searchList: flightBookingHelperServices.getUpdatedSearchList(
            flightSearchData.value, flightDestination, isArrival, index),
        allowedCabins: flightSearchData.value.allowedCabins,
        mode: flightSearchData.value.mode,
        isDirectFlight: flightSearchData.value.isDirectFlight);

    flightSearchData.value = newFlightSearchData;
  }

  setFlightMode(FlightMode newMode) {
    FlightSearchData newFlightSearchData = flightBookingHelperServices
        .setFlightMode(flightSearchData.value, newMode);
    flightSearchData.value = newFlightSearchData;
  }

  updateFlightCount(int index) {
    if (index == -1) {
      FlightSearchData newFlightSearchData = flightBookingHelperServices
          .addFlightSearchItem(flightSearchData.value);
      flightSearchData.value = newFlightSearchData;
    } else {
      FlightSearchData newFlightSearchData = flightBookingHelperServices
          .removeFlightSearchItem(flightSearchData.value, index);
      flightSearchData.value = newFlightSearchData;
    }
  }

  reverseTrip(int index) {
    FlightSearchData newFlightSearchData =
        flightBookingHelperServices.reverseTrip(flightSearchData.value, index);
    flightSearchData.value = newFlightSearchData;
  }

  changeDate(int index, bool isReturnDate, DateTime dateTime) {
    FlightSearchData newFlightSearchData = flightBookingHelperServices
        .changeDate(flightSearchData.value, index, dateTime, isReturnDate);
    flightSearchData.value = newFlightSearchData;
  }

  void updatePassengerCountAndCabinClass(int adultCount, int childCount,
      int infantCount, List<CabinClass> cabinClasses) {
    FlightSearchData newFlightSearchData =
        flightBookingHelperServices.updatePassengerCountAndCabinClass(
            flightSearchData.value,
            adultCount,
            childCount,
            infantCount,
            cabinClasses);
    flightSearchData.value = newFlightSearchData;
  }

  void updatePromoCode(String promoCode) {
    FlightSearchData newFlightSearchData = flightBookingHelperServices
        .updatePromoCode(flightSearchData.value, promoCode);
    flightSearchData.value = newFlightSearchData;
  }

  void updateDirectFlight(bool isDirectFlight) {
    FlightSearchData newFlightSearchData = flightBookingHelperServices
        .updateDirectFlight(flightSearchData.value, isDirectFlight);
    flightSearchData.value = newFlightSearchData;
  }

}
