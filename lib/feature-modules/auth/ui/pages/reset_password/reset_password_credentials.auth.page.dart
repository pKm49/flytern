import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password.auth.controller.dart';
 import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthResetPasswordCredentialsPage extends StatefulWidget {
  const AuthResetPasswordCredentialsPage({super.key});

  @override
  State<AuthResetPasswordCredentialsPage> createState() => _AuthResetPasswordCredentialsPageState();

}

class _AuthResetPasswordCredentialsPageState extends State<AuthResetPasswordCredentialsPage> {

  final GlobalKey<FormState> resetPasswordEmailFormKey = GlobalKey<FormState>();
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
        key: resetPasswordEmailFormKey,
        child: Obx(
          ()=> Container(
            width: screenwidth,
            padding: flyternLargePaddingHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                addVerticalSpace(flyternSpaceSmall),
                Text("reset_password_message".tr,style: getBodyMediumStyle(context)),
                addVerticalSpace(flyternSpaceLarge*2),
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
                                  resetPasswordController
                                      .selectedCountry.value.flag,
                                  width: 17),
                              addHorizontalSpace(flyternSpaceSmall),
                              Expanded(
                                child: Text(
                                    resetPasswordController
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
                          controller: resetPasswordController.mobileController.value,
                          validator: (value) => checkIfMobileNumberValid(value),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "mobile".tr,
                          )),
                    ),
                  ],
                ),
                addVerticalSpace(flyternSpaceLarge),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(style: getElevatedButtonStyle(context),
                      onPressed: ()   {
                        if (resetPasswordEmailFormKey.currentState!.validate() &&
                            !resetPasswordController.isSubmitting.value  ) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          resetPasswordController.sendOtp();
                        }
                      }, child:resetPasswordController.isSubmitting.value
                          ? LoadingAnimationWidget.prograssiveDots(
                        color: flyternBackgroundWhite,
                        size: 16,
                      ):Text("submit".tr )),
                ),

              ],
            ),
          ),
        ),
      ),
    );
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
          return CountrySelector(
            isGlobal: false,
            isMobile:true,
            countrySelected: (Country  country){
              resetPasswordController.changeMobileCountry(country);
            },
          );
        });

  }

}
