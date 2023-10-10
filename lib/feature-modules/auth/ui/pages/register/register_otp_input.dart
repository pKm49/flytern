import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class AuthRegisterOTPInputPage extends StatefulWidget {
  const AuthRegisterOTPInputPage({super.key});

  @override
  State<AuthRegisterOTPInputPage> createState() => _AuthRegisterOTPInputPageState();
}

class _AuthRegisterOTPInputPageState extends State<AuthRegisterOTPInputPage> {


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
            Text("otp_verification_message".tr,style: getBodyMediumStyle(context)),
            addVerticalSpace(flyternSpaceExtraSmall),
            Text("info@email.com",style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold)),
            addVerticalSpace(flyternSpaceLarge*2),
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

                });
              },
            ),
            addVerticalSpace(flyternSpaceLarge),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "expires_in".tr,
                  style: getBodyMediumStyle(context).copyWith( ),
                ),
                addHorizontalSpace(flyternSpaceSmall),
                Text(
                  "00:00",
                  style: getBodyMediumStyle(context).copyWith(
                      fontWeight: flyternFontWeightBold,
                      color: flyternSecondaryColor),

                ),
              ],
            ),
            addVerticalSpace(flyternSpaceLarge),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: getElevatedButtonStyle(context),
                  onPressed: ()   {
                    Get.offAllNamed(Approute_landingpage);

                  },
                  child:Text("verify".tr )),
            ),
            addVerticalSpace(flyternSpaceLarge),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "didnt_recieve_code".tr,
                  style: getBodyMediumStyle(context).copyWith( ),
                ),
                addHorizontalSpace(flyternSpaceSmall),
                Text(
                  "resend".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      fontWeight: flyternFontWeightBold,
                      color: flyternSecondaryColor),

                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
