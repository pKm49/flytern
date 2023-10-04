
import 'package:flytern/core/ui/pages/landing_page.dart';
import 'package:flytern/core/ui/pages/language_selector.dart';
import 'package:flytern/feature-modules/auth/ui/pages/auth_selector.dart';
import 'package:flytern/feature-modules/auth/ui/pages/login.dart';
import 'package:flytern/feature-modules/auth/ui/pages/register/register_details_input.dart';
import 'package:flytern/feature-modules/auth/ui/pages/register/register_otp_input.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_credentials.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_new_password.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_otp.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_addon_services_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_baggage_selection_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_booking_confirmation_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_booking_summary_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_details_page.dart';
 import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_meal_selection_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_search_results_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_seat_selection_page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/hotel_booking_confirmation_page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/hotel_booking_summary_page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/hotel_details_page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/hotel_search_results_page.dart';
import 'package:flytern/feature-modules/package_booking/ui/pages/package_details_page.dart';
import 'package:flytern/feature-modules/package_booking/ui/pages/package_user_details_submission_page.dart';
import 'package:flytern/shared/ui/pages/userdetails_submission_page.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:get/get.dart';

getAppRoutes() => [
  GetPage(
    name:  Approute_langaugeSelector,
    page: () =>   CoreLanguageSelector(),
    // transition: Transition.rightToLeft,
    // transitionDuration: const Duration(milliseconds: 200),
  ),
  GetPage(
    name: Approute_authSelector,
    page: () => const AuthSelectorPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_registerPersonalData,
    page: () => const AuthRegisterDetailsInputPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_registerOtp,
    page: () => const AuthRegisterOTPInputPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_login,
    page: () => const AuthLoginPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_resetPasswordMobile,
    page: () => const AuthResetPasswordCredentialsPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_resetPasswordOtp,
    page: () => const AuthResetPasswordOTPPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_resetPasswordNewpassword,
    page: () => const AuthResetPasswordNewPasswordPage(),
    middlewares: [MyMiddelware()],
  ),
  GetPage(
    name: Approute_landingpage,
    page: () => const CoreLandingPage(),
    middlewares: [MyMiddelware()],
  ),

  // Common
  GetPage(
    name: Approute_userDetailsSubmission,
    page: () => const UserDetailsSubmissionPage(),
    middlewares: [MyMiddelware()],
  ),


  // flight booking

  GetPage(
    name: Approute_flightsSearchResult,
    page: () => const FlightSearchResultPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_flightsDetails,
    page: () => const FlightDetailsPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_flightsAddonServices,
    page: () => const FlightAddonServicesPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_flightsSeatSelection,
    page: () => const FlightSeatSelectionPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_flightsMealSelection,
    page: () => const FlightMealSelectionPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_flightsBaggageSelection,
    page: () => const FlightBaggageSelectionPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_flightsSummary,
    page: () => const FlightBookingSummaryPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_flightsConfirmation,
    page: () => const FlightBookingConfirmationPage(),
    middlewares: [MyMiddelware()],
  ),

//  Hotel Booking
  GetPage(
    name: Approute_hotelsSearchResult,
    page: () => const HotelSearchResultPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_hotelsDetails,
    page: () => const HotelDetailsPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_hotelsSummary,
    page: () => const HotelBookingSummaryPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_hotelsConfirmation,
    page: () => const HotelBookingConfirmationPage(),
    middlewares: [MyMiddelware()],
  ),

  //  package
  GetPage(
    name: Approute_packagesDetails,
    page: () => const PackageDetailsPage(),
    middlewares: [MyMiddelware()],
  ),

  GetPage(
    name: Approute_packagesUserDetailsSubmission,
    page: () => const PackageUserDetailsSubmissionPage(),
    middlewares: [MyMiddelware()],
  ),

];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}