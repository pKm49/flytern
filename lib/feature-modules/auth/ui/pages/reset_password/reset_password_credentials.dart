import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/controllers/reset_password_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/services/utility-services/form_validator.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
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
  final sharedController = Get.find<SharedController>();

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
            countrySelected: (Country? country){

            },
          );
        });

  }

}
