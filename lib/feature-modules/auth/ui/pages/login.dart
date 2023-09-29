import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("sign_in".tr),
      ),
      body: Container(
        width: screenwidth,
        padding: flyternLargePaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("sign_in_message".tr,style: getBodyMediumStyle(context)),
                addVerticalSpace(flyternSpaceLarge*2),
                TextFormField(
                    controller: emailController,
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "email".tr,
                    )),
                addVerticalSpace(flyternSpaceMedium),
                TextFormField(
                    controller: passwordController,
                    validator: (value) => checkIfPasswordFieldValid(value),
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.remove_red_eye_outlined),
                      labelText:"password".tr,
                    )),
                addVerticalSpace(flyternSpaceLarge),
                Text(
                  "forgot_password".tr,
                  style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold,
                      color: flyternSecondaryColor),
                ),
                addVerticalSpace(flyternSpaceLarge),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                      },
                      child:Text("sign_in".tr )),
                ),
                addVerticalSpace(flyternSpaceLarge),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "dont_have_account".tr,
                      style: getBodyMediumStyle(context).copyWith( ),
                    ),
                    addHorizontalSpace(flyternSpaceSmall),
                    Text(
                      "sign_up".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          fontWeight: flyternFontWeightBold,
                          color: flyternSecondaryColor),

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
            )
          ],
        ),
      ),
    );
  }
}
