part of 'hotel_booking.controller.dart';

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
        cityCode: hotelDestination.cityCode,
        countryCode: hotelDestination.countryCode,
        hotelCode: hotelDestination.hotelCode,
        destination: hotelDestination.uniqueCombination,
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


  changeDate(  bool isCheckoutDate, DateTime dateTime ) {

    HotelSearchData newHotelSearchData = hotelBookingHelperServices
        .changeDate(hotelSearchData.value,dateTime, isCheckoutDate);

    if(!isCheckoutDate && (dateTime.isAfter(hotelSearchData.value.checkOutDate) || (
        dateTime.day == hotelSearchData.value.checkOutDate.day && dateTime.month==hotelSearchData.value.checkOutDate.month
        && dateTime.year == hotelSearchData.value.checkOutDate.year
    ))){

      newHotelSearchData = hotelBookingHelperServices
          .changeDate(newHotelSearchData, dateTime.add(Duration(days: 1)), true);

    }
    hotelSearchData.value = newHotelSearchData;

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


  Future<void> updateNationality(Country tNationality) async {

    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("hotelnationality", tNationality.code);

    nationality.value = tNationality;


    hotelSearchData.value = HotelSearchData(
        cityCode: hotelSearchData.value.cityCode,
        countryCode: hotelSearchData.value.countryCode,
        hotelCode: hotelSearchData.value.hotelCode,
        destination: hotelSearchData.value.destination,
        checkInDate: hotelSearchData.value.checkInDate,
        checkOutDate: hotelSearchData.value.checkOutDate,
        nationalityCode: tNationality.countryISOCode,
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
    selectedratingDcs.value = selectedFilterOptions.ratingDcs;
    selectedlocationDcs.value = selectedFilterOptions.locationDcs;

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

      if (travelInfo[i].title == "Title"|| travelInfo[i].title == "0") {
        if(travelInfo[i].travellerType == "Adult"){
          validityString = "enter_title_hotel_room_adult".tr.replaceAll("-1",
              "${travelInfo[i].typeIndex}");
          validityString = validityString.replaceAll("-2",
              "${travelInfo[i].roomIndex+1}");
        }else{
          if(travelInfo[i].travellerType == "Child"){
            validityString = "enter_title_hotel_room_child".tr.replaceAll("-1",
                "${travelInfo[i].typeIndex}");
            validityString = validityString.replaceAll("-2",
                "${travelInfo[i].roomIndex+1}");
          }
        }


        break;
      }
       if (travelInfo[i].firstName.length<3) {

        if(travelInfo[i].travellerType == "Adult"){
          validityString = "enter_firstname_hotel_room_adult".tr.replaceAll("-1",
              "${travelInfo[i].typeIndex}");
          validityString = validityString.replaceAll("-2",
              "${travelInfo[i].roomIndex+1}");
        }else{
          if(travelInfo[i].travellerType == "Child"){
            validityString = "enter_firstname_hotel_room_child".tr.replaceAll("-1",
                "${travelInfo[i].typeIndex}");
            validityString = validityString.replaceAll("-2",
                "${travelInfo[i].roomIndex+1}");
          }
        }

        break;
      }
       if (travelInfo[i].lastName.length<3) {
        if(travelInfo[i].travellerType == "Adult"){
          validityString = "enter_lastname_hotel_room_adult".tr.replaceAll("-1",
              "${travelInfo[i].typeIndex}");
          validityString = validityString.replaceAll("-2",
              "${travelInfo[i].roomIndex+1}");
        }else{
          if(travelInfo[i].travellerType == "Child"){
            validityString = "enter_lastname_hotel_room_child".tr.replaceAll("-1",
                "${travelInfo[i].typeIndex}");
            validityString = validityString.replaceAll("-2",
                "${travelInfo[i].roomIndex+1}");
          }
        }

        break;
      }
       if (travelInfo[i].gender == "Select" || travelInfo[i].gender == "") {

        if(travelInfo[i].travellerType == "Adult"){
          validityString = "enter_gender_hotel_room_adult".tr.replaceAll("-1",
              "${travelInfo[i].typeIndex}");
          validityString = validityString.replaceAll("-2",
              "${travelInfo[i].roomIndex+1}");
        }else{
          if(travelInfo[i].travellerType == "Child"){
            validityString = "enter_gender_hotel_room_child".tr.replaceAll("-1",
                "${travelInfo[i].typeIndex}");
            validityString = validityString.replaceAll("-2",
                "${travelInfo[i].roomIndex+1}");
          }
        }

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



  void changeSelectedRoomSelectionIndex(int i) {
    selectedRoomSelectionIndex.value = i;
  }

  void changeSelectedRoomForIndex(String roomId) {
    List<HotelRoom> hotelRooms =  hotelDetails.value.rooms.where((element) =>
    element.roomid.toString() == roomId
    ).toList();
    if(hotelRooms.isNotEmpty){
      selectedRoom.value[selectedRoomSelectionIndex.value]= hotelRooms[0];
      if(hotelRooms[0].roomOptions.isNotEmpty){
        changeSelectedRoomOptionForIndex(hotelRooms[0].roomOptions[0]);
      }
    }

  }

  void changeSelectedRoomOptionForIndex(HotelRoomOption hotelRoomOption) {
      List<HotelRoomOption> tHotelRoomOptions = [];

      for(var i=0;i<selectedRoomOption.value.length;i++){
        selectedRoom.value.add(hotelDetails.value.rooms[0]) ;
        if(i==selectedRoomSelectionIndex.value){
          tHotelRoomOptions.add(hotelRoomOption);
        }else{
          tHotelRoomOptions.add(selectedRoomOption.value[i]);
        }
      }
      selectedRoomOption.value =  tHotelRoomOptions;

  }
}
