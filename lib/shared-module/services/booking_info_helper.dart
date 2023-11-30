
import 'package:flytern/shared-module/models/booking_info.dart';

// Payment Info Helpers

String getPaymentTitle(List<BookingInfo> paymentInfo,String title ) {
  List<BookingInfo> tBookingInfo = paymentInfo.where((element)
  => element.groupName==title).toList();
  if(tBookingInfo.isNotEmpty){
    return tBookingInfo[0].title;
  }else{
    return "";
  }
}

String getPaymentInfo(List<BookingInfo> paymentInfo,String title ) {
  List<BookingInfo> tBookingInfo = paymentInfo.where((element)
  => element.groupName==title).toList();
  if(tBookingInfo.isNotEmpty){
    return tBookingInfo[0].information;
  }else{
    return "";
  }
}

// Booking Info Helpers

num getBookingInfoGroupLength(List<BookingInfo> bookingInfo) {
  return bookingInfo.where((element) => element.groupName=="").toList().length;
}

String getBookingInfoGroupName(List<BookingInfo> bookingInfo,int i) {
  List<BookingInfo> tBookingInfo = bookingInfo.where((element) => element.groupName=="").toList();
  if(i<=tBookingInfo.length-1){
    return tBookingInfo[i].information;
  }else{
    return "";
  }
}

String getBookingInfoTitle(List<BookingInfo> bookingInfo,int groupIndex, int itemIndex) {
  List<BookingInfo> tBookingInfo = bookingInfo.where((element) => element.groupName=="").toList();
  if(groupIndex<=tBookingInfo.length-1){
    List<BookingInfo> teBookingInfo = bookingInfo.where((element) => element.groupName==tBookingInfo[groupIndex].information).toList();
    if(itemIndex<=teBookingInfo.length-1){
      return teBookingInfo[itemIndex].title;
    }else{
      return "";
    }
  }else{
    return "";
  }
}

String getBookingInfoValue(List<BookingInfo> bookingInfo,int groupIndex, int itemIndex) {
  List<BookingInfo> tBookingInfo = bookingInfo.where((element) => element.groupName=="").toList();
  if(groupIndex<=tBookingInfo.length-1){
    List<BookingInfo> teBookingInfo = bookingInfo.where((element) => element.groupName==tBookingInfo[groupIndex].information).toList();
    if(itemIndex<=teBookingInfo.length-1){
      return teBookingInfo[itemIndex].information;
    }else{
      return "";
    }
  }else{
    return "";
  }
}

num getBookingInfoGroupSize(List<BookingInfo> bookingInfo,int i) {
  List<BookingInfo> tBookingInfo = bookingInfo.where((element) => element.groupName=="").toList();
  if(tBookingInfo.isNotEmpty){

    List<BookingInfo> teBookingInfo = bookingInfo.where((element) => element.groupName==tBookingInfo[i].information).toList();
    return teBookingInfo.length;
  }else{
    return 0;
  }
}
