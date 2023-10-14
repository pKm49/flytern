import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class ProfileMyTravelStoriesPage extends StatefulWidget {
  const ProfileMyTravelStoriesPage({super.key});

  @override
  State<ProfileMyTravelStoriesPage> createState() => _ProfileMyTravelStoriesPageState();
}

class _ProfileMyTravelStoriesPageState extends State<ProfileMyTravelStoriesPage> {
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
        child: ListView(
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
            Container(
              width: screenwidth,
              height: flyternSpaceSmall,
              color: flyternBackgroundWhite,
            ),
            Container(
              width: screenwidth,
              color: flyternBackgroundWhite,
              child: TravelStoriesItemCard(
                profilePicUrl: ASSETS_USER_1_SAMPLE,
                name: "Andrew Martin",
                ratings: "4.4",
                description: "lorem_ipsum_description".tr,
                imageUrl: ASSETS_TESTIMONIAL_SAMPLE,
              ),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
              child: Divider(),
            ),
            Container(
              width: screenwidth,
              color: flyternBackgroundWhite,
              child: TravelStoriesItemCard(
                profilePicUrl: ASSETS_USER_1_SAMPLE,
                name: "Andrew Martin",
                ratings: "4.4",
                description: "lorem_ipsum_description".tr,
                imageUrl: ASSETS_TESTIMONIAL_SAMPLE,
              ),
            ),

            Container(
              width: screenwidth,
              height: flyternSpaceMedium,
              color: flyternBackgroundWhite,
            ),
          ],
        ),
      ),
    );
  }
}
