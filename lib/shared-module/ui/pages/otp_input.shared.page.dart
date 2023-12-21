import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPInputPage extends StatefulWidget {
  const OTPInputPage({super.key});

  @override
  State<OTPInputPage> createState() => _OTPInputPageState();
}

class _OTPInputPageState extends State<OTPInputPage> {
  var getArguments = Get.arguments;
  String from = Approute_registerPersonalData;
  String otpTarget = "";
  String userId = "";
  late Timer _timer;
  int timeInSeconds = 120;
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState

    from = getArguments[0];
    otpTarget = getArguments[1];
    userId = getArguments[2];
    sharedController.resetOtpResendCount();
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
            Text(otpTarget,
                style: getBodyMediumStyle(context)
                    .copyWith(fontWeight: flyternFontWeightBold)),
            addVerticalSpace(flyternSpaceLarge * 2),
            PinCodeTextField(
              backgroundColor: flyternBackgroundWhite,
              keyboardType: TextInputType.number,
              appContext: context,
              length: 6,
              obscureText: false,
              pinTheme: PinTheme(
                inactiveColor: flyternGuideRed,
                selectedColor: flyternGrey40,
                selectedFillColor: flyternGrey40,
                inactiveFillColor: flyternGuideRed,
                activeFillColor: flyternPrimaryColor,
                activeColor: flyternPrimaryColor,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
                fieldWidth: (screenwidth - (flyternSpaceLarge * 2)) / 7,
                errorBorderColor:flyternGuideRed,

              ),
              onChanged: (value) {
                setState(() {});
              },
              onCompleted: (pin) {
                setState(() {
                  sharedController.updateOtp(pin);
                });
              },
            ),
            // OTPTextField(
            //   otpFieldStyle: OtpFieldStyle(
            //     backgroundColor: flyternGrey20,
            //     borderColor: flyternGrey20,
            //     focusBorderColor: flyternGrey40,
            //     disabledBorderColor: flyternGrey40,
            //     errorBorderColor: flyternGuideRed,
            //   ),
            //   length: 6,
            //   width: MediaQuery.of(context).size.width,
            //   fieldWidth: (screenwidth - (flyternSpaceLarge * 2)) / 7,
            //   style: TextStyle(fontSize: 17),
            //   textFieldAlignment: MainAxisAlignment.spaceAround,
            //   fieldStyle: FieldStyle.box,
            //   onCompleted: (pin) {
            //     setState(() {
            //       sharedController.updateOtp(pin);
            //     });
            //   },
            // ),
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
              visible: timeInSeconds > 0,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: getElevatedButtonStyle(context),
                    onPressed: () {
                      if (isValidOtp(sharedController.otp.value) &&
                          !sharedController.isOtpSubmitting.value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        sharedController.verifyOtp(
                            sharedController.otp.value, userId);
                      } else {
                        if (!isValidOtp(sharedController.otp.value)) {
                          showSnackbar(
                              context, "enter_otp_tocontinue".tr, "error");
                        }
                      }
                    },
                    child: sharedController.isOtpSubmitting.value
                        ? LoadingAnimationWidget.prograssiveDots(
                            color: flyternBackgroundWhite,
                            size: 16,
                          )
                        : Text("verify".tr)),
              ),
            ),
            addVerticalSpace(flyternSpaceLarge),
            Visibility(
              visible: sharedController.otpResendCount.value < 3 &&
                  timeInSeconds == 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "didnt_recieve_code".tr,
                    style: getBodyMediumStyle(context).copyWith(),
                  ),
                  addHorizontalSpace(flyternSpaceSmall),
                  InkWell(
                    onTap: () {
                      sharedController.resendOtp(userId);
                      timeInSeconds = 120;
                      setState(() {});
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

  bool isValidOtp(String value) {

    if (value == "") {
      return false;
    }
    if (value.length != 6) {
      return false;
    }
    return true;
  }
}
