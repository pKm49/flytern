import 'package:flytern/core/ui/pages/drawer_pages/document_page.dart';
import 'package:flytern/core/ui/pages/drawer_pages/info_page.dart';
import 'package:flytern/core/ui/pages/landing_page.dart';
import 'package:flytern/core/ui/pages/language_selector.dart';
import 'package:flytern/core/ui/pages/drawer_pages/settings_page.dart';
import 'package:flytern/core/ui/pages/drawer_pages/smart_payment_page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/activity_booking_confirmation_page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/activity_booking_summary_page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/activity_details_page.dart';
import 'package:flytern/feature-modules/auth/ui/pages/auth_selector.dart';
import 'package:flytern/feature-modules/auth/ui/pages/login.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_more_options_page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/flight_userdetails_submission_page.dart';
import 'package:flytern/feature-modules/package_booking/ui/pages/package_booking_confirmation_page.dart';
import 'package:flytern/shared/ui/pages/otp_input.dart';
import 'package:flytern/feature-modules/auth/ui/pages/register/register_details_input.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_credentials.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_new_password.dart';
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
import 'package:flytern/feature-modules/insurance/ui/pages/insurance_booking_confirmation_page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/insurance_booking_summary_page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/insurance_landing_page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/insurance_user_details_submission_page.dart';
import 'package:flytern/feature-modules/package_booking/ui/pages/package_details_page.dart';
import 'package:flytern/feature-modules/package_booking/ui/pages/package_user_details_submission_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_audit_copassenger_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/profile_edit_email_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/profile_edit_mobile_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/profile_edit_profile_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_my_bookings_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_my_copassengers_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_my_travel_stories_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_new_travel_story_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/profile_reset_password_page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_view_profile_page.dart';
import 'package:flytern/shared/ui/pages/userdetails_submission_page.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:get/get.dart';

getAppRoutes() => [
      GetPage(
        name: Approute_langaugeSelector,
        page: () => CoreLanguageSelector(),
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
        page: () => const OTPInputPage(),
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
        page: () => const OTPInputPage(),
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
        name: Approute_flightsMoreOptions,
        page: () => const FlightMoreOptionsPage(),
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

      // Common
      GetPage(
        name: Approute_flightsUserSelection,
        page: () => const FlightUserDetailsSubmissionPage(),
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
        name: Approute_packagesConfirmation,
        page: () => const PackageBookingConfirmationPage(),
        middlewares: [MyMiddelware()],
      ),

//  activities Booking

      GetPage(
        name: Approute_activitiesDetails,
        page: () => const ActivityDetailsPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_activitiesSummary,
        page: () => const ActivityBookingSummaryPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_activitiesConfirmation,
        page: () => const ActivityBookingConfirmationPage(),
        middlewares: [MyMiddelware()],
      ),

      // profile pages

      GetPage(
        name: Approute_profileViewProfile,
        page: () => const ProfileViewProfilePage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileEditProfile,
        page: () => const ProfileEditProfilePage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileEditEmail,
        page: () => const ProfileEditEmailPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileEditMobile,
        page: () => const ProfileEditMobilePage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileEditMobileOTP,
        page: () => const OTPInputPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileEditEmailOTP,
        page: () => const OTPInputPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileResetPassword,
        page: () => const ProfileResetPasswordPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileMyBookings,
        page: () => const ProfileMyBookingsPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileMyTravelStories,
        page: () => const ProfileMyTravelStoriesPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileNewTravelStories,
        page: () => const ProfileNewTravelStoryPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileMyCopassenger,
        page: () => const ProfileMyCoPassengersPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_profileAuditCopassenger,
        page: () => const ProfileAuditCopassengerPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_coreAppSettings,
        page: () => const CoreSettingsPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_coreAppInfo,
        page: () => const CoreInfoPage(),
        middlewares: [MyMiddelware()],
      ),
      GetPage(
        name: Approute_coreInfoDoc,
        page: () => const DocumentPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_coreSmartPayment,
        page: () => const SmartPaymentPage(),
        middlewares: [MyMiddelware()],
      ),

      //insurance related

      GetPage(
        name: Approute_insuranceLandingPage,
        page: () => const InsuranceLandingPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_insuranceUserDetailsSubmission,
        page: () => const InsuranceUserDetailsSubmissionPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_insuranceSummary,
        page: () => const InsuranceBookingSummaryPage(),
        middlewares: [MyMiddelware()],
      ),

      GetPage(
        name: Approute_insuranceConfirmation,
        page: () => const InsuranceBookingConfirmationPage(),
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
