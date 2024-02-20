import 'dart:developer';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:flytern/core-module/controllers/core.controller.dart';
import 'package:flytern/shared-module/controllers/shared.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/country.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/models/language.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/country_selector.shared.component.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

    Uri uri = Uri.parse(ASSETS_BG_URL);
    debugPrint(uri.toString());
    _controller = VideoPlayerController.networkUrl(uri);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _initializeVideoPlayerFuture.then((_) => setState(() {
          _controller.play();
        }));

    checkAppVersion();
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
            () => SizedBox(
          height: screenheight,
          width: screenwidth,
          child: Stack(
            children: [
              Visibility(
                visible: !sharedController.isAuthTokenSet.value,
                child: Container(
                  width: screenwidth,
                  padding:
                  const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  height: screenheight,
                  child: Center(
                    child: Image.asset(ASSETS_LOGO, width: screenwidth * .5),
                  ),
                ),
              ),
              Visibility(
                visible: sharedController.isAuthTokenSet.value,
                child: Container(
                    width: screenwidth,
                    padding:
                    const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                    height: screenheight,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done) {
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
                          return Image.asset(ASSETS_VIDEO_BG,width: screenwidth);
                        }
                      },
                    )),
              ),
              Visibility(
                visible: sharedController.isAuthTokenSet.value,
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
                      Container(
                          width: screenwidth,
                          decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            borderRadius: BorderRadius.only(
                              topRight:
                              Radius.circular(flyternBlurRadiusLarge),
                              topLeft:
                              Radius.circular(flyternBlurRadiusLarge),
                            ),
                          ),
                          padding: flyternLargePaddingAll,
                          alignment: Alignment.bottomCenter,
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: flyternSpaceLarge),
                                child: Image.asset(ASSETS_NAMELOGO,
                                    width: screenwidth * .4),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: openCountrySelector,
                                      child: Container(
                                        decoration:
                                        flyternBorderedContainerSmallDecoration
                                            .copyWith(
                                            color: flyternGrey20,
                                            border: Border.all(
                                                color:
                                                flyternGrey60,
                                                width: .2)),
                                        padding: flyternMediumPaddingAll,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                                sharedController
                                                    .selectedMobileCountry
                                                    .value
                                                    .flag,
                                                width: 30),
                                            addHorizontalSpace(
                                                flyternSpaceSmall),
                                            Expanded(
                                              child: Text(
                                                  sharedController
                                                      .selectedMobileCountry
                                                      .value
                                                      .countryCode,
                                                  style: getBodyMediumStyle(
                                                      context)),
                                            ),
                                            addHorizontalSpace(
                                                flyternSpaceMedium),
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
                                    child: DropDownSelector(
                                      validator: (value) => null,
                                      titleText: sharedController
                                          .selectedLanguage.value.name,
                                      selected: sharedController
                                          .selectedLanguage.value.code,
                                      items: [
                                        for (var i = 0;
                                        i <
                                            sharedController
                                                .languages.length;
                                        i++)
                                          GeneralItem(
                                              id: sharedController
                                                  .languages[i].code,
                                              name: sharedController
                                                  .languages[i].name,
                                              imageUrl: "")
                                      ],
                                      hintText: "",
                                      valueChanged: (newLang) {
                                        List<Language> langs =
                                        sharedController.languages
                                            .where((e) =>
                                        e.code == newLang)
                                            .toList();
                                        if (langs.isNotEmpty) {
                                          sharedController
                                              .changeLanguage(langs[0],false);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: flyternSpaceLarge,
                                width: 20,
                              ),
                              SizedBox(
                                width: sharedController
                                    .isSetDeviceLanguageAndCountrySubmitting
                                    .value
                                    ? double.maxFinite
                                    : double.infinity,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      await sharedController
                                          .setDeviceLanguageAndCountry(
                                          true, true);
                                    },
                                    style: getElevatedButtonStyle(context),
                                    child: sharedController
                                        .isSetDeviceLanguageAndCountrySubmitting
                                        .value
                                        ? LoadingAnimationWidget
                                        .prograssiveDots(
                                      color: flyternBackgroundWhite,
                                      size: 16,
                                    )
                                        : Text("continue".tr)),
                              ),
                            ],
                          ))
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
            isMobile: true,
            isGlobal: true,
            countrySelected: (Country? country) {},
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

  Future<void> checkAppVersion() async {
    List? languages = await Devicelocale.preferredLanguages;
    String? locale = await Devicelocale.currentLocale;

    log("checkAppVersion");

    if(locale != null){
      if(locale.toLowerCase().contains('ar')){
        sharedController
            .changeLanguage(Language(name: "عربي", code: "ar"),true);
      } else{
        sharedController
            .changeLanguage(Language(name: "English", code: "en"),true);
      }
    }

    if(languages != null){
      if(languages.isNotEmpty){
        log(languages[0]);
      }
    }

    log(locale!);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    log("checkAppVersion");
    log(appName);
    log(packageName);
    log(version);
    log(buildNumber);
  }
}
