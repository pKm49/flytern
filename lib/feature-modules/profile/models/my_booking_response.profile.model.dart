import 'package:flytern/feature-modules/profile/models/my_activity.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_flight_booking.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_hotel_booking.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_insurance.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_package.profile.model.dart';

class MyBookingResponse {
  final List<MyFlightBooking> myFlightBookingResponse;
  final List<MyHotelBooking> myHotelBookingResponse;
  final List<MyInsuranceBooking> myInsuranceBookingResponse;
  final List<MyPackageBooking> myPackageBookingResponse;
  final List<MyActivityBooking> myActivityBookingResponse;
  final String title;
  final int totalPages;
  final int currentPage;
  final int pageSize;

  MyBookingResponse(
      {required this.myFlightBookingResponse,
      required this.myHotelBookingResponse,
      required this.myInsuranceBookingResponse,
      required this.myPackageBookingResponse,
      required this.myActivityBookingResponse,
      required this.title,
      required this.totalPages,
      required this.currentPage,
      required this.pageSize});
}

MyBookingResponse mapMyBookingResponse(dynamic payload) {
  List<MyFlightBooking> myFlightBookingResponse = [];
  List<MyHotelBooking> myHotelBookingResponse = [];
  List<MyInsuranceBooking> myInsuranceBookingResponse = [];
  List<MyPackageBooking> myPackageBookingResponse = [];
  List<MyActivityBooking> myActivityBookingResponse = [];

  if (payload["_MyActivityBookingResponse"] != null) {
    payload["_MyActivityBookingResponse"].forEach((element) {
      myActivityBookingResponse.add(mapMyActivityBooking(element));
    });
  }

  if (payload["_MyFlightBookingResponse"] != null) {
    payload["_MyFlightBookingResponse"].forEach((element) {
      myFlightBookingResponse.add(mapMyFlightBooking(element));
    });
  }

  if (payload["_MyHotelBookingResponse"] != null) {
    payload["_MyHotelBookingResponse"].forEach((element) {
      myHotelBookingResponse.add(mapMyHotelBooking(element));
    });
  }
  if (payload["_MyInsuranceBookingResponse"] != null) {
    payload["_MyInsuranceBookingResponse"].forEach((element) {
      myInsuranceBookingResponse.add(mapMyInsuranceBooking(element));
    });
  }

  if (payload["_MyPackageBookingResponse"] != null) {
    payload["_MyPackageBookingResponse"].forEach((element) {
      myPackageBookingResponse.add(mapMyPackageBooking(element));
    });
  }

  return MyBookingResponse(
    title: payload["title"] ?? "",
    totalPages: payload["totalPages"] ?? 0,
    currentPage: payload["currentPage"] ?? 0,
    pageSize: payload["pageSize"] ?? 0,
    myFlightBookingResponse: myFlightBookingResponse,
    myHotelBookingResponse: myHotelBookingResponse,
    myInsuranceBookingResponse: myInsuranceBookingResponse,
    myPackageBookingResponse: myPackageBookingResponse,
    myActivityBookingResponse: myActivityBookingResponse,
  );
}
