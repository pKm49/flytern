import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/travel_story_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/photo_selector.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileNewTravelStoryPage extends StatefulWidget {
  const ProfileNewTravelStoryPage({super.key});

  @override
  State<ProfileNewTravelStoryPage> createState() => _ProfileNewTravelStoryPageState();
}

class _ProfileNewTravelStoryPageState extends State<ProfileNewTravelStoryPage> {

  double rating = 3.0;
  final travelStoryController = Get.find<TravelStoryController>();
  late File mediaFile;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                onTap:(){
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
                    child: Container(
                      width: screenwidth-(flyternSpaceLarge*2),
                      padding: flyternLargePaddingAll,
                      color: flyternSecondaryColorBg,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ASSETS_FILE_UPLOAD_ICON,width: screenwidth*.2),
                          addVerticalSpace(flyternSpaceLarge),
                          Text("upload_image_video".tr,style: getBodyMediumStyle(context))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
             padding: flyternLargePaddingAll,
              width: screenwidth,
              color: flyternBackgroundWhite,
              child: Text("give_star_rating".tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold)),
            ),

            Container(
              padding: flyternLargePaddingAll.copyWith(top: 0),
              width: screenwidth,
              color: flyternBackgroundWhite,
              child: Row(
                children: [
                  for(var i=1;i<=5;i++)
                    Padding(
                      padding: const EdgeInsets.only(right:flyternSpaceSmall),
                      child: Icon(
                          rating < i+1 && rating > i ?
                          Ionicons.star_half:
                          i<=rating.round()?Ionicons.star:
                          Ionicons.star_outline,
                          color:
                          i<=rating.round()?
                          flyternAccentColor:flyternGrey40),
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
              child: Text("share_your_review".tr,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold)),
            ),
            Container(
                padding: flyternLargePaddingAll.copyWith(top: 0),
                width: screenwidth,
                color: flyternBackgroundWhite,
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "enter_review".tr,
                    ))),
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
                    Navigator.pop(context);
                  },
                  child: Text("submit".tr)),
            ),
          ),
        )
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
              }
              setState(() {});
            }, isVideosAllowed: true

          );
        });



  }
}
