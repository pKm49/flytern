import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flytern/core/controllers/core_controller.dart';
import 'package:flytern/core/data/constants/business-specific/valid_languages.dart';
import 'package:flytern/feature-modules/auth/data/constants/ui_constants/language_selector_curve_clipper.dart';
import 'package:flytern/shared/controllers/shared_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CoreLanguageSelector extends StatefulWidget {
  const CoreLanguageSelector({super.key});

  @override
  State<CoreLanguageSelector> createState() => _CoreLanguageSelectorState();
}

class _CoreLanguageSelectorState extends State<CoreLanguageSelector> {

  final sharedController = Get.find<SharedController>();
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String currentLanguageCode = "en";

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
      body: SizedBox(
        height: screenheight,
        width: screenwidth,
        child: Stack(
          children: [
            Container(
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
            SizedBox(
              height: screenheight,
              width: screenwidth,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: flyternLargePaddingAll * 2.5,
                    width: screenwidth,
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              await sharedController.changeLanguage(Lang_English);
                              Get.toNamed(Approute_authSelector);
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        horizontal: flyternSpaceLarge,
                                        vertical: flyternSpaceMedium * 1.2)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        flyternSecondaryColor)),
                            child: const Text("Continue In English"),
                          ),
                        ),
                        const SizedBox(
                          height: flyternSpaceLarge,
                          width: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                await sharedController
                                    .changeLanguage(Lang_Arabic);
                                Get.toNamed(Approute_authSelector);
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                        EdgeInsetsGeometry>(
                                    const EdgeInsets.symmetric(
                                        horizontal: flyternSpaceLarge,
                                        vertical: flyternSpaceMedium * .9)),
                              ),
                              child: const Text("اللغه العربيه")),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    width: screenwidth,
                    height: (screenwidth * 0.6).toDouble(),
                    child: CustomPaint(
                      size: Size(screenwidth, (screenwidth * 0.6).toDouble()),
                      //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: LanguageSelectorCurveClipper(),
                      child: Container(
                        padding: flyternLargePaddingVertical,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            addHorizontalSpace(flyternSpaceLarge),
                            const CountryCodePicker(
                              padding: EdgeInsets.zero,
                              showDropDownButton: true,
                              onChanged: print,
                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                              initialSelection: 'KW',
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
