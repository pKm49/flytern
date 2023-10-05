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

class CoreInfoPage extends StatefulWidget {
  const CoreInfoPage({super.key});

  @override
  State<CoreInfoPage> createState() => _CoreInfoPageState();
}

class _CoreInfoPageState extends State<CoreInfoPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("info".tr),
        elevation: 0.5,
      ),
      body: Container(
        height: screenheight,
        color: flyternBackgroundWhite,
        child: Column(
          children: [
            Expanded(
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
                        buttonTitle: "about_us".tr,
                        preIconData: Ionicons.information_circle_outline,
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
                        buttonTitle: "contact_us".tr,
                        preIconData: Ionicons.call_outline,
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
                        buttonTitle: "terms_n_conditions".tr,
                        preIconData: Ionicons.document_outline,
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
                        buttonTitle: "privacy_policy".tr,
                        preIconData: Ionicons.lock_closed_outline,
                        postIconData: Ionicons.chevron_forward,
                      ),
                    ),
                  ),
                  addVerticalSpace(flyternSpaceLarge),

                  Padding(
                      padding: flyternLargePaddingHorizontal,
                      child: Row(
                        children: [
                          Expanded(child: Text("social_account".tr,style: getBodyMediumStyle(context))),
                          Icon(Ionicons.logo_facebook,color: flyternGrey60,),
                          addHorizontalSpace(flyternSpaceSmall),
                          Icon(Ionicons.logo_twitter,color: flyternGrey60),
                          addHorizontalSpace(flyternSpaceSmall),
                          Icon(Ionicons.logo_instagram,color: flyternGrey60),
                        ],
                      )
                  ),

                ],
              ),
            ),
            Padding(
              padding: flyternLargePaddingAll,
              child: Text('app_version'.tr + " 1.0.0",
                textAlign: TextAlign.center,
                style: getBodyMediumStyle(context).copyWith(  color: flyternPrimaryColor,
                ),),
            )
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
