import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
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
