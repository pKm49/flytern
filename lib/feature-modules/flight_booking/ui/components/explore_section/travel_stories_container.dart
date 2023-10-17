import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/travel_story.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';

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
          for (var i = 0; i < travelStories.length; i++)
            Container(
              decoration: BoxDecoration(border:
              i==(travelStories.length-1)?null:
              flyternDefaultBorderBottomOnly),
              child: TravelStoriesItemCard(
                createdOn: DefaultInvalidDate,
                title: "",
                status: "",
                profilePicUrl: travelStories[i].profileUrl,
                name: travelStories[i].name,
                ratings:travelStories[i].ratings,
                description: travelStories[i].shortDesc,
                imageUrl: travelStories[i].url,
              ),
            ),
        ],
      ),
    );
  }
}
