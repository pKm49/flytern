import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/services/http.auth.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/models/auth_token.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/local_storage_handler.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {

  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  Rx<TextEditingController> mobileController = TextEditingController().obs;

  var selectedCountry = Country(
      isDefault: 1,
      countryName: "Kuwait",
      countryCode: "KWT",
      countryISOCode: "KW",
      countryName_Ar: "الكويت",
      flag: "https://flagcdn.com/48x36/kw.png",
      code: "+965").obs;

  var userId = "".obs;
  var otp = "".obs;
  var profilePicture = "".obs;
  var errorMessage = "".obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isSubmitting = false.obs;

  var authHttpService = AuthHttpService();

  @override
  void onInit() {
    super.onInit();
  }

  updatePasswordVisibility(){
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  updateConfirmPasswordVisibility(){
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  sendOtp() async {

    isSubmitting.value = true;
    try{

      String userIdFromApi  = await authHttpService.sendOtp(
      mobileController.value.text
      ,selectedCountry.value.code);

      if(userIdFromApi != ""){
        userId.value = userIdFromApi;
        Get.toNamed(Approute_resetPasswordOtp,arguments: [Approute_resetPasswordMobile,
          "${selectedCountry.value.code} ${mobileController.value.text}",userId.value])
            ?.then((value) async {

          if(value is AuthToken){

                  if(value.accessToken != ""){
                    saveAuthTokenToSharedPreference(value);
                    Get.offNamed(Approute_resetPasswordNewpassword);
                  }

          }
        });
      }else{
        throw Exception("Something Went wrong, Please Try Again");
      }
      isSubmitting.value = false;
    }catch (e,t){
      showSnackbar(Get.context!, e.toString(),"error");
      isSubmitting.value = false;
    }

  }

  updatePassword() async {

    if(userId.value != ""){
      isSubmitting.value = true;
      try{
       await authHttpService.updatePassword(passwordController.value.text);
       showSnackbar(Get.context!,
           "password_updated".tr, "info");
       Get.offAllNamed(Approute_authSelector);
       isSubmitting.value = false;
      }catch (e){
        showSnackbar(Get.context!, e.toString(),"error");
        isSubmitting.value = false;
      }
    }

  }

  void updateOtp(String otpString) {
    otp.value = otpString;
  }

  void updateProfilePicture(String base64encode) {
    profilePicture.value = base64encode;
  }

  void changeMobileCountry(Country  country) {
    selectedCountry.value = country;
  }

}
