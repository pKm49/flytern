
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileResetPasswordPage extends StatefulWidget {
  const ProfileResetPasswordPage({super.key});

  @override
  State<ProfileResetPasswordPage> createState() => _ProfileResetPasswordPageState();
}

class _ProfileResetPasswordPageState extends State<ProfileResetPasswordPage> {

  final profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();  

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("reset_password".tr),
          elevation: 0.5,
        ),
        body: Form(
          key: resetPasswordFormKey,
          child: Obx(
            ()=> Container(
              width: screenwidth,
              height: screenheight,
              color: flyternGrey10,
              child: ListView(
                children: [
                  Container(
                    width: screenwidth  ,
                    padding: flyternLargePaddingAll,
                    height: flyternSpaceLarge,
                    decoration: BoxDecoration(
                      color: flyternGrey10,
                    ),
                  ), 
                  Container(
                    padding: flyternLargePaddingAll,
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        controller: profileController.passwordController.value,
                        validator: (value) => checkIfPasswordFieldValid(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Ionicons.eye_outline),
                          labelText: "set_new_password".tr,
                        )),
                  ),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(top:0,bottom: flyternSpaceLarge),
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        controller: profileController.confirmPasswordController.value,
                        validator: (value) => checkIfConfirmPasswordFieldValid(value,profileController.passwordController.value.text),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Ionicons.eye_outline),
                          labelText: "confirm_password".tr,
                        )),
                  ),

                  Container(
                    height: 70+(flyternSpaceSmall*2),
                    padding: flyternLargePaddingAll,
                  )
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Obx(
          ()=> Container(
            width: screenwidth,
            color: flyternBackgroundWhite,
            height: 60 + (flyternSpaceSmall * 2),
            padding: flyternLargePaddingAll.copyWith(
                top: flyternSpaceSmall, bottom: flyternSpaceSmall),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(style: getElevatedButtonStyle(context),
                    onPressed: () {
                      if (resetPasswordFormKey.currentState!.validate() &&
                          !profileController.isPasswordSubmitting.value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        profileController.updatePassword( );
                      }
                    },
                    child:  profileController.isPasswordSubmitting.value
                        ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        color: flyternBackgroundWhite,
                      ),
                    )
                        :Text("update".tr)),
              ),
            ),
          ),
        )
    );
  }
}
