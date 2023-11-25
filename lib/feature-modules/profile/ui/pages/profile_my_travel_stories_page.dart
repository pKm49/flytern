import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/feature-modules/profile/controllers/travel_story_controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class ProfileMyTravelStoriesPage extends StatefulWidget {
  const ProfileMyTravelStoriesPage({super.key});

  @override
  State<ProfileMyTravelStoriesPage> createState() =>
      _ProfileMyTravelStoriesPageState();
}

class _ProfileMyTravelStoriesPageState
    extends State<ProfileMyTravelStoriesPage> {
  final travelStoryController = Get.find<TravelStoryController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('my_travel_stories'.tr),
        elevation: 0.5,
      ),
      body: Obx(
            ()=> Container(
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
                visible: travelStoryController.userTravelStories.isEmpty,
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
                    itemCount: travelStoryController.userTravelStories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: screenwidth,
                        decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            border: flyternDefaultBorderBottomOnly
                        ),
                        child: TravelStoriesItemCard(
                        status: travelStoryController.userTravelStories.value[index].status,
                          createdOn: travelStoryController.userTravelStories.value[index].createdOn,
                          title: travelStoryController.userTravelStories.value[index].title,
                          profilePicUrl: travelStoryController.userTravelStories.value[index].profileUrl,
                          name: travelStoryController.userTravelStories.value[index].firstName,
                          ratings: travelStoryController.userTravelStories.value[index].rating,
                          description: travelStoryController.userTravelStories.value[index].tripSummary,
                          imageUrl:travelStoryController.userTravelStories.value[index].fileType == "Image"?
                          travelStoryController.userTravelStories.value[index].fileUrl:"",
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
