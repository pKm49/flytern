import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/destination.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_data.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_item_room_data.hotel_booking.model.dart';
import 'package:get/get.dart';

class HotelBookingHelperServices {

  HotelSearchData addHotelRoom(HotelSearchData hotelSearchData) {
    List<HotelSearchItemRoomData> hotelRooms = [];

    HotelSearchItemRoomData hotelRoom =
    HotelSearchItemRoomData(adults: 1, childs: 0, childAges: []);
    hotelRooms.addAll(hotelSearchData.rooms);
    hotelRooms.add(hotelRoom);

    HotelSearchData newHotelSearchData = HotelSearchData(
        cityCode: hotelSearchData.cityCode,
        countryCode: hotelSearchData.countryCode,
        hotelCode: hotelSearchData.hotelCode,
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
        cityCode: hotelSearchData.cityCode,
        countryCode: hotelSearchData.countryCode,
        hotelCode: hotelSearchData.hotelCode,
        checkInDate: hotelSearchData.checkInDate,
        checkOutDate: hotelSearchData.checkOutDate,
        nationalityCode: hotelSearchData.nationalityCode,
        rooms: hotelRooms);
    return newHotelSearchData;
  }

  HotelSearchData changeDate(HotelSearchData hotelSearchData,
      DateTime dateTime, bool isCheckoutDate) {
    HotelSearchData newHotelSearchData = HotelSearchData(
        cityCode: hotelSearchData.cityCode,
        countryCode: hotelSearchData.countryCode,
        hotelCode: hotelSearchData.hotelCode,
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
    return "select_number_of_guests".tr;
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
          cityCode: hotelSearchData.cityCode,
          countryCode: hotelSearchData.countryCode,
          hotelCode: hotelSearchData.hotelCode,
          destination: hotelSearchData.destination,
          checkInDate: hotelSearchData.checkInDate,
          checkOutDate: hotelSearchData.checkOutDate,
          nationalityCode: hotelSearchData.nationalityCode,
          rooms: hotelRooms);

    }
    return hotelSearchData;
  }


}
