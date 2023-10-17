import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class ProfileMyTravelStoriesPage extends StatefulWidget {
  const ProfileMyTravelStoriesPage({super.key});

  @override
  State<ProfileMyTravelStoriesPage> createState() =>
      _ProfileMyTravelStoriesPageState();
}

class _ProfileMyTravelStoriesPageState
    extends State<ProfileMyTravelStoriesPage> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('my_travel_stories'.tr),
        elevation: 0.5,
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: Column(
          children: [
            Padding(
              padding: flyternLargePaddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Text("add_testimonial".tr,
                        style: getBodyMediumStyle(context).copyWith(
                            decoration: TextDecoration.underline,
                            color: flyternTertiaryColor)),
                    onTap: () {
                      Get.toNamed(Approute_profileNewTravelStories);
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: profileController.userTravelStories.isEmpty,
              child: Container(
                width: screenwidth,
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingAll,
                child: Center(
                  child: Text("no_item".tr,style: getBodyMediumStyle(context).copyWith(
                    color: flyternGrey60
                  ),),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: profileController.userTravelStories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: screenwidth,
                      decoration: BoxDecoration(
                          color: flyternBackgroundWhite,
                          border: flyternDefaultBorderBottomOnly
                      ),
                      child: TravelStoriesItemCard(
                        createdOn: profileController.userTravelStories.value[index].createdOn,
                        title: profileController.userTravelStories.value[index].title,
                        profilePicUrl: profileController.userTravelStories.value[index].profileUrl,
                        name: profileController.userTravelStories.value[index].firstName,
                        ratings: profileController.userTravelStories.value[index].rating,
                        description: profileController.userTravelStories.value[index].tripSummary,
                        imageUrl:profileController.userTravelStories.value[index].fileType == "Image"?
                        profileController.userTravelStories.value[index].fileUrl:"",
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
