import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

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
                      Navigator.pop(context);
                    },
                    child: profileController.isEmailSubmitting.value
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
