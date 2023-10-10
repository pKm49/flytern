import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class AuthResetPasswordCredentialsPage extends StatefulWidget {
  const AuthResetPasswordCredentialsPage({super.key});

  @override
  State<AuthResetPasswordCredentialsPage> createState() => _AuthResetPasswordCredentialsPageState();
}

class _AuthResetPasswordCredentialsPageState extends State<AuthResetPasswordCredentialsPage> {

  TextEditingController emailController = TextEditingController();
   final GlobalKey<FormState> resetPasswordEmailFormKey = GlobalKey<FormState>();


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
            Text("reset_password_message".tr,style: getBodyMediumStyle(context)),
            addVerticalSpace(flyternSpaceLarge*2),
            TextFormField(
                controller: emailController,
                validator: (value) => checkIfEmailValid(value),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "email".tr,
                )),
            addVerticalSpace(flyternSpaceLarge),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(style: getElevatedButtonStyle(context),
                  onPressed: () async {
                    Get.toNamed(Approute_resetPasswordOtp);
                  },
                  child:Text("submit".tr )),
            ),

          ],
        ),
      ),
    );
  }
}
