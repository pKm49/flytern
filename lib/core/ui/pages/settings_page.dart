import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/ui/components/confirm_dialogue.dart';
import 'package:flytern/shared/ui/components/preposticon_button.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CoreSettingsPage extends StatefulWidget {
  const CoreSettingsPage({super.key});

  @override
  State<CoreSettingsPage> createState() => _CoreSettingsPageState();
}

class _CoreSettingsPageState extends State<CoreSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("app_settings"),
        elevation: 0.5,
      ),
      body: Container(
        padding: flyternLargePaddingAll,
        color: flyternBackgroundWhite,
        child: ListView(
          children: [
            addVerticalSpace(flyternSpaceLarge),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor:0,
                onPressed: (){
                },
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "smart_payment".tr,
                preIconData: Ionicons.cash_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor:0,
                onPressed: (){
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
                specialColor:0,
                onPressed: (){
                },
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
                specialColor:0,
                onPressed: (){
                },
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
                specialColor:0,
                onPressed: (){
                },
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "travel_stories".tr,
                preIconData: Ionicons.reader_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor:0,
                onPressed: (){
                },
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
                specialColor:0,
                onPressed: (){
                },
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "manage_bookings".tr,
                preIconData: Ionicons.list_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor:0,
                onPressed: (){
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
                specialColor:0,
                onPressed: (){
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
                specialColor:0,
                onPressed: (){
                },
                theme: 'dark',
                border: 'bottom',
                buttonTitle: "rating".tr,
                preIconData: Ionicons.star_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),

            addVerticalSpace(flyternSpaceSmall),
            SizedBox(
              width: double.infinity,
              child: PrePostIconButton(
                specialColor:1,
                onPressed: (){
                  showConfirmDialog();
                },
                theme: 'dark',
                border: '',
                buttonTitle: "logout".tr,
                preIconData: Ionicons.log_out_outline,
                postIconData: Ionicons.chevron_forward,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showConfirmDialog() async {

    showDialog(
      context: context,
      builder: (_) => ConfirmDialogue(
          onClick:() async {
            Get.offAllNamed(Approute_langaugeSelector);
          },
          titleKey: 'logout'.tr+" ?", subtitleKey: 'logout_confirm'.tr),
    );

  }
}
