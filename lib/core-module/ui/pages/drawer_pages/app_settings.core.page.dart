import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/confirm_dialogue.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:flytern/shared/ui/components/preposticon_button.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CoreSettingsPage extends StatefulWidget {
  const CoreSettingsPage({super.key});

  @override
  State<CoreSettingsPage> createState() => _CoreSettingsPageState();
}

class _CoreSettingsPageState extends State<CoreSettingsPage> {

  bool isNotificationEnabled = true;
  final coreController = Get.find<CoreController>();
  final sharedController = Get.find<SharedController>();


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
        color: flyternGrey10,
        child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: flyternLargePaddingAll,
                  child: Text("country".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          color: flyternGrey80,
                          fontWeight: flyternFontWeightBold)),
                ),
                InkWell(
                  onTap: openCountrySelector,
                  child: Container(
                    color: flyternBackgroundWhite,
                    child: Container(
                      decoration:
                      flyternBorderedContainerSmallDecoration.copyWith(color: flyternBackgroundWhite),
                      padding: flyternMediumPaddingAll,
                      margin: flyternLargePaddingAll,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Image.network(
                              sharedController
                                  .selectedCountry.value.flag,
                              width: 30),
                          addHorizontalSpace(flyternSpaceSmall),
                          Expanded(
                            child: Text(
                                sharedController
                                    .selectedCountry.value.countryCode,
                                style:
                                getBodyMediumStyle(context)),
                          ),
                          addHorizontalSpace(flyternSpaceMedium),
                          Icon(
                            Ionicons.caret_down,
                            color: flyternGrey60,
                            size: flyternFontSize16,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: flyternLargePaddingAll,
                  child: Text("language".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          color: flyternGrey80,
                          fontWeight: flyternFontWeightBold)),
                ),
                InkWell(
                  onTap: openCountrySelector,
                  child: Container(
                    color: flyternBackgroundWhite,
                    child: Container(
                      decoration:
                      flyternBorderedContainerSmallDecoration,
                      margin: flyternLargePaddingAll,
                      padding: flyternMediumPaddingHorizontal.copyWith(top: flyternSpaceExtraSmall,
                          bottom: flyternSpaceExtraSmall),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(Ionicons.language_outline,
                              color: flyternGrey40),
                          addHorizontalSpace(flyternSpaceSmall),
                          Expanded(
                            child: DropDownSelector(
                              titleText: sharedController.selectedLanguage.value.name,
                              selected:sharedController.selectedLanguage.value.code  ,
                              items: [
                                for(var i =0; i<sharedController.languages.length;i++)
                                  GeneralItem(id: sharedController.languages[i].code,
                                      name: sharedController.languages[i].name,
                                      imageUrl: "")
                              ],
                              hintText:"" ,
                              valueChanged: (newLang) {

                                List<Language> langs = sharedController.languages.where((e) => e.code == newLang).toList();
                                if(langs.isNotEmpty){
                                  sharedController
                                      .changeLanguage(
                                      langs[0]
                                  );
                                }


                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),

                Container(
                  color: flyternGrey10,
                  padding: flyternLargePaddingAll,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          await sharedController.setDeviceLanguageAndCountry();
                        },
                        style: getElevatedButtonStyle(context),
                        child:sharedController.isSetDeviceLanguageAndCountrySubmitting.value?
                        LoadingAnimationWidget.prograssiveDots(
                          color: flyternBackgroundWhite,
                          size: 16,
                        ):Text("submit".tr)),
                  ),
                ),
              ],),
        ),
      ),
    );
  }
  void openCountrySelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
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
    // Get.bottomSheet(
    //     Container(
    //       child:  SharedTermsConditionsPage(),
    //       height: 1000
    //     ),
    //
    //   backgroundColor: flyternBackgroundWhite,
    //   elevation: 0,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    // );
  }
}
