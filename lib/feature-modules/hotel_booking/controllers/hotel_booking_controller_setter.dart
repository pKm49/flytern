part of 'hotel_booking_controller.dart';

extension HotelBookingControllerSetter on HotelBookingController {

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
      HotelDestination hotelDestination ) {

    selectedDestination.value = hotelDestination;
    destination.value = hotelDestination.cityCode;


    HotelSearchData newHotelSearchData = HotelSearchData(
        destination: hotelDestination.cityCode,
        checkInDate: hotelSearchData.value.checkInDate,
        checkOutDate: hotelSearchData.value.checkOutDate,
        nationalityCode: hotelSearchData.value.nationalityCode,
        rooms: hotelSearchData.value.rooms);

    hotelSearchData.value = newHotelSearchData;
  }

  updateHotelRoomCount(int index) {
    if (index == -1) {
      HotelSearchData newHotelSearchData = hotelBookingHelperServices
          .addHotelRoom(hotelSearchData.value);
      hotelSearchData.value = newHotelSearchData;
    } else {
      HotelSearchData newHotelSearchData = hotelBookingHelperServices
          .removeHotelRoom(hotelSearchData.value, index);
      hotelSearchData.value = newHotelSearchData;
    }
  }


  changeDate(int index, bool isReturnDate, DateTime dateTime, bool isFilter) {
    print("changedate");
    print(index);
    print(isReturnDate);
    print(dateTime);
    print(dateTime);
    HotelSearchData newHotelSearchData = hotelBookingHelperServices
        .changeDate(hotelSearchData.value,dateTime, isReturnDate);
    hotelSearchData.value = newHotelSearchData;
    if(isFilter){
      getSearchResults(false);
    }
  }

  void updatePassengerCount(int index,int adultCount, int childCount,
     List<int> childAges ) {
    HotelSearchData newHotelSearchData =
        hotelBookingHelperServices.updatePassengerCount(
            hotelSearchData.value,
            index,
            adultCount,
            childCount,  childAges);
    hotelSearchData.value = newHotelSearchData;
  }

  void updatePromoCode(Country nationality) {

    hotelSearchData.value = HotelSearchData(
        destination: hotelSearchData.value.destination,
        checkInDate: hotelSearchData.value.checkInDate,
        checkOutDate: hotelSearchData.value.checkOutDate,
        nationalityCode: nationality.countryISOCode,
        rooms: hotelSearchData.value.rooms);
  }

  void updateSort(String sortingDcValue) {

    List<SortingDcs> tempSortingDcs = sortingDcs.value.where((element) => element.value==sortingDcValue).toList();
    if(tempSortingDcs.isNotEmpty){
      sortingDc.value = tempSortingDcs[0];
      filterSearchResults();
    }

  }

  setFilterValues(HotelSearchResult selectedFilterOptions){

    selectedPriceDcs.value = selectedFilterOptions.priceDcs;
    selectedArrivalTimeDcs.value = selectedFilterOptions.arrivalTimeDcs;
    selectedDepartureTimeDcs.value = selectedFilterOptions.departureTimeDcs;
    selectedAirlineDcs.value = selectedFilterOptions.airlineDcs;
    selectedStopDcs.value = selectedFilterOptions.stopDcs;

    filterSearchResults();


  }

  void saveContactInfo(String tMobileCntry, String tMobileNumber, String tEmail) {
    mobileCntry.value =tMobileCntry;
    mobileNumber.value =tMobileNumber;
    email.value =tEmail;
  }

  void saveTravellersData(List<HotelTravelInfo> travelInfo) {
    String validityString = "";
    for (var i = 0; i < travelInfo.length; i++) {

      print("travelInfo "+i.toString());
      print("title");
      print(travelInfo[i].title);

      if (travelInfo[i].title == "Title"|| travelInfo[i].title == "") {
        validityString = "enter_title_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print("firstName");
      print(travelInfo[i].firstName);

      if (travelInfo[i].firstName == "") {
        validityString = "enter_firstname_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print("lastName");
      print(travelInfo[i].lastName);
      if (travelInfo[i].lastName == "") {
        validityString = "enter_lastname_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print("gender");
      print(travelInfo[i].gender);
      if (travelInfo[i].gender == "Select" || travelInfo[i].gender == "") {
        validityString = "enter_gender_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print("dateOfBirth");
      print(travelInfo[i].dateOfBirth);
      print(DefaultInvalidDate);

      if (travelInfo[i].dateOfBirth == DefaultInvalidDate) {
        validityString = "enter_dob_copax".tr.replaceAll(
            "user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print(travelInfo[i].nationalityCode);

      if (travelInfo[i].nationalityCode == "") {
        validityString = "enter_nationality_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print(travelInfo[i].passportNumber);

      if (travelInfo[i].passportNumber == "") {
        validityString = "enter_passportnumber_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print(travelInfo[i].passportIssuedCountryCode);

      if (travelInfo[i].passportIssuedCountryCode == "") {
        validityString = "enter_passportcountry_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }
      print(travelInfo[i].passportExpiryDate);

      if (travelInfo[i].passportExpiryDate == DefaultInvalidDate) {
        validityString = "enter_passportexpiry_copax".tr.replaceAll("user","${travelInfo[i].travellerType} ${getIndex(
            travelInfo[i].travellerType == "Adult"
                ? 0
                : travelInfo[i].travellerType == "Child"
                ? 1
                : 2,
            travelInfo[i].no)}");

        break;
      }

    }

    if(validityString!=""){
      showSnackbar(Get.context!, validityString,"error");
    }else{
      setPreTravellerData(travelInfo);
    }

    // Get.toNamed(Approute_hotelsSummary);
  }

  getIndex(int itemTypeIndex, int localIndex) {
    int total = hotelPretravellerData.value.adult +
        hotelPretravellerData.value.child +
        hotelPretravellerData.value.infant;

    switch (itemTypeIndex) {
      case 0:
        {
          return localIndex  ;
        }
      case 1:
        {
          return ((total - hotelPretravellerData.value.adult) -
              (localIndex  ))+1;
        }
      case 2:
        {
          return ((total -
              (hotelPretravellerData.value.adult +
                  hotelPretravellerData.value.child)) -
              (localIndex  ))+1;
        }
    }
  }

}
