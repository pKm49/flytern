import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
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

  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("app_settings".tr),
        elevation: 0.5,
      ),
      body: Container(
        height: screenheight,
        color: flyternBackgroundWhite,
        child: ListView(
          children: [
            Container(
              width: screenwidth  ,
              padding: flyternLargePaddingAll,
              height: flyternSpaceLarge,
              decoration: BoxDecoration(
                color: flyternGrey10,
              ),
            ),
            addVerticalSpace(flyternSpaceSmall),

            Padding(
              padding: flyternLargePaddingHorizontal,
              child: SizedBox(
                width: double.infinity,
                child: PrePostIconButton(
                  specialColor:0,
                  onPressed: (){
                  },
                  theme: 'dark',
                  border: 'bottom',
                  buttonTitle: "language".tr,
                  preIconData: Ionicons.language_outline,
                  postIconData: Ionicons.chevron_forward,
                ),
              ),
            ),


            addVerticalSpace(flyternSpaceSmall),
            Padding(
              padding: flyternLargePaddingHorizontal,
              child: SizedBox(
                width: double.infinity,
                child: PrePostIconButton(
                  specialColor:0,
                  onPressed: (){
                  },
                  theme: 'dark',
                  border: 'bottom',
                  buttonTitle: "country".tr,
                  preIconData: Ionicons.globe_outline,
                  postIconData: Ionicons.chevron_forward,
                ),
              ),
            ),

            Padding(
              padding: flyternLargePaddingHorizontal,
              child: SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                      padding:  flyternMediumPaddingVertical,
                      decoration: BoxDecoration(
                        color: Colors.transparent, ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:  flyternSpaceMedium),
                            child: Icon(Ionicons.notifications_outline,color:flyternGrey40),
                          ),
                          Expanded(child: Text("push_notifications".tr,textAlign: TextAlign.start ,

                              style: getBodyMediumStyle(context).copyWith(color:  flyternBlack))),

                          Switch(
                            // This bool value toggles the switch.
                            value: isNotificationEnabled,
                            activeColor: flyternSecondaryColor,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                isNotificationEnabled = value;
                              });
                            },
                          )
                        ],
                      )),
                ),
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
