import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/auth/services/selector_page_curve_clipper.auth.service.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:video_player/video_player.dart';

class AuthSelectorPage extends StatefulWidget {
  const AuthSelectorPage({super.key});

  @override
  State<AuthSelectorPage> createState() => _AuthSelectorPageState();
}

class _AuthSelectorPageState extends State<AuthSelectorPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    Uri uri = Uri.parse(ASSETS_BG_URL);
    _controller = VideoPlayerController.networkUrl(uri);
    _initializeVideoPlayerFuture =  _controller.initialize();
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
      body: Container(
        height: screenheight,
        width: screenwidth,
        padding: EdgeInsets.only(top: flyternSpaceLarge*2),
        color: flyternBackgroundWhite,
        child:Stack(
          children: [
            
            Container(
              width: screenwidth,
              padding: EdgeInsets.only(top: flyternSpaceLarge*2),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  image:   const DecorationImage(
                    image:  AssetImage(ASSETS_VIDEO_BG),
                    fit: BoxFit.cover,
                  ),
                ),
              height: screenheight ,
                child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return AspectRatio(
                        aspectRatio: 9/16,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return Image.asset(ASSETS_VIDEO_BG,width: screenwidth);
                    }
                  },
                )
            ),

            Container(
              height: screenheight,
              width: screenwidth,
              child: Column(
                children: [
                  Container(
                    width: screenwidth,
                    height: (screenwidth*0.6313645621181263).toDouble(),
                    child: CustomPaint(
                      size: Size(screenwidth, (screenwidth*0.6313645621181263).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: AuthSelectorCurveClipper(),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            addVerticalSpace(flyternSpaceLarge*2),
                            Image.asset(ASSETS_NAMELOGO,width: screenwidth*.6)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: flyternLargePaddingAll*2.5,
                    width: screenwidth,
                        child: Wrap(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child:   Text("sign_in".tr),
                                onPressed: () async {

                                  Get.toNamed(Approute_login,
                                      arguments: [true]);
                                },
                                style: getElevatedButtonStyle(context).copyWith(
                                    backgroundColor: MaterialStateProperty.all<Color>(flyternSecondaryColor)
                                ),),
                            ),
                            SizedBox(height: flyternSpaceMedium,width: 20,),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(style: getElevatedButtonStyle(context),
                                  onPressed: () async {
                                    Get.toNamed(Approute_registerPersonalData);
                                  }, 
                                  child:Text("create_account".tr )),
                            ),
                            const SizedBox(height: flyternSpaceLarge,width: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "continue_as".tr,
                                  style: getBodyMediumStyle(context).copyWith(color: flyternBackgroundWhite),
                                ),
                                addHorizontalSpace(flyternSpaceSmall),
                                InkWell(
                                  onTap: (){
                                    Get.offAllNamed(Approute_landingpage);
                                  },
                                  child: Text(
                                      "guest_user".tr,
                                    style: getBodyMediumStyle(context).copyWith(
                                        fontWeight: flyternFontWeightBold,
                                    color: flyternSecondaryColor),

                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
