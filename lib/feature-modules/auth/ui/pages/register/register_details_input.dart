import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/privacy.dart';
import 'package:flytern/shared/ui/components/terms.dart';
import 'package:get/get.dart';

class AuthRegisterDetailsInputPage extends StatefulWidget {
  const AuthRegisterDetailsInputPage({super.key});

  @override
  State<AuthRegisterDetailsInputPage> createState() =>
      _AuthRegisterDetailsInputPageState();
}

class _AuthRegisterDetailsInputPageState
    extends State<AuthRegisterDetailsInputPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  bool isSubscriptionsAgreed = false;
  bool isTermsAgreed = false;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("create_account".tr),
      ),
      body: Container(
        width: screenwidth,
        padding: flyternLargePaddingHorizontal,
        child: ListView(
          children: [
            addVerticalSpace(flyternSpaceSmall),
            Text("create_account_message".tr,
                style: getBodyMediumStyle(context)),
            addVerticalSpace(flyternSpaceLarge * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenwidth * .35,
                  width: screenwidth * .35,
                  child: Column(
                    children: [
                      DottedBorder(
                        borderType: BorderType.RRect,
                        color: flyternGrey40,
                        dashPattern: [6, 6, 6, 6],
                        radius:
                            Radius.circular(flyternBorderRadiusLarge * 100),
                        strokeWidth: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(
                              flyternBorderRadiusLarge * 100)),
                          child: Container(
                            height: screenwidth * .25,
                            width: screenwidth * .25,
                            child: Center(
                              child: Icon(Icons.camera_alt_outlined,
                                  size: screenwidth * .08,
                                  color: flyternGrey40),
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(flyternSpaceSmall),
                      Text("upload_photo".tr,
                          style: getBodyMediumStyle(context)
                              .copyWith(color: flyternGrey60)),
                    ],
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
            addVerticalSpace(flyternSpaceLarge * 1.5),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                      controller: emailController,
                      validator: (value) => checkIfEmailValid(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "first_name".tr,
                      )),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                  child: TextFormField(
                      controller: emailController,
                      validator: (value) => checkIfEmailValid(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "last_name".tr,
                      )),
                ),
              ],
            ),
            addVerticalSpace(flyternSpaceMedium),
            TextFormField(
                controller: emailController,
                validator: (value) => checkIfEmailValid(value),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "email".tr,
                )),
            addVerticalSpace(flyternSpaceMedium),
            TextFormField(
                controller: passwordController,
                validator: (value) => checkIfPasswordFieldValid(value),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  labelText: "password".tr,
                )),
            addVerticalSpace(flyternSpaceMedium),
            TextFormField(
                controller: passwordController,
                validator: (value) => checkIfPasswordFieldValid(value),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  labelText: "confirm_password".tr,
                )),
            addVerticalSpace(flyternSpaceMedium),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                      controller: emailController,
                      validator: (value) => checkIfEmailValid(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "🇰🇼 +965",
                      )),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                      controller: emailController,
                      validator: (value) => checkIfEmailValid(value),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "mobile".tr,
                      )),
                ),
              ],
            ),
            addVerticalSpace(flyternSpaceLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isSubscriptionsAgreed,
                  onChanged: (bool? value) {
                     setState(() {
                       isSubscriptionsAgreed = value??false;
                     });
                  },
                ),

                addHorizontalSpace(flyternSpaceSmall),

                Expanded(
                  child: Text("subscription_confirm_message".tr,style: getBodyMediumStyle(context),
                  maxLines: 2),
                ),
              ],
            ),
            addVerticalSpace(flyternSpaceSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isTermsAgreed,
                  onChanged: (bool? value) {
                    setState(() {
                      isTermsAgreed = value??false;
                    });
                  },
                ),

                addHorizontalSpace(flyternSpaceSmall),

                Expanded(
                  child:  RichText(
                    text: TextSpan(
                      text: "${"terms_agree_message".tr} ",
                      style: getBodyMediumStyle(context) ,
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () =>openTermsBottomSheet( ),
                            text: "terms_n_conditions".tr,
                            style: const TextStyle(fontWeight: flyternFontWeightBold,decoration: TextDecoration.underline,
                            color: flyternSecondaryColor)),
                        const TextSpan(
                          // recognizer: new TapGestureRecognizer()
                          //   ..onTap = () =>getTermsPdfData(),
                            text: " & " ),
                        TextSpan(
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () =>openPrivacyBottomSheet( ),
                            text: "privacy_policy".tr,
                            style: const TextStyle(fontWeight: flyternFontWeightBold,decoration: TextDecoration.underline,
                                color: flyternSecondaryColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(flyternSpaceLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: ()   {
                    Get.toNamed(Approute_registerOtp);
                  }, child: Text("create_account".tr)),
            ),
            addVerticalSpace(flyternSpaceLarge),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "already_have_an_account".tr,
                  style: getBodyMediumStyle(context).copyWith(),
                ),
                addHorizontalSpace(flyternSpaceSmall),
                Text(
                  "sign_in".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      fontWeight: flyternFontWeightBold,
                      color: flyternSecondaryColor),
                ),
              ],
            ),
            addVerticalSpace(flyternSpaceLarge),
            addVerticalSpace(flyternSpaceLarge),
          ],
        ),
      ),
    );


  }

  void openTermsBottomSheet( ) {
    showModalBottomSheet(
      useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(flyternBorderRadiusMedium),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SharedTermsConditionsPage();
        });
    // Get.bottomSheet(
    //     Container(
    //       child:  SharedTermsConditionsPage(),
    //       height: 1000
    //     ),
    //
    //   backgroundColor: flyternBackgroundWhite,
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // );
  }

  void openPrivacyBottomSheet( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(flyternBorderRadiusMedium),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SharedPrivacyPolicyPage();
        });
    // Get.bottomSheet(
    //     Container(
    //       child:  SharedTermsConditionsPage(),
    //       height: 1000
    //     ),
    //
    //   backgroundColor: flyternBackgroundWhite,
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return flyternSecondaryColor;
    }
    return flyternBackgroundWhite;
  }

}
