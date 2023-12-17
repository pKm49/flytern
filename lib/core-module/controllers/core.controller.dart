import 'package:flytern/shared-module/constants/service_types.core.constant.dart';
import 'package:flytern/core-module/models/notification.core.model.dart';
import 'package:flytern/core-module/models/service_booking_status.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/core-module/services/http.core.service.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/services/utility-services/local_storage_handler.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreController extends GetxController {
  var notifications = <Notification>[].obs;
  var isNotificationsLoading = false.obs;
  var isSmartPaymentCheckLoading = false.obs;
  var isBookingFinderLoading = false.obs;
  var isEnquiryLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  getNotifications() async {
    isNotificationsLoading.value = true;
    var coreHttpServices = CoreHttpServices();
    notifications.value = await coreHttpServices.getNotifications();
    isNotificationsLoading.value = false;
  }

  checkSmartPayment(String tempBookingRef) async {
    isSmartPaymentCheckLoading.value = true;
    var coreHttpServices = CoreHttpServices();

    ServiceBookingStatus serviceBookingStatus =
        await coreHttpServices.checkSmartPayment(tempBookingRef);

    if (serviceBookingStatus.isSuccess) {
      if (serviceBookingStatus.servicetype == ServiceType.FLIGHT.name) {
        final flightBookingController = Get.find<FlightBookingController>();
        flightBookingController.getPaymentGateways(true, tempBookingRef);
      } else if (serviceBookingStatus.servicetype == ServiceType.HOTEL.name) {
        final hotelBookingController = Get.find<HotelBookingController>();
        hotelBookingController.getPaymentGateways(true, tempBookingRef);
      } else if (serviceBookingStatus.servicetype ==
          ServiceType.ACTIVITY.name) {
        final activityBookingController = Get.find<ActivityBookingController>();
        activityBookingController.getPaymentGateways(true, tempBookingRef);
      } else if (serviceBookingStatus.servicetype ==
          ServiceType.INSURANCE.name) {
        final insuranceBookingController =
            Get.find<InsuranceBookingController>();
        insuranceBookingController.getPaymentGateways(true, tempBookingRef);
      }

      await Future.delayed(const Duration(seconds: 2));
      isSmartPaymentCheckLoading.value = false;
    } else {
      isSmartPaymentCheckLoading.value = false;
      showSnackbar(Get.context!, "couldnt_find_booking".tr, "error");
    }
  }

  submitEnquiry(String mobile,String countryCode,String email, String bookingId, String enquiry) async {
    isEnquiryLoading.value = true;
    var coreHttpServices = CoreHttpServices();
    String successMessage =
        await coreHttpServices.submitEnquiry(mobile, countryCode,email,bookingId,enquiry);

    if(successMessage =="something_went_wrong".tr){
      showSnackbar(Get.context!, successMessage, "error");
    }else{
      showSnackbar(Get.context!, successMessage, "info");
    }

    isEnquiryLoading.value = false;
    Get.back();
  }

  findBooking(String tempBookingRef, String email) async {
    isBookingFinderLoading.value = true;
    var coreHttpServices = CoreHttpServices();

    ServiceBookingStatus serviceBookingStatus =
        await coreHttpServices.findBooking(tempBookingRef, email);

    if (serviceBookingStatus.isSuccess) {
      if (serviceBookingStatus.servicetype == ServiceType.FLIGHT.name) {
        final flightBookingController = Get.find<FlightBookingController>();
        flightBookingController.getConfirmationData(tempBookingRef, true);
      } else if (serviceBookingStatus.servicetype == ServiceType.HOTEL.name) {
        final hotelBookingController = Get.find<HotelBookingController>();
        hotelBookingController.getConfirmationData(tempBookingRef, true);
      } else if (serviceBookingStatus.servicetype ==
          ServiceType.ACTIVITY.name) {
        final activityBookingController = Get.find<ActivityBookingController>();
        activityBookingController.getConfirmationData(tempBookingRef, true);
      } else if (serviceBookingStatus.servicetype ==
          ServiceType.INSURANCE.name) {
        final insuranceBookingController =
            Get.find<InsuranceBookingController>();
        insuranceBookingController.getConfirmationData(tempBookingRef, true);
      }

      await Future.delayed(const Duration(seconds: 2));
      isBookingFinderLoading.value = false;
    } else {
      isBookingFinderLoading.value = false;
      showSnackbar(Get.context!, "couldnt_find_booking".tr, "error");
    }
  }
}
