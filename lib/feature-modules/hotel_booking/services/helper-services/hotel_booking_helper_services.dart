import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking_controller.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_destination.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_data.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_item_room_data.dart';
import 'package:get/get.dart';

class HotelBookingHelperServices {

  HotelSearchData addHotelRoom(HotelSearchData hotelSearchData) {
    List<HotelSearchItemRoomData> hotelRooms = hotelSearchData.rooms;

    HotelSearchItemRoomData hotelRoom =
    HotelSearchItemRoomData(adults: 1, childs: 0, childAges: []);
    hotelRooms.addAll(hotelSearchData.rooms);
    hotelRooms.add(hotelRoom);

    HotelSearchData newHotelSearchData = HotelSearchData(
        destination: hotelSearchData.destination,
        checkInDate: hotelSearchData.checkInDate,
        checkOutDate: hotelSearchData.checkOutDate,
        nationalityCode: hotelSearchData.nationalityCode,
        rooms: hotelRooms);
    return newHotelSearchData;
  }

  HotelSearchData removeHotelRoom(HotelSearchData hotelSearchData, int index) {
    List<HotelSearchItemRoomData> hotelRooms = [];

    for (var i = 0; i < hotelSearchData.rooms.length; i++) {
      if (index != i) {
        hotelRooms.add(hotelSearchData.rooms[i]);
      }
    }
    HotelSearchData newHotelSearchData = HotelSearchData(
        destination: hotelSearchData.destination,
        checkInDate: hotelSearchData.checkInDate,
        checkOutDate: hotelSearchData.checkOutDate,
        nationalityCode: hotelSearchData.nationalityCode,
        rooms: hotelRooms);
    return newHotelSearchData;
  }

  HotelSearchData changeDate(HotelSearchData hotelSearchData,
      DateTime dateTime, bool isCheckoutDate) {
    HotelSearchData newHotelSearchData = HotelSearchData(
        destination: hotelSearchData.destination,
        checkInDate: !isCheckoutDate ? dateTime : hotelSearchData.checkInDate,
        checkOutDate: isCheckoutDate ? dateTime : hotelSearchData.checkOutDate,
        nationalityCode: hotelSearchData.nationalityCode,
        rooms: hotelSearchData.rooms);
    return newHotelSearchData;
  }

  String getPassengerCabinData(HotelSearchData hotelSearchData, int index) {
    String returnString = "";

    if (hotelSearchData.rooms.length >= index + 1) {
      returnString = "${hotelSearchData.rooms[index].adults} ${'adults'.tr}, "
          "${hotelSearchData.rooms[index].childs} ${'children'.tr}";

      return returnString;
    }
    return "select_passenger_cabin".tr;
  }

  HotelSearchData updatePassengerCount(
      HotelSearchData hotelSearchData,
      int index,
      int adultCount,
      int childCount,
      List<int> childAges) {

    if (hotelSearchData.rooms.length >= index + 1) {
      List<HotelSearchItemRoomData> hotelRooms = [];
      for (var i=0;i<hotelSearchData.rooms.length;i++) {

        if(i==index){
          hotelRooms.add(HotelSearchItemRoomData(
              adults: adultCount, childs: childCount, childAges: childAges));
        } else{
          hotelRooms.add(hotelSearchData.rooms[i]);
        }

      }

      return HotelSearchData(
          destination: hotelSearchData.destination,
          checkInDate: hotelSearchData.checkInDate,
          checkOutDate: hotelSearchData.checkOutDate,
          nationalityCode: hotelSearchData.nationalityCode,
          rooms: hotelRooms);

    }
    return hotelSearchData;
  }


}