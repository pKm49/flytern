import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/models/popular_destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/travel_story.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.flight_booking.component.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';

class TravelStoriesContainer extends StatelessWidget {
  List<TravelStory> travelStories;

  TravelStoriesContainer({super.key, required this.travelStories});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      color: flyternBackgroundWhite,
      child: Wrap(
        children: [
          for (var i = 0;
              i < (travelStories.length > 5 ? 5 : travelStories.length);
              i++)
            Container(
              decoration: BoxDecoration(
                  border: i == (travelStories.length - 1)
                      ? null
                      : flyternDefaultBorderBottomOnly),
              child: TravelStoriesItemCard(
                createdOn: DefaultInvalidDate,
                title: "",
                status: "",
                previewImgUrl: travelStories[i].previewImgUrl,
                profilePicUrl: travelStories[i].profileUrl,
                name: travelStories[i].name,
                ratings: travelStories[i].ratings,
                description: travelStories[i].shortDesc,
                imageUrl: travelStories[i].url,
                fileType: travelStories[i].urlType,
              ),
            ),
        ],
      ),
    );
  }
}
