
import 'package:flytern/core-module/constants/service_types.core.constant.dart';
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
  var isAuthTokenSet = false.obs;
  var notifications = <Notification>[].obs;
  var isNotificationsLoading = false.obs;
  var isSmartPaymentCheckLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    setAuthToken();
  }

  Future<void> setAuthToken() async {
    isAuthTokenSet.value = false;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var coreHttpServices = CoreHttpServices();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');
    final String? selectedLanguage = prefs.getString('selectedLanguage');
    final String? selectedCountry = prefs.getString('selectedCountry');

    if (accessToken != null &&
        accessToken != '' &&
        refreshToken != null &&
        refreshToken != '' &&
        expiryOnString != null &&
        expiryOnString != '' &&
        !isGuest!) {
      DateTime expiryOn = DateTime.parse(expiryOnString);

      if (DateTime.now().isAfter(expiryOn)) {
        AuthToken authToken = await coreHttpServices.getRefreshedToken();
        if (authToken.accessToken != "") {
          saveAuthTokenToSharedPreference(authToken);
        }
      }
      Get.offAllNamed(Approute_landingpage);
    } else {
      AuthToken authToken = await coreHttpServices.getGuestToken();

      if (authToken.accessToken != "") {
        saveAuthTokenToSharedPreference(authToken);
      }
  print("selectedLanguage & selectedCountry");
  print(selectedLanguage);
  print(selectedCountry);
      if (selectedLanguage != null &&
          selectedLanguage != '' &&
          selectedCountry != null &&
          selectedCountry != '' ){
        Get.offAllNamed(Approute_landingpage);
      }
      isAuthTokenSet.value = true;
    }

    final sharedController = Get.find<SharedController>();
    sharedController.getInitialInfo();
    sharedController.getPreRegisterInfo();
  }

  getNotifications() async {
    isNotificationsLoading.value = true;
    var coreHttpServices = CoreHttpServices();
    notifications.value = await coreHttpServices.getNotifications();
    isNotificationsLoading.value = false;
  }

  Future<void> handleLogout() async {
    AuthToken authToken = AuthToken(
        accessToken: "",
        refreshToken: "",
        expiryOn: DateTime.now(),
        isGuest: true);
    saveAuthTokenToSharedPreference(authToken);
    setAuthToken();
    Get.offAllNamed(Approute_langaugeSelector);
  }

  checkSmartPayment(String tempBookingRef) async {
    isSmartPaymentCheckLoading.value = true;
    var coreHttpServices = CoreHttpServices();

    ServiceBookingStatus serviceBookingStatus =
    await coreHttpServices.checkSmartPayment(tempBookingRef);

    if (serviceBookingStatus.isSuccess) {

       if(serviceBookingStatus.servicetype == ServiceType.FLIGHT.name){
         final flightBookingController = Get.find<FlightBookingController>();
         flightBookingController.getPaymentGateways(true,tempBookingRef);
       }else if(serviceBookingStatus.servicetype == ServiceType.HOTEL.name){
         final hotelBookingController = Get.find<HotelBookingController>();
         hotelBookingController.getPaymentGateways(true,tempBookingRef);
       }else if(serviceBookingStatus.servicetype == ServiceType.ACTIVITY.name){
         final activityBookingController = Get.find<ActivityBookingController>();
         activityBookingController.getPaymentGateways(true,tempBookingRef);
       }else if(serviceBookingStatus.servicetype == ServiceType.INSURANCE.name){
         final insuranceBookingController = Get.find<InsuranceBookingController>();
         insuranceBookingController.getPaymentGateways(true,tempBookingRef);
       }

       await Future.delayed(const Duration(seconds: 2));
      isSmartPaymentCheckLoading.value = false;
    } else {
      isSmartPaymentCheckLoading.value = false;
      showSnackbar(Get.context!, "couldnt_find_booking".tr, "error");
    }
  }

}
