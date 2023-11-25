part of 'flight_booking.controller.dart';

extension FlightBookingControllerAddonsHandler on FlightBookingController {

  Future<void> getSeats() async {
    if (addonFlightClass.isEmpty) {
      isGetSeatsLoading.value = true;
      Get.toNamed(Approute_flightsSeatSelection);

      FlightAddonGetSeat flightAddonGetSeat =
      await flightBookingHttpService.getSeats(bookingRef.value);

      addonRoutes.value = flightAddonGetSeat.routes;
      addonPassengers.value = flightAddonGetSeat.passengers;
      addonFlightClass.value = flightAddonGetSeat.flightClass;

      if (addonRoutes.isEmpty) {
        Get.back();
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      } else {
        setInitialSeatData();
      }
      isGetSeatsLoading.value = false;
    } else {
      Get.toNamed(Approute_flightsSeatSelection);
    }
  }

  Future<void> setSeats() async {

    isSeatsSaveLoading.value = true;

     bool isSuccess =
      await flightBookingHttpService.setSeats( flightAddonSetSeatData.value);

      if (!isSuccess) {
        isSeatsSaved.value = false;
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      } else {
        isSeatsSaved.value = true;
        Get.back();
        showSnackbar(Get.context!, "seat_selection_saved".tr, "info");

      }
    isSeatsSaveLoading.value = false;

  }

  Future<void> getMeals() async {
    if (addonMeals.isEmpty) {
      isGetMealsLoading.value = true;
      Get.toNamed(Approute_flightsMealSelection);

      FlightAddonGetMeal flightAddonGetMeal =
      await flightBookingHttpService.getMeals(bookingRef.value);

      addonRoutes.value = flightAddonGetMeal.routes;
      addonPassengers.value = flightAddonGetMeal.passengers;
      addonMeals.value = flightAddonGetMeal.meals;

      if (addonRoutes.isEmpty) {
        Get.back();
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      } else {
        setInitialMealData();
      }
      isGetMealsLoading.value = false;
    } else {
      Get.toNamed(Approute_flightsMealSelection);
    }
  }

  Future<void> setMeals() async {

    isMealsSaveLoading.value = true;

    bool isSuccess =
    await flightBookingHttpService.setMeals( flightAddonSetMealData.value);

    if (!isSuccess) {
      isMealsSaved.value = false;

      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    } else {
      isMealsSaved.value = true;
      Get.back();
      showSnackbar(Get.context!, "meal_selection_saved".tr, "info");
    }
    isMealsSaveLoading.value = false;

  }

  Future<void> getExtraPackages() async {
    if (addonExtraPackages.isEmpty) {
      isGetExtraLuggagesLoading.value = true;
      Get.toNamed(Approute_flightsBaggageSelection);

      FlightAddonGetExtraPackage flightAddonGetExtraPackage =
      await flightBookingHttpService.getExtraPackage(bookingRef.value);

      addonRoutes.value = flightAddonGetExtraPackage.routes;
      addonPassengers.value = flightAddonGetExtraPackage.passengers;
      addonExtraPackages.value = flightAddonGetExtraPackage.extraPackages;

      if (addonRoutes.isEmpty) {
        Get.back();
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
      } else {
        setInitialExtraPackageData();
      }
      isGetExtraLuggagesLoading.value = false;
    } else {
      Get.toNamed(Approute_flightsBaggageSelection);
    }
  }

  Future<void> setExtraPackages() async {

    isExtraLuggagesSaveLoading.value = true;

    bool isSuccess =
    await flightBookingHttpService.setExtraBuggage( flightAddonSetExtraPackageData.value);

    if (!isSuccess) {
      isExtraLuggagesSaved.value = false;

      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    } else {
      isExtraLuggagesSaved.value = true;
      Get.back();
      showSnackbar(Get.context!, "buggage_selection_saved".tr, "info");
    }
    isExtraLuggagesSaveLoading.value = false;

  }

  void changeSelectedRouteForSeat(String value) {
    selectedRouteForSeat.value = value;
  }

  void changeSelectedPassengerForSeat(String value) {
    selectedPassengerForSeat.value = value;
  }

  void changeSelectedRouteForMeal(String value) {
    selectedRouteForMeal.value = value;
  }

  void changeSelectedPassengerForMeal(String value) {
    selectedPassengerForMeal.value = value;
  }

  void changeSelectedRouteForExtraPackage(String value) {
    selectedRouteForExtraPackage.value = value;
  }

  void changeSelectedPassengerForExtraPackage(String value) {
    selectedPassengerForExtraPackage.value = value;
  }

  void setInitialSeatData() {
    List<FlightAddonSeatSelection> listOfSelection = [];

    if (addonRoutes.value.isNotEmpty &&
        addonPassengers.value.isNotEmpty &&
        addonFlightClass.value.isNotEmpty) {
      changeSelectedRouteForSeat(addonRoutes.value[0].routeID);
      changeSelectedPassengerForSeat(addonPassengers.value[0].passengerID);
      seatTotalAmount.value = 0.0;
      for (var i = 0; i < addonRoutes.value.length; i++) {
        for (var ind = 0; ind < addonPassengers.value.length; ind++) {
          listOfSelection.add(FlightAddonSeatSelection(
              routeID: addonRoutes.value[i].routeID,
              rowID: -1,
              amount: 0.0,
              currency: addonFlightClass.value[0].seats[0].columns[0].currency,
              passengerID: addonPassengers.value[ind].passengerID,
              seatId: "-1"));
        }
      }
    }
    flightAddonSetSeatData.value = FlightAddonSetSeat(
        bookingRef: bookingRef.value, listOfSelection: listOfSelection);
  }

  void setInitialMealData() {
    List<FlightAddonMealSelection> listOfSelection = [];

    if (addonRoutes.value.isNotEmpty &&
        addonPassengers.value.isNotEmpty &&
        addonMeals.value.isNotEmpty) {
      changeSelectedRouteForMeal(addonRoutes.value[0].routeID);
      changeSelectedPassengerForMeal(addonPassengers.value[0].passengerID);
      mealTotalAmount.value = 0.0;
      for (var i = 0; i < addonRoutes.value.length; i++) {
        for (var ind = 0; ind < addonPassengers.value.length; ind++) {
          listOfSelection.add(FlightAddonMealSelection(
              routeID: addonRoutes.value[i].routeID,
              mealId: addonMeals.value[0].mealId,
              amount: addonMeals.value[0].price,
              currency: addonMeals.value[0].unit,
              passengerID: addonPassengers.value[ind].passengerID));
        }
      }
    }
    flightAddonSetMealData.value = FlightAddonSetMeal(
        bookingRef: bookingRef.value, listOfSelection: listOfSelection);
  }

  void setInitialExtraPackageData() {
    List<FlightAddonExtraPackageSelection> listOfSelection = [];

    if (addonRoutes.value.isNotEmpty &&
        addonPassengers.value.isNotEmpty &&
        addonExtraPackages.value.isNotEmpty) {
      changeSelectedRouteForExtraPackage(addonRoutes.value[0].routeID);
      changeSelectedPassengerForExtraPackage(
          addonPassengers.value[0].passengerID);
      baggageTotalAmount.value = 0.0;
      for (var i = 0; i < addonRoutes.value.length; i++) {
        for (var ind = 0; ind < addonPassengers.value.length; ind++) {
          listOfSelection.add(FlightAddonExtraPackageSelection(
              routeID: addonRoutes.value[i].routeID,
              amount: 0.0,
              currency: addonExtraPackages.value[0].name.split(" ").length>1? addonExtraPackages.value[0].name.split(" ")[0]:"KWD",
              extraLuaggageId: addonExtraPackages.value[0].extraLuaggeId,
              passengerID: addonPassengers.value[ind].passengerID));
        }
      }
    }
    flightAddonSetExtraPackageData.value = FlightAddonSetExtraPackage(
        bookingRef: bookingRef.value, listOfSelection: listOfSelection);
  }

  void selectSeat(FlightAddonSeatColumn seat, int rowId) {

    if(seat.seatId !="-1"){
      List<FlightAddonSeatSelection> listOfSelection = [];
      for(var i=0;i<flightAddonSetSeatData
          .value.listOfSelection.length;i++){
        if((flightAddonSetSeatData
            .value.listOfSelection[i].routeID ==
            selectedRouteForSeat.value &&
            flightAddonSetSeatData
                .value.listOfSelection[i].passengerID ==
                selectedPassengerForSeat.value)){
          print("cond 1");
          print(seat.position);
          print(seat.seatId);
          print(rowId);
          listOfSelection.add(  FlightAddonSeatSelection(
              routeID: flightAddonSetSeatData
                  .value.listOfSelection[i].routeID,
              rowID: rowId,
              amount: seat.amount,
              currency: seat.currency,
              passengerID: flightAddonSetSeatData
                  .value.listOfSelection[i].passengerID,
              seatId: seat.seatId)
          );
        }else{
          print("cond 2");
          listOfSelection.add(flightAddonSetSeatData
              .value.listOfSelection[i]);
        }
      }
      flightAddonSetSeatData.value = FlightAddonSetSeat(
          bookingRef: bookingRef.value, listOfSelection: listOfSelection);
    }

  }

  void selectMeal(FlightAddonMeal meal) {

    if(meal.mealId != "-1"){
      List<FlightAddonMealSelection> listOfSelection = [];
      for(var i=0;i<flightAddonSetMealData
          .value.listOfSelection.length;i++){
        if((flightAddonSetMealData
            .value.listOfSelection[i].routeID ==
            selectedRouteForMeal.value &&
            flightAddonSetMealData
                .value.listOfSelection[i].passengerID ==
                selectedPassengerForMeal.value)){

          listOfSelection.add(  FlightAddonMealSelection(
              routeID: flightAddonSetMealData
                  .value.listOfSelection[i].routeID,
              mealId:meal.mealId.toString(),
              amount: meal.price,
              currency: meal.unit,
              passengerID: flightAddonSetMealData
                  .value.listOfSelection[i].passengerID )
          );
        }else{
          print("cond 2");
          listOfSelection.add(flightAddonSetMealData
              .value.listOfSelection[i]);
        }
      }
      flightAddonSetMealData.value = FlightAddonSetMeal(
          bookingRef: bookingRef.value, listOfSelection: listOfSelection);
    }

  }

  void selectExtraPackage(FlightAddonExtraPackage extraPackage) {

    if(extraPackage.extraLuaggeId != "-1"){
      List<FlightAddonExtraPackageSelection> listOfSelection = [];
      for(var i=0;i<flightAddonSetExtraPackageData
          .value.listOfSelection.length;i++){
        if((flightAddonSetExtraPackageData
            .value.listOfSelection[i].routeID ==
            selectedRouteForExtraPackage.value &&
            flightAddonSetExtraPackageData
                .value.listOfSelection[i].passengerID ==
                selectedPassengerForExtraPackage.value)){

          listOfSelection.add(  FlightAddonExtraPackageSelection(
              routeID: flightAddonSetExtraPackageData
                  .value.listOfSelection[i].routeID,
              amount:extraPackage.name.split(" ").length>1? double.parse(extraPackage.name.split(" ")[1]):0.0,
              currency:extraPackage.name.split(" ").length>1? extraPackage.name.split(" ")[0]:"KWD",
              extraLuaggageId: extraPackage.extraLuaggeId.toString(),
              passengerID: flightAddonSetExtraPackageData
                  .value.listOfSelection[i].passengerID )
          );

        }else{
          print("cond 2");
          listOfSelection.add(flightAddonSetExtraPackageData
              .value.listOfSelection[i]);
        }
      }
      flightAddonSetExtraPackageData.value = FlightAddonSetExtraPackage(
          bookingRef: bookingRef.value, listOfSelection: listOfSelection);
    }

  }

}
