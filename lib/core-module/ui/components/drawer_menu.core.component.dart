import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/business_specific/info_types.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/preposticon_button.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreDrawerMenuPage extends StatefulWidget {
  const CoreDrawerMenuPage({super.key});

  @override
  State<CoreDrawerMenuPage> createState() => _CoreDrawerMenuPageState();
}

class _CoreDrawerMenuPageState extends State<CoreDrawerMenuPage> {
  final sharedController = Get.find<SharedController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth*.85,
      height: screenheight,
      padding: flyternLargePaddingAll,
      color: flyternBackgroundWhite,
      child: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  addVerticalSpace(flyternSpaceLarge),
                  SizedBox(
                    width: double.infinity,
                    child: PrePostIconButton(
                      specialColor: 0,
                      onPressed: () {
                        Get.toNamed(Approute_coreSmartPayment);
                      },
                      theme: 'dark',
                      border: 'bottom',
                      buttonTitle: "smart_payment".tr,
                      preIconData: Ionicons.cash_outline,
                      postIconData:Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),
                  Visibility(
                      visible: profileController.userDetails.value.email == "",
                      child: addVerticalSpace(flyternSpaceSmall)),
                  Visibility(
                    visible: profileController.userDetails.value.email == "",
                    child: SizedBox(
                      width: double.infinity,
                      child: PrePostIconButton(
                        specialColor: 0,
                        onPressed: () {
                          Get.toNamed(Approute_coreGuestBookingFinder);
                        },
                        theme: 'dark',
                        border: 'bottom',
                        buttonTitle: "my_bookings".tr,
                        preIconData: Ionicons.list_outline,
                        postIconData:Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                      ),
                    ),
                  ),
                  // addVerticalSpace(flyternSpaceSmall),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: PrePostIconButton(
                  //     specialColor: 0,
                  //     onPressed: () {
                  //       Get.toNamed(Approute_insuranceLandingPage);
                  //     },
                  //     theme: 'dark',
                  //     border: 'bottom',
                  //     buttonTitle: "travel_insurance".tr,
                  //     preIconData: Ionicons.pulse_outline,
                  //     postIconData: Ionicons.chevron_forward,
                  //   ),
                  // ),
                  // addVerticalSpace(flyternSpaceSmall),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: PrePostIconButton(
                  //     specialColor: 0,
                  //     onPressed: () {},
                  //     theme: 'dark',
                  //     border: 'bottom',
                  //     buttonTitle: "extra_miles".tr,
                  //     preIconData: Ionicons.walk_outline,
                  //     postIconData: Ionicons.chevron_forward,
                  //   ),
                  // ),
                  // addVerticalSpace(flyternSpaceSmall),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: PrePostIconButton(
                  //     specialColor: 0,
                  //     onPressed: () {},
                  //     theme: 'dark',
                  //     border: 'bottom',
                  //     buttonTitle: "gift_cards".tr,
                  //     preIconData: Ionicons.gift_outline,
                  //     postIconData: Ionicons.chevron_forward,
                  //   ),
                  // ),
                  // addVerticalSpace(flyternSpaceSmall),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: PrePostIconButton(
                  //     specialColor: 0,
                  //     onPressed: () {},
                  //     theme: 'dark',
                  //     border: 'bottom',
                  //     buttonTitle: "travel_tips".tr,
                  //     preIconData: Ionicons.trail_sign_outline,
                  //     postIconData: Ionicons.chevron_forward,
                  //   ),
                  // ),
                  addVerticalSpace(flyternSpaceSmall),
                  SizedBox(
                    width: double.infinity,
                    child: PrePostIconButton(
                      specialColor: 0,
                      onPressed: () {
                        Get.toNamed(Approute_coreAppSettings);
                      },
                      theme: 'dark',
                      border: 'bottom',
                      buttonTitle: "app_settings".tr,
                      preIconData: Ionicons.settings_outline,
                      postIconData:Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  SizedBox(
                    width: double.infinity,
                    child: PrePostIconButton(
                      specialColor: 0,
                      onPressed: () {
                        Navigator.pop(context);
                        Get.toNamed(Approute_helpCenter);
                      },
                      theme: 'dark',
                      border:  'bottom',
                      buttonTitle: "help_center".tr,
                      preIconData: Ionicons.help_circle_outline,
                      postIconData:Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  SizedBox(
                    width: double.infinity,
                    child: PrePostIconButton(
                      specialColor: 0,
                      onPressed: () {
                        sharedController.getBusinessInfo(InfoType.CONTACTUS);

                      },
                      theme: 'dark',
                      border: 'bottom',
                      buttonTitle: "contact_us".tr,
                      preIconData: Ionicons.call_outline,
                      postIconData: Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),

                  addVerticalSpace(flyternSpaceSmall),
                  SizedBox(
                    width: double.infinity,
                    child: PrePostIconButton(
                      specialColor: 0,
                      onPressed: () {
                        Get.toNamed(Approute_coreAppInfo);
                      },
                      theme: 'dark',
                      border: 'bottom',
                      buttonTitle: "info".tr,
                      preIconData: Ionicons.information_circle_outline,
                      postIconData:Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  SizedBox(
                    width: double.infinity,
                    child: PrePostIconButton(
                      specialColor: 0,
                      onPressed: () {
                        launchRatingPage();
                      },
                      theme: 'dark',
                      border:  '',
                      buttonTitle: "rating".tr,
                      preIconData: Ionicons.star_outline,
                      postIconData:Localizations.localeOf(context)
                          .languageCode
                          .toString() ==
                          'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                    ),
                  ),

                ],
              ),
            ),
            Visibility(
              visible: profileController.userDetails.value.email != "",
              child: SizedBox(
                width: double.infinity,
                child: PrePostIconButton(
                  specialColor: 1,
                  onPressed: () {
                    showConfirmDialog();
                  },
                  theme: 'dark',
                  border: '',
                  buttonTitle: "logout".tr,
                  preIconData: Ionicons.log_out_outline,
                  postIconData:Localizations.localeOf(context)
                      .languageCode
                      .toString() ==
                      'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                ),
              ),
            ),
            Visibility(
                visible: profileController.userDetails.value.email == "",
                child: Container(
                  padding: flyternLargePaddingVertical,
                  color: flyternBackgroundWhite,
                  height: screenheight * .15,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: Text("sign_in".tr),
                        onPressed: () async {
                          Get.toNamed(Approute_login, arguments: [true]);
                        },
                        style: getElevatedButtonStyle(context).copyWith(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                flyternSecondaryColor)),
                      ),
                      SizedBox(
                        height: flyternSpaceMedium,
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: getElevatedButtonStyle(context),
                            onPressed: () async {
                              Get.toNamed(Approute_registerPersonalData);
                            },
                            child: Text("create_account".tr)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> launchRatingPage() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.oneglobal.flytern' : '6469104609';
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  showConfirmDialog() async {
    showDialog(
      context: context,
      builder: (_) => ConfirmDialogue(
          onClick: () async {
            sharedController.handleLogout();
          },
          titleKey: 'logout'.tr + " ?",
          subtitleKey: 'logout_confirm'.tr),
    );
  }
}
