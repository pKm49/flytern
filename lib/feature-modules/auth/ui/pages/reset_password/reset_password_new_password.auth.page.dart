import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password.auth.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthResetPasswordNewPasswordPage extends StatefulWidget {
  const AuthResetPasswordNewPasswordPage({super.key});

  @override
  State<AuthResetPasswordNewPasswordPage> createState() =>
      _AuthResetPasswordNewPasswordPageState();
}

class _AuthResetPasswordNewPasswordPageState
    extends State<AuthResetPasswordNewPasswordPage> {
  final GlobalKey<FormState> resetPasswordNewPasswordFormKey =
      GlobalKey<FormState>();
  final resetPasswordController = Get.find<ResetPasswordController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("reset_password".tr),
      ),
      body: Form(
        key: resetPasswordNewPasswordFormKey,
        child: Obx(
          () => Container(
            width: screenwidth,
            padding: flyternLargePaddingHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(flyternSpaceSmall),
                Text("new_password_message".tr,
                    style: getBodyMediumStyle(context)),
                addVerticalSpace(flyternSpaceLarge * 2),
                TextFormField(
                    obscureText: resetPasswordController.isPasswordVisible.value,
                    controller: resetPasswordController.passwordController.value,
                    validator: (value) => checkIfPasswordFieldValid(value),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: (){
                          resetPasswordController.updatePasswordVisibility();
                        },
                        child:   Icon(
                            resetPasswordController.isPasswordVisible.value?
                            Icons.visibility_off_outlined:Icons.visibility_outlined),
                      ),
                      labelText: "password".tr,
                    )),
                addVerticalSpace(flyternSpaceMedium),
                TextFormField(
                    obscureText: resetPasswordController.isConfirmPasswordVisible.value,
                    controller: resetPasswordController.confirmPasswordController.value,
                    validator: (value) => checkIfConfirmPasswordFieldValid(value,resetPasswordController.passwordController.value.text),
                    decoration: InputDecoration(

                      suffixIcon: InkWell(
                        onTap: (){
                          resetPasswordController.updateConfirmPasswordVisibility();
                        },
                        child:   Icon(
                            resetPasswordController.isConfirmPasswordVisible.value?
                            Icons.visibility_off_outlined:Icons.visibility_outlined),
                      ),

                      labelText: "confirm_password".tr,
                    )),
                addVerticalSpace(flyternSpaceLarge),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: getElevatedButtonStyle(context),
                      onPressed: ()   {
                        if (resetPasswordNewPasswordFormKey.currentState!.validate() &&
                            !resetPasswordController.isSubmitting.value  ) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          resetPasswordController.updatePassword();
                        }
                      }, child:resetPasswordController.isSubmitting.value
                      ? LoadingAnimationWidget.prograssiveDots(
                    color: flyternBackgroundWhite,
                    size: 16,
                  ): Text("reset_password".tr)),
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
