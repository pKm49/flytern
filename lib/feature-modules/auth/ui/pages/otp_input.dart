import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/controllers/login_controller.dart';
import 'package:flytern/feature-modules/auth/controllers/register_controller.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OTPInputPage extends StatefulWidget {
  const OTPInputPage({super.key});

  @override
  State<OTPInputPage> createState() => _OTPInputPageState();
}

class _OTPInputPageState extends State<OTPInputPage> {
  var getArguments = Get.arguments;
  String from = Approute_registerPersonalData;
  late Timer _timer;
  int timeInSeconds = 60;
  var loginController = Get.find<LoginController>();
  var registerController = Get.find<RegisterController>();
  var resetPasswordController = Get.find<ResetPasswordController>();


  @override
  void initState() {
    // TODO: implement initState
    from = getArguments[0];
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("otp_verification".tr),
      ),
      body: Container(
        width: screenwidth,
        padding: flyternLargePaddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(flyternSpaceSmall),
            Text("otp_verification_message".tr,
                style: getBodyMediumStyle(context)),
            addVerticalSpace(flyternSpaceExtraSmall),
            Text(
                from == Approute_registerPersonalData
                    ? ("${registerController.selectedCountry.value.code}  ${registerController.mobileController.value.text}"):
                from == Approute_login? ("your_mobile".tr)
                    : ("${resetPasswordController.selectedCountry.value.code}  ${resetPasswordController.mobileController.value.text}"),
                style: getBodyMediumStyle(context)
                    .copyWith(fontWeight: flyternFontWeightBold)),
            addVerticalSpace(flyternSpaceLarge * 2),
            OTPTextField(
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: flyternGrey20,
                borderColor: flyternGrey20,
                focusBorderColor: flyternGrey40,
                disabledBorderColor: flyternGrey40,
                errorBorderColor: flyternGuideRed,
              ),
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: (screenwidth - (flyternSpaceLarge * 2)) / 7,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                print("Completed: " + pin);
                setState(() {
                  if (from == Approute_registerPersonalData) {
                    registerController.updateOtp(pin);
                  } else if( from == Approute_login) {
                    loginController.updateOtp(pin);
                  }else{
                    resetPasswordController.updateOtp(pin);

                  }
                });
              },
            ),
            addVerticalSpace(flyternSpaceLarge),
            Visibility(
              visible: timeInSeconds > 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "expires_in".tr,
                    style: getBodyMediumStyle(context).copyWith(),
                  ),
                  addHorizontalSpace(flyternSpaceSmall),
                  Text(
                    "$timeInSeconds",
                    style: getBodyMediumStyle(context).copyWith(
                        fontWeight: flyternFontWeightBold,
                        color: flyternSecondaryColor),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: timeInSeconds == 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "otp_expired".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        fontWeight: flyternFontWeightBold,
                        color: flyternSecondaryColor),
                  ),
                ],
              ),
            ),
            addVerticalSpace(flyternSpaceLarge),
            Visibility(
              visible:  timeInSeconds > 0,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: getElevatedButtonStyle(context),
                    onPressed: () {
                      if (from == Approute_registerPersonalData) {
                        if (registerController.otp.value != '') {
                          FocusManager.instance.primaryFocus?.unfocus();
                          registerController
                              .verifyOtp(registerController.otp.value);
                        }
                      } else if (from == Approute_login) {
                        if (loginController.otp.value != '') {
                          FocusManager.instance.primaryFocus?.unfocus();
                          loginController
                              .verifyOtp(loginController.otp.value);
                        }
                      } else{
                        if (resetPasswordController.otp.value != '') {
                          FocusManager.instance.primaryFocus?.unfocus();
                          resetPasswordController
                              .verifyOtp(resetPasswordController.otp.value);
                        }
                      }
                    },
                    child: from == Approute_registerPersonalData
                        ? registerController.isSubmitting.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: flyternBackgroundWhite,
                                ),
                              )
                            : Text("verify".tr):
                    from == Approute_login
                        ? loginController.isSubmitting.value
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: flyternBackgroundWhite,
                      ),
                    )
                        : Text("verify".tr)
                        : resetPasswordController.isSubmitting.value
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  color: flyternBackgroundWhite,
                                ),
                              )
                            : Text("verify".tr)),
              ),
            ),
            addVerticalSpace(flyternSpaceLarge),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "didnt_recieve_code".tr,
                  style: getBodyMediumStyle(context).copyWith(),
                ),
                addHorizontalSpace(flyternSpaceSmall),
                InkWell(
                  onTap: (){
                    if (from == Approute_registerPersonalData) {
                      registerController.resendOtp();
                    } else if (from == Approute_login) {
                      loginController.resendOtp();
                    } else{
                      resetPasswordController.resendOtp();
                    }
                    timeInSeconds = 60;
                    setState(() {

                    });
                    startTimer();
                  },
                  child: Text(
                    "resend".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        fontWeight: flyternFontWeightBold,
                        color: flyternSecondaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeInSeconds == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            timeInSeconds--;
          });
        }
      },
    );
  }
}
