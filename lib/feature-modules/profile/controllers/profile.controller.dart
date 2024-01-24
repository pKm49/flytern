import 'dart:io';

import 'package:flutter/material.dart';
 import 'package:flytern/feature-modules/profile/controllers/copax.profile.controller.dart';
import 'package:flytern/feature-modules/profile/controllers/travel_story.profile.controller.dart';
 import 'package:flytern/feature-modules/profile/models/my_activity.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_booking_response.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_flight_booking.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_hotel_booking.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_insurance.profile.model.dart';
import 'package:flytern/feature-modules/profile/models/my_package.profile.model.dart';
import 'package:flytern/feature-modules/profile/services/http.profile.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/constants/service_types.core.constant.dart';
import 'package:flytern/shared-module/models/auth_token.dart'; 
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/gender.dart';
import 'package:flytern/shared-module/models/user_details.dart'; 
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
  var gender = "0".obs;
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
  var myActivityBookingResponse = <MyActivityBooking>[].obs;
  var totalPages = 1.obs;
  var currentPage = 1.obs;
  var pageSize = 10.obs;
  var currentService = ServiceType.FLIGHT.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
    travelStoryController.getUserTravelStories();

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
    coPaxController.getUserCoPassengers();
  }

  void changeGender(Gender newGender) {
    gender.value = newGender.code;
  }

  void changeNationality(Country country) {
    nationalityController.value.text =
        "${country.countryName}";
    nationalityCode.value = country.countryISOCode;
  }

  void changeMobileCountry(Country country) {
    selectedCountry.value = country;
  }

  void changePassportCountry(Country country) {
    passportCountryController.value.text =
        "${country.countryName}";
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

    if(!isProfileSubmitting.value){
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
          isProfileSubmitting.value = false;
          showSnackbar(Get.context!, "profile_updated".tr, "info");
          await getUserDetails();
        }else{
          showSnackbar(Get.context!, "something_went_wrong".tr, "error");
          isProfileSubmitting.value = false;
        }
      } catch (e) {
        showSnackbar(Get.context!, e.toString(), "error");
        isProfileSubmitting.value = false;
      }
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
              "${selectedCountry.value.code} ${mobileController.value.text}" ,
              userId
            ])?.then((value) async {
          if (value is AuthToken) {
            showSnackbar(Get.context!,
                isMobile ? "mobile_updated".tr : "email_updated".tr, "info");
            final sharedController = Get.find<SharedController>();
            sharedController.handleLogout();
          }
         });
        if (isMobile) {
          isMobileSubmitting.value = false;
        } else {
          isEmailSubmitting.value = false;
        }
      }else{
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
        if (isMobile) {
          isMobileSubmitting.value = false;
        } else {
          isEmailSubmitting.value = false;
        }
      }
    } catch (e, stackk) {

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
        Get.back();
        isPasswordSubmitting.value = false;
        showSnackbar(Get.context!, "password_updated".tr, "info");
        final sharedController = Get.find<SharedController>();
        sharedController.handleLogout();
      }else{
        showSnackbar(Get.context!, "something_went_wrong".tr, "error");
        isPasswordSubmitting.value = false;
      }
    } catch (e) {
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
    dobController.value.text = ( userDetails.dateOfBirth.day == DefaultInvalidDate.day &&
        userDetails.dateOfBirth.month == DefaultInvalidDate.month &&
        userDetails.dateOfBirth.year == DefaultInvalidDate.year )? "":getFormattedDate(userDetails.dateOfBirth);
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

  Future<void> getMyBookings(int pageId, ServiceType servicetype) async {
    currentPage.value = 1;
    totalPages.value = 1;
    pageSize.value = 10;
    currentService.value = servicetype;
    isMyBookingsLoading.value = true;

    try{

      MyBookingResponse myBookingResponse =
      await profileHttpServices.getMyBookings(pageId, servicetype.name);
      totalPages.value = myBookingResponse.totalPages;
      pageSize.value = myBookingResponse.pageSize;
      switch (servicetype){
        case ServiceType.FLIGHT:{
          myFlightBookingResponse.value = myBookingResponse.myFlightBookingResponse;
          break;
        }
        case ServiceType.HOTEL:{
          myHotelBookingResponse.value = myBookingResponse.myHotelBookingResponse;
          break;
        }
        case  ServiceType.INSURANCE:{
          myInsuranceBookingResponse.value =
              myBookingResponse.myInsuranceBookingResponse;
          break;
        }
        case ServiceType.PACKAGE:{
          myPackageBookingResponse.value = myBookingResponse.myPackageBookingResponse;
          break;
        }
        case ServiceType.ACTIVITY:{
          myActivityBookingResponse.value =
              myBookingResponse.myActivityBookingResponse;
          break;
        }
      }

      isMyBookingsLoading.value = false;
    }catch (e){
      showSnackbar(Get.context!, e.toString(), "error");
      isMyBookingsLoading.value = false;
    }

  }

  Future<void> deleteAccount() async {

     bool isSuccess = await profileHttpServices.deleteUserDetails();
    if(isSuccess){
      final sharedController = Get.find<SharedController>();
      sharedController.handleLogout();
      showSnackbar(Get.context!, "account_delete_success_message".tr, "info");
    }else{
      showSnackbar(Get.context!, "something_went_wrong".tr, "error");
    }

  }
}
