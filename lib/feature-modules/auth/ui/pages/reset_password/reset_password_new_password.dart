import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class AuthResetPasswordNewPasswordPage extends StatefulWidget {
  const AuthResetPasswordNewPasswordPage({super.key});

  @override
  State<AuthResetPasswordNewPasswordPage> createState() => _AuthResetPasswordNewPasswordPageState();
}

class _AuthResetPasswordNewPasswordPageState extends State<AuthResetPasswordNewPasswordPage> {

   TextEditingController passwordController = TextEditingController();
   TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("reset_password".tr),
      ),
      body: Container(
        width: screenwidth,
        padding: flyternLargePaddingHorizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(flyternSpaceSmall),
            Text("new_password_message".tr,style: getBodyMediumStyle(context)),
            addVerticalSpace(flyternSpaceLarge*2),
            TextFormField(
                controller: passwordController,
                validator: (value) => checkIfPasswordFieldValid(value),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  labelText:"password".tr,
                )),
            addVerticalSpace(flyternSpaceMedium),
            TextFormField(
                controller: confirmPasswordController,
                validator: (value) => checkIfPasswordFieldValid(value),
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  labelText:"confirm_password".tr,
                )),
            addVerticalSpace(flyternSpaceLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: getElevatedButtonStyle(context),
                  onPressed: () async {
                    Get.toNamed(Approute_login);
                  },
                  child:Text("reset_password".tr )),
            ),
            addVerticalSpace(flyternSpaceLarge),


          ],
        ),
      ),
    );
  }

}
