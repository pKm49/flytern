import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/constants/flight_mode.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/cabin_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/allowed_cabin.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_item.flight_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:get/get.dart';

class FlightBookingHelperServices {
  double getFlightBookingContainerHeight(
      double screenheight, FlightBookingController flightBookingController) {
    return (screenheight * .7) +
        (flyternSpaceLarge * 2) +
        ((flightBookingController.flightSearchData.value.searchList.length -
                1) *
            230) +
        (flightBookingController.flightSearchData.value.mode ==
                FlightMode.MULTICITY
            ? 75
            : 10);
  }

  double getFlightBookingFormItemHeight(int length) {
    double extraSpace = (length - 1) * 30;
    return (length * 200) + extraSpace;
  }

bool isDestinationChangable(FlightSearchData flightSearchData,
      FlightDestination flightDestination, bool isArrival, int index) {

    bool isChangable = false;

    for (var i = 0; i < flightSearchData.searchList.length; i++) {
      if (index == i) {
        if(isArrival){
          isChangable =  flightDestination.airportCode != flightSearchData.searchList[i].departure.airportCode;
        }else{
          isChangable = flightDestination.airportCode != flightSearchData.searchList[i].arrival.airportCode;
        }
      }
    }

    return isChangable;
  }


  List<FlightSearchItem> getUpdatedSearchList(FlightSearchData flightSearchData,
      FlightDestination flightDestination, bool isArrival, int index) {
    List<FlightSearchItem> flightSearchItems = [];

    for (var i = 0; i < flightSearchData.searchList.length; i++) {
      if (index != i) {
        flightSearchItems.add(flightSearchData.searchList[i]);
      } else {
        FlightSearchItem flightSearchItem = FlightSearchItem(
            departure: !isArrival
                ? flightDestination
                : flightSearchData.searchList[i].departure,
            arrival: isArrival
                ? flightDestination
                : flightSearchData.searchList[i].arrival,
            departureDate: flightSearchData.searchList[i].departureDate,
            returnDate: flightSearchData.searchList[i].returnDate);
        flightSearchItems.add(flightSearchItem);
      }
    }
    return flightSearchItems;
  }

  FlightSearchData setFlightMode(
      FlightSearchData flightSearchData, FlightMode newMode) {

    List<FlightSearchItem> flightSearchItems = [];

    FlightSearchItem flightSearchItem = FlightSearchItem(
        departure: flightSearchData
            .searchList[0].departure,
        arrival: flightSearchData
            .searchList[0].arrival,
        departureDate: flightSearchData
            .searchList[0].departureDate,
        returnDate: newMode == FlightMode.ROUNDTRIP?flightSearchData.searchList[0].departureDate:null);
    flightSearchItems.add(flightSearchItem);

    return FlightSearchData(

        promoCode: flightSearchData.promoCode,
        adults: flightSearchData.adults,
        child: flightSearchData.child,
        infants: flightSearchData.infants,
        searchList: flightSearchItems,
        allowedCabins: flightSearchData.allowedCabins,
        mode: newMode,
        isDirectFlight: flightSearchData.isDirectFlight);
  }

  FlightSearchData addFlightSearchItem(FlightSearchData flightSearchData) {
    List<FlightSearchItem> flightSearchItems = flightSearchData.searchList;

    FlightSearchItem flightSearchItem = FlightSearchItem(
        departure: flightSearchData
            .searchList[flightSearchData.searchList.length - 1].arrival,
        arrival: flightSearchData
            .searchList[flightSearchData.searchList.length - 1].departure,
        departureDate: flightSearchData
            .searchList[flightSearchData.searchList.length - 1].departureDate,
        returnDate:  flightSearchData
            .searchList[flightSearchData.searchList.length - 1].departureDate,);
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

  FlightSearchData removeFlightSearchItem(
      FlightSearchData flightSearchData, int index) {
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

  FlightSearchData reverseTrip(FlightSearchData flightSearchData, int index) {
    List<FlightSearchItem> flightSearchItems = [];

    for (var i = 0; i < flightSearchData.searchList.length; i++) {
      if (index != i) {
        flightSearchItems.add(flightSearchData.searchList[i]);
      } else {
        FlightSearchItem flightSearchItem = FlightSearchItem(
            departure: flightSearchData.searchList[i].arrival,
            arrival: flightSearchData.searchList[i].departure,
            departureDate: flightSearchData.searchList[i].departureDate,
            returnDate: flightSearchData.searchList[i].returnDate);
        flightSearchItems.add(flightSearchItem);
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

  FlightSearchData changeDate(FlightSearchData flightSearchData, int index,
      DateTime dateTime, bool isReturnDate) {
    List<FlightSearchItem> flightSearchItems = [];

    for (var i = 0; i < flightSearchData.searchList.length; i++) {
      if (index != i) {
        flightSearchItems.add(flightSearchData.searchList[i]);
      } else {
        FlightSearchItem flightSearchItem = FlightSearchItem(
            departure: flightSearchData.searchList[i].departure,
            arrival: flightSearchData.searchList[i].arrival,
            departureDate: isReturnDate
                ? flightSearchData.searchList[i].departureDate
                : dateTime,
            returnDate: !isReturnDate
                ? flightSearchData.searchList[i].returnDate
                : dateTime);
        flightSearchItems.add(flightSearchItem);
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

  String getPassengerCabinData(
      FlightBookingController flightBookingController) {

    String returnString = "";
    int numberOfPassengers =
        flightBookingController.flightSearchData.value.adults +
            flightBookingController.flightSearchData.value.infants +
            flightBookingController.flightSearchData.value.child;
    if (numberOfPassengers > 0) {
      if(numberOfPassengers == 1) {
        returnString = "${'single_passenger'.tr}";
      }else {
        returnString = "$numberOfPassengers ${'passengers'.tr}";
      }
        if(flightBookingController.flightSearchData.value.allowedCabins.isNotEmpty){
         returnString +=" - ";
         for(var i =0; i<flightBookingController.flightSearchData.value.allowedCabins.length;i++){
           returnString += flightBookingController.flightSearchData.value.allowedCabins[i].name;
           if(i!=flightBookingController.flightSearchData.value.allowedCabins.length-1){
             returnString +=", ";
           }
         }
       }
       return returnString;
    } else {
      return "select_passenger_cabin".tr;
    }
  }

  FlightSearchData updatePassengerCountAndCabinClass(
      FlightSearchData flightSearchData,
      int adultCount,
      int childCount,
      int infantCount,
      List<CabinClass> cabinClasses) {

    List<FlightAllowedCabin> allowedCabins = [];
    for (var i = 0; i < cabinClasses.length; i++) {
      allowedCabins.add(FlightAllowedCabin(
          name: cabinClasses[i].name,
          value: cabinClasses[i].value,
          isDefault: i == 0 ? true : false));
    }

    return FlightSearchData(
        promoCode: flightSearchData.promoCode,
        adults: adultCount,
        child: childCount,
        infants: infantCount,
        searchList: flightSearchData.searchList,
        allowedCabins: allowedCabins,
        mode: flightSearchData.mode,
        isDirectFlight: flightSearchData.isDirectFlight);
  }

  FlightSearchData updatePromoCode(FlightSearchData flightSearchData, String promoCode) {
    return FlightSearchData(
        promoCode: promoCode,
        adults: flightSearchData.adults,
        child: flightSearchData.child,
        infants: flightSearchData.infants,
        searchList: flightSearchData.searchList,
        allowedCabins: flightSearchData.allowedCabins,
        mode: flightSearchData.mode,
        isDirectFlight: flightSearchData.isDirectFlight);
  }

  FlightSearchData updateDirectFlight(FlightSearchData flightSearchData, bool isDirectFlight) {
    return FlightSearchData(
        promoCode: flightSearchData.promoCode,
        adults: flightSearchData.adults,
        child: flightSearchData.child,
        infants: flightSearchData.infants,
        searchList: flightSearchData.searchList,
        allowedCabins: flightSearchData.allowedCabins,
        mode: flightSearchData.mode,
        isDirectFlight: isDirectFlight);
  }
}
