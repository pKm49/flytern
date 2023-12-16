import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/models/language.dart';
import 'package:flytern/shared-module/services/utility-services/form_validator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreSettingsPage extends StatefulWidget {
  const CoreSettingsPage({super.key});

  @override
  State<CoreSettingsPage> createState() => _CoreSettingsPageState();
}

class _CoreSettingsPageState extends State<CoreSettingsPage> {

  bool isNotificationEnabled = true;
   final sharedController = Get.find<SharedController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserCountryAndLanguage();
  }

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
                                  .selectedMobileCountry.value.flag,
                              width: 30),
                          addHorizontalSpace(flyternSpaceSmall),
                          Expanded(
                            child: Text(
                                sharedController
                                    .selectedMobileCountry.value.countryCode,
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
                      padding: flyternLargePaddingAll,
                      child: DropDownSelector(
                        validator: (value) => null,
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
                          await sharedController.setDeviceLanguageAndCountry(false,true);
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
            isMobile:true,
            isGlobal: true,
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

  Future<void> setUserCountryAndLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? selectedMobileCountry = prefs.getString('selectedMobileCountry');
    final String? selectedLanguage = prefs.getString('selectedLanguage');

    if (selectedMobileCountry != ''  ) {
      List<Country> tCountriesList = sharedController.mobileCountries
          .where((element) => selectedMobileCountry == element.countryCode)
          .toList();

      if(tCountriesList.isNotEmpty){
        sharedController.changeMobileCountry(tCountriesList[0]);
      }
    }
    if ( selectedLanguage != '') {
      List<Language> tLanguageList = sharedController.languages
          .where((element) => selectedMobileCountry == element.code)
          .toList();
      if(tLanguageList.isNotEmpty){
        sharedController.changeLanguage(tLanguageList[0]);
      }
    }
  }
}
