part of 'flight_booking_controller.dart';

extension FlightBookingControllerSetter on FlightBookingController {

  // Search setters
  getFilterValues(List<SortingDcs> value) {
    String filterString = "";
    for (var i=0;i< value.length;i++) {
      filterString +=  value[i].value;
      if(i!=(value.length-1)  ){
        filterString +=",";
      }
    }
    return filterString;
  }

  void toggleModifierVisibility() {
    isModifySearchVisible.value = !isModifySearchVisible.value;
  }

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

  changeDate(int index, bool isReturnDate, DateTime dateTime, bool isFilter) {
    print("changedate");
    print(index);
    print(isReturnDate);
    print(dateTime);
    print(dateTime);
    FlightSearchData newFlightSearchData = flightBookingHelperServices
        .changeDate(flightSearchData.value, index, dateTime, isReturnDate);
    flightSearchData.value = newFlightSearchData;
    if(isFilter){
      getSearchResults(false);
    }
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

  void updateSort(String sortingDcValue) {

    List<SortingDcs> tempSortingDcs = sortingDcs.value.where((element) => element.value==sortingDcValue).toList();
    if(tempSortingDcs.isNotEmpty){
      sortingDc.value = tempSortingDcs[0];
      filterSearchResults();
    }

  }

  setFilterValues(FlightSearchResult selectedFilterOptions){

    selectedPriceDcs.value = selectedFilterOptions.priceDcs;
    selectedArrivalTimeDcs.value = selectedFilterOptions.arrivalTimeDcs;
    selectedDepartureTimeDcs.value = selectedFilterOptions.departureTimeDcs;
    selectedAirlineDcs.value = selectedFilterOptions.airlineDcs;
    selectedStopDcs.value = selectedFilterOptions.stopDcs;

    filterSearchResults();


  }



}
