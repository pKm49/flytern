import 'package:flytern/core-module/ui/pages/drawer_pages/document_viewer.core.page.dart';
import 'package:flytern/core-module/ui/pages/drawer_pages/guest_booking_finder.core.page.dart';
import 'package:flytern/core-module/ui/pages/drawer_pages/flytern_info.core.page.dart';
import 'package:flytern/core-module/ui/pages/app_landing.core.page.dart';
import 'package:flytern/core-module/ui/pages/initial_language_country_selector.core.page.dart';
import 'package:flytern/core-module/ui/pages/drawer_pages/app_settings.core.page.dart';
import 'package:flytern/core-module/ui/pages/drawer_pages/smart_payment.core.page.dart';
import 'package:flytern/core-module/ui/pages/notifications.core.page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/list_page.activity_booking.page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/booking_confirmation_page.activity_booking.page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/booking_summary_page.activity_booking.page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/details_page.activity_booking.page.dart';
import 'package:flytern/feature-modules/activity_booking/ui/pages/userdetails_submission.activity_booking.page.dart';
import 'package:flytern/feature-modules/auth/ui/pages/auth_selector.auth.page.dart';
import 'package:flytern/feature-modules/auth/ui/pages/login.auth.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/explore_section/all_popular_destinations.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/explore_section/all_recommended_items.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/explore_section/all_travel_stories.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/more_options.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/userdetails_submission.flight_booking.page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/userdetails_submission.hotel_booking.page.dart';
import 'package:flytern/feature-modules/packages/ui/pages/booking_confirmation.packages.page.dart';
import 'package:flytern/shared-module/ui/pages/full_screen_image_viewer.dart';
import 'package:flytern/shared-module/ui/pages/otp_input.shared.page.dart';
import 'package:flytern/feature-modules/auth/ui/pages/register.auth.page.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_credentials.auth.page.dart';
import 'package:flytern/feature-modules/auth/ui/pages/reset_password/reset_password_new_password.auth.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/addon_services.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/baggage_selection.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/booking_confirmation.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/booking_summary.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/details.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/meal_selection.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/search_results.flight_booking.page.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/seat_selection.flight_booking.page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/booking_confirmation.hotel_booking.page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/booking_summary.hotel_booking.page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/details.hotel_booking.page.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/pages/search_results.hotel_booking.page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/booking_confirmation.insurance.page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/booking_summary.insurance.page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/landing.insurance.page.dart';
import 'package:flytern/feature-modules/insurance/ui/pages/user_details_submission.insurance.page.dart';
import 'package:flytern/feature-modules/packages/ui/pages/details.packages.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/audit_copassenger.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/edit_email_page.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/edit_mobile_page.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/edit_profile_page.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_bookings.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_copassengers.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/my_travel_stories.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/new_travel_story_page.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/profile_edit_pages/reset_password_page.profile.page.dart';
import 'package:flytern/feature-modules/profile/ui/pages/view_profile_page.profile.page.dart';
import 'package:flytern/shared-module/ui/pages/payment_gateway_webview.shared.page.dart';
import 'package:flytern/shared-module/ui/pages/userdetails_submission_page.shared.page.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:get/get.dart';

getAppRoutes() => [
      GetPage(
        name: Approute_langaugeSelector,
        page: () => CoreLanguageSelector(),
      ),
      GetPage(
        name: Approute_authSelector,
        page: () => const AuthSelectorPage(),
      ),
      GetPage(
        name: Approute_registerPersonalData,
        page: () => const AuthRegisterDetailsInputPage(),
      ),
      GetPage(
        name: Approute_registerOtp,
        page: () => const OTPInputPage(),
      ),
      GetPage(
        name: Approute_login,
        page: () => const AuthLoginPage(),
      ),
      GetPage(
        name: Approute_resetPasswordMobile,
        page: () => const AuthResetPasswordCredentialsPage(),
      ),
      GetPage(
        name: Approute_resetPasswordOtp,
        page: () => const OTPInputPage(),
      ),
      GetPage(
        name: Approute_resetPasswordNewpassword,
        page: () => const AuthResetPasswordNewPasswordPage(),
      ),
      GetPage(
        name: Approute_landingpage,
        page: () => const CoreLandingPage(),
      ),
      GetPage(
        name: Approute_notificationspage,
        page: () => NotificationsPage(),
      ),

      GetPage(
        name: Approute_allpopulardestinations,
        page: () => const AllPopularDestinationsPage(),
      ),

      GetPage(
        name: Approute_allrecommendedpackages,
        page: () => const AllRecommendedItemsPage(),
      ),

      GetPage(
        name: Approute_alltravelstories,
        page: () => const AllTravellStoriesPage(),
      ),

      // Common
      GetPage(
        name: Approute_userDetailsSubmission,
        page: () => const UserDetailsSubmissionPage(),
      ),

      GetPage(
        name: Approute_paymentPage,
        page: () => const PaymentGatewayWebView(),
      ),

      GetPage(
        name: Approute_imageViewer,
        page: () =>   FullScreenImageViewer(),
      ),

      // flight booking

      GetPage(
        name: Approute_flightsSearchResult,
        page: () => const FlightSearchResultPage(),
      ),

      GetPage(
        name: Approute_flightsMoreOptions,
        page: () => const FlightMoreOptionsPage(),
      ),

      GetPage(
        name: Approute_flightsDetails,
        page: () => const FlightDetailsPage(),
      ),

      GetPage(
        name: Approute_flightsAddonServices,
        page: () => const FlightAddonServicesPage(),
      ),

      GetPage(
        name: Approute_flightsSeatSelection,
        page: () => const FlightSeatSelectionPage(),
      ),

      GetPage(
        name: Approute_flightsMealSelection,
        page: () => const FlightMealSelectionPage(),
      ),

      GetPage(
        name: Approute_flightsBaggageSelection,
        page: () => const FlightBaggageSelectionPage(),
      ),

      // Common
      GetPage(
        name: Approute_flightsUserSelection,
        page: () => const FlightUserDetailsSubmissionPage(),
      ),

      GetPage(
        name: Approute_flightsSummary,
        page: () => const FlightBookingSummaryPage(),
      ),

      GetPage(
        name: Approute_flightsConfirmation,
        page: () => const FlightBookingConfirmationPage(),
      ),

//  Hotel Booking
      GetPage(
        name: Approute_hotelsSearchResult,
        page: () => const HotelSearchResultPage(),
      ),

      GetPage(
        name: Approute_hotelsDetails,
        page: () => const HotelDetailsPage(),
      ),

      GetPage(
        name: Approute_hotelsUserSelection,
        page: () => const HotelUserDetailsSubmissionPage(),
      ),

      GetPage(
        name: Approute_hotelsSummary,
        page: () => const HotelBookingSummaryPage(),
      ),

      GetPage(
        name: Approute_hotelsConfirmation,
        page: () => const HotelBookingConfirmationPage(),
      ),

      //  package
      GetPage(
        name: Approute_packagesDetails,
        page: () => const PackageDetailsPage(),
      ),

      GetPage(
        name: Approute_packagesConfirmation,
        page: () => const PackageBookingConfirmationPage(),
      ),

//  activities Booking

      GetPage(
        name: Approute_activitiesList,
        page: () => const ActivitiesListPage(),
      ),

      GetPage(
        name: Approute_activitiesDetails,
        page: () => const ActivityDetailsPage(),
      ),

      GetPage(
        name: Approute_activitiesUserDataSubmission,
        page: () => const ActivityUserDetailsSubmissionPage(),
      ),

      GetPage(
        name: Approute_activitiesSummary,
        page: () => const ActivityBookingSummaryPage(),
      ),

      GetPage(
        name: Approute_activitiesConfirmation,
        page: () => const ActivityBookingConfirmationPage(),
      ),

      // profile pages

      GetPage(
        name: Approute_profileViewProfile,
        page: () => const ProfileViewProfilePage(),
      ),

      GetPage(
        name: Approute_profileEditProfile,
        page: () => const ProfileEditProfilePage(),
      ),

      GetPage(
        name: Approute_profileEditEmail,
        page: () => const ProfileEditEmailPage(),
      ),

      GetPage(
        name: Approute_profileEditMobile,
        page: () => const ProfileEditMobilePage(),
      ),

      GetPage(
        name: Approute_profileEditMobileOTP,
        page: () => const OTPInputPage(),
      ),

      GetPage(
        name: Approute_profileEditEmailOTP,
        page: () => const OTPInputPage(),
      ),

      GetPage(
        name: Approute_profileResetPassword,
        page: () => const ProfileResetPasswordPage(),
      ),

      GetPage(
        name: Approute_profileMyBookings,
        page: () => const ProfileMyBookingsPage(),
      ),

      GetPage(
        name: Approute_profileMyTravelStories,
        page: () => const ProfileMyTravelStoriesPage(),
      ),

      GetPage(
        name: Approute_profileNewTravelStories,
        page: () => const ProfileNewTravelStoryPage(),
      ),

      GetPage(
        name: Approute_profileMyCopassenger,
        page: () => const ProfileMyCoPassengersPage(),
      ),

      GetPage(
        name: Approute_profileAuditCopassenger,
        page: () => const ProfileAuditCopassengerPage(),
      ),

      GetPage(
        name: Approute_coreAppSettings,
        page: () => const CoreSettingsPage(),
      ),

      GetPage(
        name: Approute_coreAppInfo,
        page: () => const CoreInfoPage(),
      ),
      GetPage(
        name: Approute_coreInfoDoc,
        page: () => const DocumentPage(),
      ),

      GetPage(
        name: Approute_coreSmartPayment,
        page: () => const SmartPaymentPage(),
      ),

      GetPage(
        name: Approute_coreGuestBookingFinder,
        page: () => const GuestBookingPage(),
      ),

      //insurance related

      GetPage(
        name: Approute_insuranceLandingPage,
        page: () => const InsuranceLandingPage(),
      ),

      GetPage(
        name: Approute_insuranceUserDetailsSubmission,
        page: () => const InsuranceUserDetailsSubmissionPage(),
      ),

      GetPage(
        name: Approute_insuranceSummary,
        page: () => const InsuranceBookingSummaryPage(),
      ),

      GetPage(
        name: Approute_insuranceConfirmation,
        page: () => const InsuranceBookingConfirmationPage(),
      ),
    ];
