part of 'hotel_booking.controller.dart';

extension HotelBookingControllerGetter on HotelBookingController {

  bool isItemSelected(
      List<HotelRoomOption> hotelRoomOptions, HotelRoomOption hotelRoomOption) {
    return hotelRoomOptions
        .where(
            (element) => element.roomOptionid == hotelRoomOption.roomOptionid)
        .toList()
        .isNotEmpty;
  }

  List<HotelRoomOption> getRoomOptions() {
    if (selectedRoom.isEmpty) {
      return [];
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return [];
    }
    if ( selectedRoom
        .value[selectedRoomSelectionIndex.value]
        .roomOptions
        .isEmpty) {
      return [];
    }
    return  selectedRoom
        .value[selectedRoomSelectionIndex.value]
        .roomOptions;
  }

  num getRoomOptionsLength() {
    if (selectedRoom.isEmpty) {
      return 0;
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return 0;
    }
    if ( selectedRoom
        .value[selectedRoomSelectionIndex.value]
        .roomOptions
        .isEmpty) {
      return 0;
    }
    return  selectedRoom
        .value[selectedRoomSelectionIndex.value]
        .roomOptions
        .length;
  }

  getCurrency() {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .currency;
  }

  getPricePerNight() {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .perNightPrice;
  }
  getGrandTotal() {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .totalPrice;
  }

  getTotalPrice() {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .totalBase;
  }

  getTaxPrice() {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .totalTax;
  }

  String getRoomImage(int i) {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .imageURLs[i];
  }

  List<String> getRoomImages( ) {
    if (selectedRoom.isEmpty) {
      return [];
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return [];
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .imageURLs;
  }


  num getRoomImagesLength() {
    if (selectedRoom.isEmpty) {
      return 0;
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return 0;
    }
    return  selectedRoomOption
        .value[selectedRoomSelectionIndex.value]
        .imageURLs.length;
  }

  HotelRoomOption? getSelectedRoomOption() {
    if (selectedRoom.isEmpty) {
      return null;
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return null;
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value];
  }

  getShortDescriptionsLength() {
    if (selectedRoom.isEmpty) {
      return 0;
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return 0;
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .shortdesc.length;
  }

  getShortDescriptions(int i) {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .shortdesc[i];
  }

  getRoomsLength() {
    if (selectedRoom.isEmpty) {
      return 0;
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return 0;
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .roomsList.length;
  }

  String getRoom(int i) {
    if (selectedRoom.isEmpty) {
      return "";
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return "";
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .roomsList[i];
  }

  getCancellationPolicyLength() {
    if (selectedRoom.isEmpty) {
      return 0;
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return 0;
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .cancelPolicies.length;
  }



  HotelRoomOptionCancelPolicy getCancellationPolicy(int i) {
    if (selectedRoom.isEmpty) {
      return mapHotelRoomOptionCancelPolicy({});
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return mapHotelRoomOptionCancelPolicy({});
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .cancelPolicies[i];
  }

  getSupplementsLength() {
    if (selectedRoom.isEmpty) {
      return 0;
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return 0;
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .supplements.length;
  }

 HotelRoomOptionSupplement getSupplements(int i) {
    if (selectedRoom.isEmpty) {
      return mapHotelRoomOptionSupplement({});
    }
    if (selectedRoomSelectionIndex.value < 0) {
      return mapHotelRoomOptionSupplement({});
    }
    return  selectedRoomOption[ selectedRoomSelectionIndex
        .value]
        .supplements[i];
  }
}
