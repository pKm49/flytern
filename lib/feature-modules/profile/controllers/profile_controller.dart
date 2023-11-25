import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/feature-modules/profile/controllers/copax_controller.dart';
import 'package:flytern/feature-modules/profile/controllers/travel_story_controller.dart';
import 'package:flytern/feature-modules/profile/data/enums/booking_categories.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/my_booking_response.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/my_flight_booking.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/my_hotel_booking.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/my_insurance_booking.dart';
import 'package:flytern/feature-modules/profile/data/models/business-models/my_package_booking.dart';
import 'package:flytern/feature-modules/profile/services/http-services/profile_http.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/core-module/services/http.core.service.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/models/user_details.dart';
import 'package:flytern/shared-module/services/utility-services/local_storage_handler.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> firsNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> passportNumberController =
      TextEditingController().obs;
  Rx<TextEditingController> nationalityController = TextEditingController().obs;
  Rx<TextEditingController> passportCountryController =
      TextEditingController().obs;
  Rx<TextEditingController> passportExpiryController =
      TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;

  var selectedCountry = Country(
      isDefault: 1,
      countryName: "Kuwait",
      countryCode: "KWT",
      countryISOCode: "KW",
      countryName_Ar: "الكويت",
      flag: "https://flagcdn.com/48x36/kw.png",
      code: "+965")
      .obs;

  var dob = DefaultInvalidDate.obs;
  var passportExpiry = DefaultInvalidDate.obs;
  var editCoPaxId = 0.obs;
  var gender = "Male".obs;
  var nationalityCode = "".obs;
  var passportIssuedCountryCode = "".obs;
  var isMyBookingsLoading = false.obs;
  var isProfileSubmitting = false.obs;
  var isPasswordSubmitting = false.obs;
  var isEmailSubmitting = false.obs;
  var isMobileSubmitting = false.obs;
  var profilePicture = "".obs;

  var isGuest = true.obs;
  var isProfileDataLoading = true.obs;
  var userDetails = UserDetails(
      isGuest: true,
      gender: "",
      firstName: "",
      lastName: "",
      phoneCountryCode: "",
      imgUrl: "",
      passportNumber: "",
      dateOfBirth: DefaultInvalidDate,
      passportIssuerCountryCode: "",
      passportIssuerCountryName: "",
      nationalityCode: "",
      nationalityName: "",
      userName: "",
      email: "",
      passportExpiry: DefaultInvalidDate,
      phoneNumber: "",
      genders: []).obs;
  final coPaxController = Get.put(CoPaxController());
  final travelStoryController = Get.put(TravelStoryController());
  var profileHttpServices = ProfileHttpServices();

  var myFlightBookingResponse = <MyFlightBooking>[].obs;
  var myHotelBookingResponse = <MyHotelBooking>[].obs;
  var myInsuranceBookingResponse = <MyInsuranceBooking>[].obs;
  var myPackageBookingResponse = <MyPackageBooking>[].obs;
  var myActivityBookingResponse = <dynamic>[].obs;
  var totalPages = 1.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var currentService = BookingCategory.FLIGHT.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
    travelStoryController.getUserTravelStories();
    coPaxController.getUserCoPassengers();
  }


  updatePasswordVisibility(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  updateConfirmPasswordVisibility(){
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> getUserDetails() async {
    isProfileDataLoading.value = true;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool? isGuest = prefs.getBool('isGuest');
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');
    final String? expiryOnString = prefs.getString('expiryOn');

    print("isGuest");
    print(isGuest);
    print(accessToken);
    print(refreshToken);
    print(expiryOnString);

    if (accessToken != null &&
        accessToken != '' &&
        refreshToken != null &&
        refreshToken != '' &&
        expiryOnString != null &&
        expiryOnString != '' &&
        isGuest != null &&
        !isGuest) {
      UserDetails tempUserDetails = await profileHttpServices.getUserDetails();
      if (tempUserDetails.firstName != "") {
        userDetails.value = tempUserDetails;
        updateEditForm(userDetails.value);
      }

      if (tempUserDetails.genders.isNotEmpty) {
        final sharedController = Get.find<SharedController>();
        sharedController.updateGenders(tempUserDetails.genders);
      }
    }

    isProfileDataLoading.value = false;
  }

  void changeGender(Gender newGender) {
    gender.value = newGender.code;
  }

  void changeNationality(Country country) {
    nationalityController.value.text =
        "${country.countryName} (${country.code})";
    nationalityCode.value = country.countryISOCode;
  }

  void changeMobileCountry(Country country) {
    selectedCountry.value = country;
  }

  void changePassportCountry(Country country) {
    passportCountryController.value.text =
        "${country.countryName} (${country.code})";
    passportIssuedCountryCode.value = country.countryISOCode;
  }

  void changePassportExpiry(DateTime dateTime) {
    final f = DateFormat('dd-MM-yyyy');
    passportExpiryController.value.text = f.format(dateTime);
    passportExpiry.value = dateTime;
  }

  void changeDateOfBirth(DateTime dateTime) {
    final f = DateFormat('dd-MM-yyyy');
    dobController.value.text = f.format(dateTime);
    dob.value = dateTime;
  }

  void updateProfilePicture(String base64encode) {
    profilePicture.value = base64encode;
  }

  void updateProfile(File? file) async {
    isProfileSubmitting.value = true;
    try {
      UserDetails userDetails = UserDetails(
          isGuest: false,
          gender: gender.value,
          firstName: firsNameController.value.text,
          lastName: lastNameController.value.text,
          passportNumber: passportNumberController.value.text,
          dateOfBirth: dob.value,
          passportIssuerCountryCode: passportIssuedCountryCode.value,
          passportIssuerCountryName: "",
          nationalityCode: nationalityCode.value,
          nationalityName: "",
          passportExpiry: passportExpiry.value,
          phoneCountryCode: '',
          imgUrl: '',
          userName: '',
          email: '',
          phoneNumber: '',
          genders: []);

      bool isSuccess =
          await profileHttpServices.updateUserDetails(userDetails, file);

      if (isSuccess) {
        Get.back();
        print("user update completed");
        isProfileSubmitting.value = false;
        print("user update completed 1");

        showSnackbar(Get.context!, "profile_updated".tr, "info");
        print("user update completed 2");

        print("user update completed 3");

        await getUserDetails();
      }
    } catch (e) {
      print("user update failed");
      showSnackbar(Get.context!, e.toString(), "error");
      isProfileSubmitting.value = false;
    }
  }

  sendOTP(bool isMobile) async {
    if (isMobile) {
      isMobileSubmitting.value = true;
    } else {
      isEmailSubmitting.value = true;
    }
    try {
      late String userId;

      if (isMobile) {
        userId = await profileHttpServices.changeMobile(
            selectedCountry.value.code, mobileController.value.text);
      } else {
        userId =
            await profileHttpServices.changeEmail(emailController.value.text);
      }

      if (userId != "") {
        Get.toNamed(
            isMobile
                ? Approute_profileEditMobileOTP
                : Approute_profileEditEmailOTP,
            arguments: [
              isMobile ? Approute_profileEditMobile : Approute_profileEditEmail,
              isMobile
                  ? "${selectedCountry.value.code} ${mobileController.value.text}"
                  : "${emailController.value.text}",
              userId
            ])?.then((value) async {
          if (value is AuthToken) {
            showSnackbar(Get.context!,
                isMobile ? "mobile_updated".tr : "email_updated", "info");
            final coreController = Get.find<CoreController>();
            coreController.handleLogout();
          }
          print("value");
          print(value.toString());
        });
        if (isMobile) {
          isMobileSubmitting.value = false;
        } else {
          isEmailSubmitting.value = false;
        }
      }
    } catch (e, stackk) {
      print("user update failed");
      print(stackk);
      showSnackbar(Get.context!, e.toString(), "error");
      if (isMobile) {
        isMobileSubmitting.value = false;
      } else {
        isEmailSubmitting.value = false;
      }
    }
  }

  updatePassword() async {
    isPasswordSubmitting.value = true;
    try {
      bool isSuccess = await profileHttpServices
          .updatePassword(passwordController.value.text);

      if (isSuccess) {
        isPasswordSubmitting.value = false;
        showSnackbar(Get.context!, "password_updated".tr, "info");
        final coreController = Get.find<CoreController>();
        coreController.handleLogout();
      }
    } catch (e) {
      print("user update failed");
      showSnackbar(Get.context!, e.toString(), "error");
      isPasswordSubmitting.value = false;
    }
  }

  void updateEditForm(UserDetails userDetails) {
    final sharedController = Get.find<SharedController>();

    List<Country> userMobileCountry = sharedController.countries.value
        .where((element) => element.code == userDetails.phoneCountryCode)
        .toList();

    if (userMobileCountry.isNotEmpty) {
      selectedCountry.value = userMobileCountry[0];
    }

    gender.value = userDetails.gender == "" ? "Male" : userDetails.gender;
    nationalityController.value.text = userDetails.nationalityName;
    mobileController.value.text = userDetails.phoneNumber;

    emailController.value.text = userDetails.email;
    passportCountryController.value.text =
        userDetails.passportIssuerCountryName;
    passportExpiryController.value.text =
        getFormattedDate(userDetails.passportExpiry);
    dobController.value.text =  getFormattedDate(userDetails.dateOfBirth);
    firsNameController.value.text = userDetails.firstName;
    lastNameController.value.text = userDetails.lastName;
    passportNumberController.value.text = userDetails.passportNumber;
    dob.value = userDetails.dateOfBirth;
    passportExpiry.value = userDetails.passportExpiry;
    nationalityCode.value = userDetails.nationalityCode;
    passportIssuedCountryCode.value = userDetails.passportIssuerCountryCode;
  }

  String getFormattedDate(DateTime dateTime) {

    if(dateTime.year == DefaultInvalidDate.year && dateTime.month == DefaultInvalidDate.month &&
    dateTime.day == DefaultInvalidDate.day){
      return "";
    }else{
      final f = DateFormat('dd-MM-yyyy');
      return f.format(dateTime);
    }

  }

  Future<void> getMyBookings(int pageId, BookingCategory servicetype) async {
    currentPage.value = 1;
    currentService.value = servicetype;
    isMyBookingsLoading.value = true;
    MyBookingResponse myBookingResponse =
        await profileHttpServices.getMyBookings(pageId, servicetype.name);
    totalPages.value = myBookingResponse.totalPages;
    pageSize.value = myBookingResponse.pageSize;
    switch (servicetype){
      case BookingCategory.FLIGHT:{
        myFlightBookingResponse.value = myBookingResponse.myFlightBookingResponse;
        break;
      }
      case BookingCategory.HOTEL:{
        myHotelBookingResponse.value = myBookingResponse.myHotelBookingResponse;
        break;
      }
      case  BookingCategory.INSURANCE:{
        myInsuranceBookingResponse.value =
            myBookingResponse.myInsuranceBookingResponse;
        break;
      }
      case BookingCategory.PACKAGE:{
        myPackageBookingResponse.value = myBookingResponse.myPackageBookingResponse;
        break;
      }
      case BookingCategory.ACTIVITY:{
        myActivityBookingResponse.value =
            myBookingResponse.myActivityBookingResponse;
        break;
      }
    }

    isMyBookingsLoading.value = false;
  }
}
