import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flytern/core/controllers/core_controller.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/country.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/data/models/business_models/language.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/country_selector.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

class CoreLanguageSelector extends StatefulWidget {
  const CoreLanguageSelector({super.key});

  @override
  State<CoreLanguageSelector> createState() => _CoreLanguageSelectorState();
}

class _CoreLanguageSelectorState extends State<CoreLanguageSelector> {

  final sharedController = Get.find<SharedController>();
  final coreController = Get.find<CoreController>();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(ASSETS_AUTH_BG);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _initializeVideoPlayerFuture.then((_) => setState(() {
          _controller.play();
        }));
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx(
        ()=> SizedBox(
          height: screenheight,
          width: screenwidth,
          child: Stack(
            children: [
              Visibility(
                visible: !coreController.isAuthTokenSet.value,
                child: Container(
                  width: screenwidth,
                  padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  height: screenheight,
                  child: Center(
                    child: Image.asset(ASSETS_NAMELOGO, width: screenwidth*.4),
                  ),
                ),
              ),
              Visibility(
                visible: coreController.isAuthTokenSet.value,
                child: Container(
                    width: screenwidth,
                    padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                    height: screenheight,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return AspectRatio(
                            aspectRatio: 9 / 16,
                            // Use the VideoPlayer widget to display the video.
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return   Center(
                            child: LoadingAnimationWidget.prograssiveDots(
                              color: flyternBackgroundWhite,
                              size: 50,
                            ),
                          );
                        }
                      },
                    )),
              ),
              Visibility(
                visible: coreController.isAuthTokenSet.value,
                child: SizedBox(
                  height: screenheight,
                  width: screenwidth,
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.topCenter,
                        padding: flyternLargePaddingAll * 2.5,
                        width: screenwidth,
                        child: Container(),
                      )),
                      Obx(
                            () => Container(
                            width: screenwidth,
                            decoration: BoxDecoration(
                              color: flyternBackgroundWhite,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(flyternBlurRadiusLarge),
                                topLeft: Radius.circular(flyternBlurRadiusLarge),
                              ),
                            ),
                            padding: flyternLargePaddingAll,
                            alignment: Alignment.bottomCenter,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: flyternSpaceLarge),
                                  child: Image.asset(ASSETS_NAMELOGO,
                                      width: screenwidth * .4),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: openCountrySelector,
                                        child: Container(
                                          decoration:
                                              flyternBorderedContainerSmallDecoration,
                                          padding: flyternMediumPaddingAll,
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
                                    addHorizontalSpace(flyternSpaceMedium),
                                    Expanded(
                                      child: InkWell(
                                        onTap: openCountrySelector,
                                        child: Container(
                                          decoration:
                                              flyternBorderedContainerSmallDecoration,
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
                                  ],
                                ),
                                const SizedBox(
                                  height: flyternSpaceLarge,
                                  width: 20,
                                ),
                                SizedBox(
                                  width:sharedController.isSetDeviceLanguageAndCountrySubmitting.value?double.maxFinite :double.infinity,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        await sharedController.setDeviceLanguageAndCountry();
                                        Get.toNamed(Approute_authSelector);
                                      },
                                      style: getElevatedButtonStyle(context),
                                      child:sharedController.isSetDeviceLanguageAndCountrySubmitting.value?
                                      LoadingAnimationWidget.prograssiveDots(
                                        color: flyternBackgroundWhite,
                                        size: 16,
                                      ):Text("continue".tr)),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
