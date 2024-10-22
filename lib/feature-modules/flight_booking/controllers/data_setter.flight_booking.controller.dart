part of 'flight_booking.controller.dart';

extension FlightBookingControllerSetter on FlightBookingController {


  saveAddonsPrice() {
    double seatTotal = 0.0;
    flightAddonSetSeatData.value.listOfSelection.forEach((element) {
      if (element.amount > 0.0) {
        seatTotal += element.amount;
      }
    });
    seatTotalAmount.value = seatTotal;
    double mealTotal = 0.0;
    flightAddonSetMealData.value.listOfSelection.forEach((element) {
      if (element.amount > 0.0) {
        mealTotal += element.amount;
      }
    });
    mealTotalAmount.value = mealTotal;

    double extraPackageTotal = 0.0;
    flightAddonSetExtraPackageData.value.listOfSelection.forEach((element) {
      if (element.amount > 0.0) {
        extraPackageTotal += element.amount;
      }
    });

    baggageTotalAmount.value = extraPackageTotal;
  }

  // Search setters
  getFilterValues(List<SortingDcs> value) {
    String filterString = "";
    for (var i = 0; i < value.length; i++) {
      filterString += value[i].value;
      if (i != (value.length - 1)) {
        filterString += ",";
      }
    }
    return filterString;
  }

  void toggleModifierVisibility() {
    isModifySearchVisible.value = !isModifySearchVisible.value;
  }

  setDestination(FlightDestination flightDestination, bool isArrival,
      int index) {
    resetDestinations();
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
      if (flightSearchData.value.searchList.length < 5) {
        FlightSearchData newFlightSearchData = flightBookingHelperServices
            .addFlightSearchItem(flightSearchData.value);
        flightSearchData.value = newFlightSearchData;
      }
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

  changeDateTab(  DateTime dateTime ) {
    debugPrint("changeDateTab");
    FlightSearchData newFlightSearchData = flightBookingHelperServices
        .changeDate(flightSearchData.value, 0, dateTime, false);
    flightSearchData.value = newFlightSearchData;
    getSearchResults(false,true);
  }

  changeDate(int index, bool isReturnDate, DateTime dateTime ) {
    debugPrint("changeDate");
    debugPrint(index.toString());
    debugPrint(flightSearchData.value.searchList.length.toString());

    FlightSearchData newFlightSearchData = flightBookingHelperServices
        .changeDate(flightSearchData.value, index, dateTime, isReturnDate);

    if (!isReturnDate && flightSearchData.value.searchList[index]
        .returnDate != null &&
        dateTime.isAfter(flightSearchData.value.searchList[index]
            .returnDate!)) {
      newFlightSearchData = flightBookingHelperServices
          .changeDate(newFlightSearchData, index, dateTime, true);
    }
    startDate.value = newFlightSearchData.searchList[0].departureDate;

    if(flightSearchData.value.searchList.length>1 &&
        index < flightSearchData.value.searchList.length -1){

      for(var i = index+1; i<flightSearchData.value.searchList.length;i++){
        if(dateTime.isBefore(flightSearchData.value.searchList[index]
            .returnDate!))
          newFlightSearchData = flightBookingHelperServices
            .changeDate(newFlightSearchData, i , dateTime, false);
      }

    }

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

  void updateSort(String sortingDcValue) {
    List<SortingDcs> tempSortingDcs = sortingDcs.value.where((
        element) => element.value == sortingDcValue).toList();
    if (tempSortingDcs.isNotEmpty) {
      sortingDc.value = tempSortingDcs[0];
      filterSearchResults();
    }
  }

  setFilterValues(FlightSearchResult selectedFilterOptions) {
    selectedPriceDcs.value = selectedFilterOptions.priceDcs;
    selectedArrivalTimeDcs.value = selectedFilterOptions.arrivalTimeDcs;
    selectedDepartureTimeDcs.value = selectedFilterOptions.departureTimeDcs;
    selectedAirlineDcs.value = selectedFilterOptions.airlineDcs;
    selectedStopDcs.value = selectedFilterOptions.stopDcs;

    filterSearchResults();
  }

  void saveContactInfo(String tMobileCntry, String tMobileNumber,
      String tEmail) {
    mobileCntry.value = tMobileCntry;
    mobileNumber.value = tMobileNumber;
    email.value = tEmail;
  }

  void saveTravellersData(List<TravelInfo> travelInfo) {
    String validityString = "";
    for (var i = 0; i < travelInfo.length; i++) {
      if (travelInfo[i].title == "Title" || travelInfo[i].title == "0") {
        validityString = "enter_title_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }


      if (travelInfo[i].firstName.length < 3) {
        validityString = "enter_firstname_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

      if (travelInfo[i].lastName.length < 3) {
        validityString = "enter_lastname_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

      if (travelInfo[i].gender == "Select" || travelInfo[i].gender == "0") {
        validityString = "enter_gender_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

      if (travelInfo[i].dateOfBirth == DefaultInvalidDate) {
        validityString = "enter_dob_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

      if (travelInfo[i].nationalityCode == "") {
        validityString = "enter_nationality_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

      if (travelInfo[i].passportNumber == "") {
        validityString = "enter_passportnumber_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

      if (travelInfo[i].passportIssuedCountryCode == "") {
        validityString = "enter_passportcountry_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

      if (travelInfo[i].passportExpiryDate == DefaultInvalidDate) {
        validityString = "enter_passportexpiry_copax".tr.replaceAll(
            "user", "${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
    }

    if (validityString != "") {
      showSnackbar(Get.context!, validityString, "error");
    } else {
      setPreTravellerData(travelInfo);
    }

    // Get.toNamed(Approute_flightsSummary);
  }

  getIndex(int itemTypeIndex, int localIndex) {

    int total = flightPretravellerData.value.adult +
        flightPretravellerData.value.child +
        flightPretravellerData.value.infant;

    switch (itemTypeIndex) {
      case 0:
        {
          return localIndex;
        }
      case 1:
        {
          return (localIndex-flightPretravellerData.value.adult);
        }
      case 2:
        {
          return (localIndex-(flightPretravellerData.value.adult + flightPretravellerData.value.child))  ;
        }
    }
  }

  void resetMulticityDates(int index, DateTime dateTime ) {
    for(var i = index; i<flightSearchData.value.searchList.length;i++){
      FlightSearchData newFlightSearchData = flightBookingHelperServices
          .changeDate(flightSearchData.value, i , dateTime, false);
    }
  }


}
