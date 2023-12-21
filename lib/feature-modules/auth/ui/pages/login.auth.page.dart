
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/controllers/login.auth.controller.dart';
 import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
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
                        obscureText: loginController.isPasswordVisible.value,
                        controller: loginController.passwordController.value,
                        validator: (value) => checkIfPasswordFieldValid(value),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: (){
                              loginController.updatePasswordVisibility();
                            },
                            child:   Icon(
                                loginController.isPasswordVisible.value?
                                Icons.visibility_off_outlined:Icons.visibility_outlined),
                          ),

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
                    InkWell(
                      onTap: (){
                        Get.offAllNamed(Approute_landingpage);
                      },
                      child: Text(
                        "guest_user".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            fontWeight: flyternFontWeightBold,
                            color: flyternSecondaryColor),
                      ),
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
