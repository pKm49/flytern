part of 'flight_booking_controller.dart';

extension FlightBookingControllerAddonsHandler on FlightBookingController {
  // var flightAddonSetSeatData = getDummyFlightAddonSetSeat({}).obs;
  //   var flightAddonSetMealData = getDummyFlightAddonSetMeal({}).obs;
  //   var flightAddonSetExtraPackageData = getDummyFlightAddonSetExtraPackage({}).obs;

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

      for (var i = 0; i < addonRoutes.value.length; i++) {
        for (var ind = 0; ind < addonPassengers.value.length; ind++) {
          listOfSelection.add(FlightAddonSeatSelection(
              routeID: addonRoutes.value[i].routeID,
              rowID: -1,
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

      for (var i = 0; i < addonRoutes.value.length; i++) {
        for (var ind = 0; ind < addonPassengers.value.length; ind++) {
          listOfSelection.add(FlightAddonMealSelection(
              routeID: addonRoutes.value[i].routeID,
              mealId: addonMeals.value[0].mealId,
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

      for (var i = 0; i < addonRoutes.value.length; i++) {
        for (var ind = 0; ind < addonPassengers.value.length; ind++) {
          listOfSelection.add(FlightAddonExtraPackageSelection(
              routeID: addonRoutes.value[i].routeID,
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

}
