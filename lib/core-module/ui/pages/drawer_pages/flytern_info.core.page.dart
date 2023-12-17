import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/constants/business_specific/info_types.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/preposticon_button.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreInfoPage extends StatefulWidget {
  const CoreInfoPage({super.key});

  @override
  State<CoreInfoPage> createState() => _CoreInfoPageState();
}

class _CoreInfoPageState extends State<CoreInfoPage> {
  final sharedController = Get.find<SharedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     sharedController.getBusinessInfo(InfoType.SOCIAL);
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("info".tr),
        elevation: 0.5,
      ),
      body: Obx(
        ()=> Stack(
          children: [
            Visibility(
                visible:
                sharedController.isInfoLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  color: flyternGrey10,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: flyternSecondaryColor,
                        size: 50,
                      )),
                )),
            Visibility(
              visible:  !sharedController.isInfoLoading.value,

              child: Container(
                height: screenheight,
                color: flyternBackgroundWhite,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            width: screenwidth,
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
                                specialColor: 0,
                                onPressed: () {
                                  sharedController.getBusinessInfo(InfoType.ABOUTUS);
                                },
                                theme: 'dark',
                                border: 'bottom',
                                buttonTitle: "about_us".tr,
                                preIconData: Ionicons.information_circle_outline,
                                postIconData: Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                              ),
                            ),
                          ),

                          addVerticalSpace(flyternSpaceSmall),
                          Padding(
                            padding: flyternLargePaddingHorizontal,
                            child: SizedBox(
                              width: double.infinity,
                              child: PrePostIconButton(
                                specialColor: 0,
                                onPressed: () {
                                  sharedController.getBusinessInfo(InfoType.TERMS);

                                },
                                theme: 'dark',
                                border: 'bottom',
                                buttonTitle: "terms_n_conditions".tr,
                                preIconData: Ionicons.document_outline,
                                postIconData: Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                              ),
                            ),
                          ),
                          addVerticalSpace(flyternSpaceSmall),
                          Padding(
                            padding: flyternLargePaddingHorizontal,
                            child: SizedBox(
                              width: double.infinity,
                              child: PrePostIconButton(
                                specialColor: 0,
                                onPressed: () {
                                  sharedController.getBusinessInfo(InfoType.PRIVACY);

                                },
                                theme: 'dark',
                                border: 'bottom',
                                buttonTitle: "privacy_policy".tr,
                                preIconData: Ionicons.lock_closed_outline,
                                postIconData: Localizations.localeOf(context)
                                    .languageCode
                                    .toString() ==
                                    'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                              ),
                            ),
                          ),
                          addVerticalSpace(flyternSpaceLarge),
                          Visibility(
                            visible: sharedController.twitterLink.value != "" ||
                                sharedController.facebookLink.value != "" ||
                                sharedController.instagramLink.value != "",
                            child: Padding(
                                padding: flyternLargePaddingHorizontal,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text("social_account".tr,
                                            style: getBodyMediumStyle(context))),
                                    Visibility(
                                        visible:
                                            sharedController.facebookLink.value != "",
                                        child: InkWell(
                                          onTap: (){
                                            _launchUrl(sharedController.facebookLink.value);
                                          },
                                          child: const Icon(
                                            Ionicons.logo_facebook,
                                            color: flyternGrey60, size: flyternFontSize24*1.4
                                          ),
                                        )),
                                    Visibility(
                                        visible:
                                            sharedController.twitterLink.value != "",
                                        child: addHorizontalSpace(flyternSpaceMedium)),
                                    Visibility(
                                        visible:
                                            sharedController.twitterLink.value != "",
                                        child: InkWell(
                                          onTap: (){
                                            _launchUrl(sharedController.twitterLink.value);
                                          },
                                          child: Icon(Ionicons.logo_twitter,
                                              color: flyternGrey60,size: flyternFontSize24*1.4),
                                        )),
                                    Visibility(
                                        visible:
                                            sharedController.instagramLink.value != "",
                                        child: addHorizontalSpace(flyternSpaceMedium)),
                                    Visibility(
                                        visible:
                                            sharedController.instagramLink.value != "",
                                        child: InkWell(
                                          onTap: (){
                                            _launchUrl(sharedController.instagramLink.value);
                                          },
                                          child: Icon(Ionicons.logo_instagram,
                                              color: flyternGrey60,size: flyternFontSize24*1.4),
                                        )),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text(
                        'app_version'.tr + " 1.0.0",
                        textAlign: TextAlign.center,
                        style: getBodyMediumStyle(context).copyWith(
                          color: flyternPrimaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
     }
  }

}
