import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileEditEmailPage extends StatefulWidget {
  const ProfileEditEmailPage({super.key});

  @override
  State<ProfileEditEmailPage> createState() => _ProfileEditEmailPageState();
}

class _ProfileEditEmailPageState extends State<ProfileEditEmailPage> {


  final profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();
  final sharedController = Get.find<SharedController>();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("change_email".tr),
        elevation: 0.5,
      ),
      body: Obx(
        ()=> Container(
          width: screenwidth,
          height: screenheight,
          color: flyternGrey10,
          child: ListView(
            children: [
              Container(
                padding: flyternLargePaddingAll,
                color: flyternBackgroundWhite,
                margin: flyternMediumPaddingVertical,
                child: TextFormField(
                    controller: profileController.emailController.value,
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "email".tr,
                    )),
              ),
            ],
          ),
        ),
      ),
        bottomSheet:  Obx(
              () => Container(
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
                      print("email changed");
                      print(profileController.emailController.value.text);
                      print(profileController.userDetails.value.email);
                      if (profileController.emailController.value.text
                          != profileController.userDetails.value.email &&
                          !profileController.isEmailSubmitting.value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        profileController.sendOTP(false);
                      }
                    },
                    child: profileController.isEmailSubmitting.value
                        ? LoadingAnimationWidget.prograssiveDots(
                      color: flyternBackgroundWhite,
                      size: 16,
                    )
                        :Text("update".tr)),
              ),
            ),
          ),
        )
    );
  }
}
