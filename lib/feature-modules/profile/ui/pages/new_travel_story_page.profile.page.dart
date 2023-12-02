import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/travel_story.profile.controller.dart';
import 'package:flytern/feature-modules/profile/models/user-travelstory.profile.model.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/photo_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mime/mime.dart';
import 'package:video_player/video_player.dart';

class ProfileNewTravelStoryPage extends StatefulWidget {
  const ProfileNewTravelStoryPage({super.key});

  @override
  State<ProfileNewTravelStoryPage> createState() =>
      _ProfileNewTravelStoryPageState();
}

class _ProfileNewTravelStoryPageState extends State<ProfileNewTravelStoryPage> {

  String fileType = "";
  double rating = 3.0;
  final travelStoryController = Get.find<TravelStoryController>();
  late File mediaFile;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String imageFileUrl = "";
  TextEditingController titleController = TextEditingController();
  TextEditingController tripSummaryController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
        ASSETS_AUTH_BG
    );
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    return Obx(
      ()=> Scaffold(
          appBar: AppBar(
            title: Text("add_testimonial".tr),
            elevation: 0.5,
          ),
          body: Container(
            width: screenwidth,
            height: screenheight,
            color: flyternGrey10,
            child: ListView(
              children: [
                Padding(
                  padding: flyternLargePaddingAll,
                  child: InkWell(
                    onTap: () {
                      openSourceSelector(context);
                    },
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: flyternSecondaryColor,
                      dashPattern: [6, 6, 6, 6],
                      radius:
                      Radius.circular(flyternBorderRadiusSmall),
                      strokeWidth: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(
                            flyternBorderRadiusSmall)),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: fileType == "",
                              child: Container(
                                width: screenwidth - (flyternSpaceLarge * 2),
                                padding: flyternLargePaddingAll,
                                color: flyternSecondaryColorBg,
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(ASSETS_FILE_UPLOAD_ICON,
                                        width: screenwidth * .2),
                                    addVerticalSpace(flyternSpaceLarge),
                                    Text("upload_image_video".tr,
                                        style: getBodyMediumStyle(context))
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: fileType == "image" && imageFileUrl != "",
                              child: Image.memory(
                                base64Decode(imageFileUrl),
                                height: 200,
                                width: screenwidth - (flyternSpaceLarge * 2),
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 200,
                                    width: screenwidth - (flyternSpaceLarge * 2),
                                    clipBehavior: Clip.hardEdge,
                                    child: Icon(Icons.camera_alt_outlined,
                                        size: screenwidth * .08,
                                        color: flyternGrey40),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                            Visibility(
                              visible: fileType == "video",
                              child: Container(
                                  width: screenwidth - (flyternSpaceLarge * 2),
                                  color: flyternSecondaryColorBg,
                                  height: 200,
                                  child: AspectRatio(
                                    aspectRatio: 9 / 16,
                                    // Use the VideoPlayer widget to display the video.
                                    child: VideoPlayer(_controller),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: fileType != "",
                  child: Padding(
                    padding: flyternLargePaddingAll,
                    child: InkWell(
                      onTap: () {
                        openSourceSelector(context);
                      },
                      child: Text("upload_image_video".tr,
                          textAlign: TextAlign.center,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternSecondaryColor,
                              decoration: TextDecoration.underline)),
                    ),
                  ),
                ),

                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  color: flyternBackgroundWhite,
                  child: Text("give_star_rating".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          fontWeight: flyternFontWeightBold)),
                ),

                Container(
                  padding: flyternLargePaddingAll.copyWith(top: 0),
                  width: screenwidth,
                  color: flyternBackgroundWhite,
                  child: Row(
                    children: [
                      for(var i = 1; i <= 5; i++)
                        InkWell(
                          onTap: () {
                            rating = double.parse(i.toString());
                            setState(() {

                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: flyternSpaceSmall),
                            child: Icon(
                                rating < i + 1 && rating > i ?
                                Ionicons.star_half :
                                i <= rating.round() ? Ionicons.star :
                                Ionicons.star_outline,
                                color:
                                i <= rating.round() ?
                                flyternAccentColor : flyternGrey40),
                          ),
                        ),

                    ],
                  ),),
                Container(
                    padding: flyternLargePaddingAll.copyWith(top: 0),
                    width: screenwidth,
                    color: flyternBackgroundWhite,
                    child: Divider()),
                Container(
                  padding: flyternLargePaddingAll.copyWith(top: 0),
                  width: screenwidth,
                  color: flyternBackgroundWhite,
                  child: Text("share_your_review".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          fontWeight: flyternFontWeightBold)),
                ),
                Container(
                    padding: flyternLargePaddingAll.copyWith(top: 0),
                    width: screenwidth,
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                      controller: titleController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "enter_title".tr,
                        ))),

                Container(
                    padding: flyternLargePaddingAll.copyWith(top: 0),
                    width: screenwidth,
                    color: flyternBackgroundWhite,
                    child: TextFormField(
                        keyboardType: TextInputType.name,
                        minLines: 3,
                        controller: tripSummaryController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          labelText: "enter_review".tr,
                        ))),

                Container(
                  height: 60 + (flyternSpaceSmall * 2),
                  width: screenwidth,
                )
              ],
            ),
          ),
          bottomSheet: Container(
            width: screenwidth,
            color: flyternBackgroundWhite,
            height: 60 + (flyternSpaceSmall * 2),
            padding: flyternLargePaddingAll.copyWith(
                top: flyternSpaceSmall, bottom: flyternSpaceSmall),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(style: getElevatedButtonStyle(context),
                    onPressed: () {
                      handleSubmission();
                    },
                    child:travelStoryController.isSubmitting.value
                        ?LoadingAnimationWidget.prograssiveDots(
                      color: flyternBackgroundWhite,
                      size: 16,
                    )
                        :  Text("submit".tr)),
              ),
            ),
          )
      ),
    );
  }


  void openSourceSelector(context) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return PhotoSelector(
              photoSelected: (File? selectedMediaFile) {
                if (selectedMediaFile != null) {
                  mediaFile = selectedMediaFile;
                  String? mimeStr = lookupMimeType(mediaFile.path);
                  if (mimeStr != null) {
                    fileType = mimeStr.split('/')[0];

                    if (fileType == "video") {
                      initializeVideo();
                    } else {
                      Uint8List imageBytes = mediaFile.readAsBytesSync();
                      imageFileUrl = base64Encode(imageBytes);
                    }
                    setState(() {

                    });
                  }
                }
                setState(() {});
              }, isVideosAllowed: true

          );
        });
  }

  initializeVideo() {
    _controller.pause();
    _controller.dispose();
    _controller = VideoPlayerController.file(
        mediaFile
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _initializeVideoPlayerFuture.then((_) =>
        setState(() {

        }));
  }

  void handleSubmission() {
    FocusManager.instance.primaryFocus?.unfocus();
    if ((titleController.text != "" || tripSummaryController.text != "") ||
        fileType != "") {
       travelStoryController.addTravelStory(UserTravelStory(
          tripSummary: tripSummaryController.text,
          firstName: "",
          fileUrl: "",
          status: "",
          bookingRef: "",
          fileType: fileType,
          profileUrl: "",
          id: -1,
          title: titleController.text,
          createdOn: DefaultInvalidDate,
          rating: rating.toString()),fileType == ""?null:mediaFile);
    }
  }
}
