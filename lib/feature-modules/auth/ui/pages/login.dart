import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/controllers/login_controller.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {

  var getArguments = Get.arguments;
  final loginController = Get.find<LoginController>();
  var isDirectFlow = true;

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDirectFlow =getArguments !=null?getArguments[0]:true;

    print("AuthLoginPage");
    print(isDirectFlow);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("sign_in".tr),
      ),
      body: Form(
        key: loginFormKey,
        child: Obx(
          ()=> Container(
            width: screenwidth,
            padding: flyternLargePaddingHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    addVerticalSpace(flyternSpaceSmall),
                    Text("sign_in_message".tr,
                        style: getBodyMediumStyle(context)),
                    addVerticalSpace(flyternSpaceLarge * 2),
                    TextFormField(
                        controller: loginController.emailFieldController.value,
                        validator: (value) => checkIfEmailValid(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "email".tr,
                        )),
                    addVerticalSpace(flyternSpaceMedium),
                    TextFormField(
                        controller: loginController.passwordController.value,
                        validator: (value) => checkIfPasswordFieldValid(value),
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          labelText: "password".tr,
                        )),
                    addVerticalSpace(flyternSpaceLarge),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Approute_resetPasswordMobile);
                      },
                      child: Text(
                        "forgot_password".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            fontWeight: flyternFontWeightBold,
                            color: flyternSecondaryColor),
                      ),
                    ),
                    addVerticalSpace(flyternSpaceLarge),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: getElevatedButtonStyle(context),
                          onPressed: () {

                            if (loginFormKey.currentState!.validate() &&
                                !loginController.isSubmitting.value) {
                              FocusManager.instance.primaryFocus?.unfocus();

                              loginController.submitLoginForm(isDirectFlow);
                            }
                          },
                          child: loginController.isSubmitting.value
                              ? LoadingAnimationWidget.prograssiveDots(
                            color: flyternBackgroundWhite,
                            size: 16,
                          )
                              : Text("sign_in".tr)),
                    ),
                    addVerticalSpace(flyternSpaceLarge),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "dont_have_account".tr,
                          style: getBodyMediumStyle(context).copyWith(),
                        ),
                        addHorizontalSpace(flyternSpaceSmall),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Approute_registerPersonalData);
                          },
                          child: Text(
                            "sign_up".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightBold,
                                color: flyternSecondaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "continue_as".tr,
                      style: getBodyMediumStyle(context).copyWith(),
                    ),
                    addHorizontalSpace(flyternSpaceSmall),
                    Text(
                      "guest_user".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          fontWeight: flyternFontWeightBold,
                          color: flyternSecondaryColor),
                    ),
                  ],
                ),
                addVerticalSpace(flyternSpaceLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
