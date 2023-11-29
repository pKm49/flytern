import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileEditMobilePage extends StatefulWidget {
  const ProfileEditMobilePage({super.key});

  @override
  State<ProfileEditMobilePage> createState() => _ProfileEditMobilePageState();
}

class _ProfileEditMobilePageState extends State<ProfileEditMobilePage> {
  final profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> updateProfileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("change_mobile".tr),
          elevation: 0.5,
        ),
        body: Obx(
          () => Container(
            width: screenwidth,
            height: screenheight,
            color: flyternGrey10,
            child: ListView(
              children: [
                Container(
                  padding: flyternLargePaddingAll,
                  color: flyternBackgroundWhite,
                  margin: flyternMediumPaddingVertical,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: openCountrySelector,
                          child: Container(
                            decoration: flyternBorderedContainerSmallDecoration
                                .copyWith(
                                    color: flyternGrey10,
                                    border: Border.all(
                                        color: Colors.transparent, width: 0)),
                            padding: flyternMediumPaddingAll.copyWith(
                                top: flyternSpaceLarge,
                                bottom: flyternSpaceLarge),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                    profileController
                                        .selectedCountry.value.flag,
                                    width: 17),
                                addHorizontalSpace(flyternSpaceSmall),
                                Expanded(
                                  child: Text(
                                      profileController
                                          .selectedCountry.value.code,
                                      style: getBodyMediumStyle(context)),
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
                            controller:
                                profileController.mobileController.value,
                            validator: (value) =>
                                checkIfMobileNumberValid(value),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "mobile".tr,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Obx(
          () => Container(
            width: screenwidth,
            color: flyternBackgroundWhite,
            height: 60 + (flyternSpaceSmall * 2),
            padding: flyternLargePaddingAll.copyWith(
                top: flyternSpaceSmall, bottom: flyternSpaceSmall),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: getElevatedButtonStyle(context),
                    onPressed: () {
                      print("mobile changed");
                      print(profileController.mobileController.value.text);
                      print(profileController.userDetails.value.phoneNumber);
                      if (profileController.mobileController.value.text !=
                              profileController.userDetails.value.phoneNumber &&
                          !profileController.isMobileSubmitting.value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        profileController.sendOTP(true);
                      }
                    },
                    child: profileController.isMobileSubmitting.value
                        ? LoadingAnimationWidget.prograssiveDots(
                            color: flyternBackgroundWhite,
                            size: 16,
                          )
                        : Text("update".tr)),
              ),
            ),
          ),
        ));
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
              isMobile: true,
              countrySelected: (Country? country) {
                if (country != null)
                  profileController.changeMobileCountry(country);
              });
        });
  }
}
