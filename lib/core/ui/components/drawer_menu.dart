import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/core/controllers/core_controller.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/confirm_dialogue.dart';
import 'package:flytern/shared/ui/components/preposticon_button.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreDrawerMenuPage extends StatefulWidget {
  const CoreDrawerMenuPage({super.key});

  @override
  State<CoreDrawerMenuPage> createState() => _CoreDrawerMenuPageState();
}

class _CoreDrawerMenuPageState extends State<CoreDrawerMenuPage> {
  final coreController = Get.find<CoreController>();
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      padding: flyternLargePaddingAll,
      color: flyternBackgroundWhite,
      child: Obx(
        () => ListView(
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
                postIconData: Ionicons.chevron_forward,
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
                  postIconData: Ionicons.chevron_forward,
                ),
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor: 0,
                onPressed: () {
                  Get.toNamed(Approute_insuranceLandingPage);
                },
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "travel_insurance".tr,
                preIconData: Ionicons.pulse_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor: 0,
                onPressed: () {},
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "extra_miles".tr,
                preIconData: Ionicons.walk_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor: 0,
                onPressed: () {},
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "gift_cards".tr,
                preIconData: Ionicons.gift_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor: 0,
                onPressed: () {},
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "travel_tips".tr,
                preIconData: Ionicons.trail_sign_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
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
                postIconData: Ionicons.chevron_forward,
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
                postIconData: Ionicons.chevron_forward,
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
                border: profileController.userDetails.value.email != ""
                    ? 'bottom'
                    : '',
                buttonTitle: "rating".tr,
                preIconData: Ionicons.star_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
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
                  postIconData: Ionicons.chevron_forward,
                ),
              ),
            ),
            Visibility(
                visible: profileController.userDetails.value.email == "",
                child: Container(
                  padding: flyternLargePaddingVertical,
                  color: flyternBackgroundWhite,
                  height: screenheight * .2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text("sign_in".tr),
                          onPressed: () async {
                            Get.toNamed(Approute_login, arguments: [true]);
                          },
                          style: getElevatedButtonStyle(context).copyWith(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  flyternSecondaryColor)),
                        ),
                      ),
                      SizedBox(
                        height: flyternSpaceMedium,
                        width: 20,
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
      final appId = Platform.isAndroid ? 'com.facebook.katana' : 'id284882215';
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
            coreController.handleLogout();
          },
          titleKey: 'logout'.tr + " ?",
          subtitleKey: 'logout_confirm'.tr),
    );
  }
}
