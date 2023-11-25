import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flytern/feature-modules/auth/controllers/register_controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/photo_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/html_viewer.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthRegisterDetailsInputPage extends StatefulWidget {
  const AuthRegisterDetailsInputPage({super.key});

  @override
  State<AuthRegisterDetailsInputPage> createState() =>
      _AuthRegisterDetailsInputPageState();
}

class _AuthRegisterDetailsInputPageState
    extends State<AuthRegisterDetailsInputPage> {

  final sharedController = Get.find<SharedController>();
  final registerController = Get.find<RegisterController>();
  var getArguments = Get.arguments;
  var isDirectFlow = true;
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  late File profilePictureFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDirectFlow =getArguments !=null?getArguments[0]:true;
    print("AuthRegisterDetailsInputPage");
    print(isDirectFlow);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("create_account".tr),
      ),
      body: Form(
        key: registerFormKey,
        child: Obx(
          ()=> Container(
            width: screenwidth,
            padding: flyternLargePaddingHorizontal,
            child: ListView(
              children: [
                addVerticalSpace(flyternSpaceSmall),
                Text("create_account_message".tr,
                    style: getBodyMediumStyle(context)),
                addVerticalSpace(flyternSpaceLarge * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenwidth * .35,
                      width: screenwidth * .35,
                      child: Column(
                        children: [
                          InkWell(
                            onTap:(){
                              openSourceSelector(context);
                            },
                            child: DottedBorder(
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
                                    child:registerController.profilePicture.value==''?
                                    Icon(Icons.camera_alt_outlined,
                                        size: screenwidth * .08,
                                        color: flyternGrey40):
                                    Image.memory(
                                      base64Decode(registerController.profilePicture.value)  ,
                                      height: screenwidth *  .35,
                                      width: screenwidth * .35,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: screenwidth * .35,
                                          width: screenwidth * .35,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(1000),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Icon(Icons.camera_alt_outlined,
                                              size: screenwidth * .08,
                                              color: flyternGrey40),
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          addVerticalSpace(flyternSpaceSmall),
                          Text("upload_photo".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey60)),
                        ],
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                addVerticalSpace(flyternSpaceLarge * 1.5),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: registerController.firsNameController.value,
                          validator: (value) => checkIfNameFormValid(value, "first_name".tr),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "first_name".tr,
                          )),
                    ),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                      child: TextFormField(
                          controller: registerController.lastNameController.value,
                          validator: (value) => checkIfNameFormValid(value, "last_name".tr),
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "last_name".tr,
                          )),
                    ),
                  ],
                ),
                addVerticalSpace(flyternSpaceMedium),
                TextFormField(
                    controller: registerController.emailFieldController.value,
                    validator: (value) => checkIfEmailValid(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "email".tr,
                    )),
                addVerticalSpace(flyternSpaceMedium),
                TextFormField(
                    obscureText: registerController.isPasswordVisible.value,
                    controller: registerController.passwordController.value,
                    validator: (value) => checkIfPasswordFieldValid(value),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: (){
                          registerController.updatePasswordVisibility();
                        },
                        child:   Icon(
                            registerController.isPasswordVisible.value?
                            Icons.visibility_off_outlined:Icons.visibility_outlined),
                      ),
                      labelText: "password".tr,
                    )),
                addVerticalSpace(flyternSpaceMedium),
                TextFormField(
                  obscureText: registerController.isConfirmPasswordVisible.value,
                    controller: registerController.confirmPasswordController.value,
                    validator: (value) => checkIfConfirmPasswordFieldValid(value,registerController.passwordController.value.text),
                    decoration: InputDecoration(

                      suffixIcon: InkWell(
                        onTap: (){
                          registerController.updateConfirmPasswordVisibility();
                        },
                        child:   Icon(
                            registerController.isConfirmPasswordVisible.value?
                            Icons.visibility_off_outlined:Icons.visibility_outlined),
                      ),

                      labelText: "confirm_password".tr,
                    )),
                addVerticalSpace(flyternSpaceMedium),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child:  InkWell(
                        onTap: openCountrySelector,
                        child: Container(
                          decoration:
                          flyternBorderedContainerSmallDecoration.copyWith(color: flyternGrey10,border:Border.all(color: Colors.transparent, width: 0) ),
                          padding: flyternMediumPaddingAll.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceLarge),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Image.network(
                                  sharedController
                                      .selectedCountry.value.flag,
                                  width: 17),
                              addHorizontalSpace(flyternSpaceSmall),
                              Expanded(
                                child: Text(
                                    sharedController
                                        .selectedCountry.value.code,
                                    style:
                                    getBodyMediumStyle(context)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    addHorizontalSpace(flyternSpaceMedium),
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                          controller: registerController.mobileController.value,
                          validator: (value) => checkIfMobileNumberValid(value),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "mobile".tr,
                          )),
                    ),
                  ],
                ),
                addVerticalSpace(flyternSpaceLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: registerController.isSubscribedToEmail.value,
                      onChanged: (bool? value) {
                        registerController.updateSubscriptionAgreement(value??false);
                      },
                    ),

                    addHorizontalSpace(flyternSpaceSmall),

                    Expanded(
                      child: Text("subscription_confirm_message".tr,style: getBodyMediumStyle(context),
                      maxLines: 2),
                    ),
                  ],
                ),
                addVerticalSpace(flyternSpaceSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: registerController.isTermsAndPrivacyAgreed.value,
                      onChanged: (bool? value) {
                        registerController.updateTermsAndPrivacyAgreement(value??false);
                      },
                    ),

                    addHorizontalSpace(flyternSpaceSmall),

                    Expanded(
                      child:  RichText(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor,
                        text: TextSpan(
                          text: "${"terms_agree_message".tr} ",
                          style: getBodyMediumStyle(context) ,
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () =>openDocsBottomSheet( "terms_n_conditions" ),
                                text: "terms_n_conditions".tr,
                                style:getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold,
                                    decoration: TextDecoration.underline,
                                color: flyternSecondaryColor)),
                            const TextSpan(
                              // recognizer: new TapGestureRecognizer()
                              //   ..onTap = () =>getTermsPdfData(),
                                text: " & " ),
                            TextSpan(
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () =>openDocsBottomSheet( "privacy_policy" ),
                                text: "privacy_policy".tr,
                                style:getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold,decoration: TextDecoration.underline,
                                    color: flyternSecondaryColor)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(flyternSpaceLarge),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(style: getElevatedButtonStyle(context),
                      onPressed: ()   {
                        if (registerFormKey.currentState!.validate() &&
                            !registerController.isSubmitting.value &&
                          registerController.isTermsAndPrivacyAgreed.value) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          registerController.submitRegisterForm(isDirectFlow);
                        }
                      }, child:registerController.isSubmitting.value
                          ? LoadingAnimationWidget.prograssiveDots(
                        color: flyternBackgroundWhite,
                        size: 16,
                      ): Text("create_account".tr)),
                ),
                addVerticalSpace(flyternSpaceLarge),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already_have_an_account".tr,
                      style: getBodyMediumStyle(context).copyWith(),
                    ),
                    addHorizontalSpace(flyternSpaceSmall),
                    InkWell(
                      onTap: (){
                        Get.toNamed(Approute_login,
                            arguments: [true]);
                      },
                      child: Text(
                        "sign_in".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            fontWeight: flyternFontWeightBold,
                            color: flyternSecondaryColor),
                      ),
                    ),
                  ],
                ),
                addVerticalSpace(flyternSpaceLarge),
                addVerticalSpace(flyternSpaceLarge),
              ],
            ),
          ),
        ),
      ),
    );


  }

  void openDocsBottomSheet(String item ) {
    print("openDocsBottomSheet");
    print(item);
    print(sharedController.termsHtml);
    print(sharedController.privacyHtml);
    showModalBottomSheet(
      useSafeArea: false,
        shape:   const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SharedHtmlViewerPage(
            title:item.tr,
            htmlData:item=="privacy_policy"?
            sharedController.privacyHtml.value
                :sharedController.termsHtml.value,
          );
        });

  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return flyternSecondaryColor;
    }
    return flyternBackgroundWhite;
  }

  void openCountrySelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CountrySelector(countrySelected: (Country? country){

          });
        });

  }

  void openSourceSelector(context) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return PhotoSelector(
            photoSelected: (File? pictureFile) {
              if (pictureFile != null) {
                profilePictureFile = pictureFile;
                Uint8List imageBytes = profilePictureFile.readAsBytesSync();
                registerController.updateProfilePicture(base64Encode(imageBytes),pictureFile);

              }
              setState(() {});
            }, isVideosAllowed: false,
          );
        });



  }

}
