import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class ProfileEditProfilePage extends StatefulWidget {
  const ProfileEditProfilePage({super.key});

  @override
  State<ProfileEditProfilePage> createState() => _ProfileEditProfilePageState();
}

class _ProfileEditProfilePageState extends State<ProfileEditProfilePage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("edit_profile".tr),
        elevation: 0.5,
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Container(
              width: screenwidth  ,
              padding: flyternLargePaddingAll,
              margin: flyternMediumPaddingVertical,
              decoration: BoxDecoration(
                color: flyternBackgroundWhite,
              ),
              child: Row(
                children: [
                  DottedBorder(
                    borderType: BorderType.RRect,
                    color: flyternGrey40,
                    dashPattern: [6, 6, 6, 6],
                    radius:
                    Radius.circular(flyternBorderRadiusLarge * 100),
                    strokeWidth: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(
                          flyternBorderRadiusLarge * 100)),
                      child: Container(
                        height: screenwidth * .25,
                        width: screenwidth * .25,
                        child: Center(
                          child: Icon(Icons.camera_alt_outlined,
                              size: screenwidth * .08,
                              color: flyternGrey40),
                        ),
                      ),
                    ),
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("upload_photo".tr,
                        style: getBodyMediumStyle(context)
                            .copyWith(  color: flyternTertiaryColor,decoration: TextDecoration.underline),),

                    ],
                  ))
                ],
              ),
            ),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) => checkIfEmailValid(value),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "first_name".tr,
                        )),
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) => checkIfEmailValid(value),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "last_name".tr,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: TextFormField(
                  controller: emailController,
                  validator: (value) => checkIfEmailValid(value),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "email".tr,
                  )),
            ),

            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) => checkIfEmailValid(value),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "🇰🇼 +965",
                        )),
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                        controller: emailController,
                        validator: (value) => checkIfEmailValid(value),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "mobile".tr,
                        )),
                  ),
                ],
              ),
            ),

            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: TextFormField(
                  controller: emailController,
                  validator: (value) => checkIfEmailValid(value),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "enter_dob".tr,
                  )),
            ),

            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: TextFormField(
                  controller: emailController,
                  validator: (value) => checkIfEmailValid(value),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "enter_nationality".tr,
                  )),
            ),

            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: 0,bottom: flyternSpaceMedium),
              color: flyternBackgroundWhite,
              child: TextFormField(
                  controller: emailController,
                  validator: (value) => checkIfEmailValid(value),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "enter_passport".tr,
                  )),
            ),
            Container(
              height: 70+(flyternSpaceSmall*2),
              padding: flyternLargePaddingAll,
            )
          ],
        ),
      ),
        bottomSheet: Container(
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
                  child: Text("update".tr)),
            ),
          ),
        )
    );
  }
}
