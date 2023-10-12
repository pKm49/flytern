import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/recommended_item_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';

class RecommendedForYouContainer extends StatelessWidget {
  const RecommendedForYouContainer({super.key});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
        width: screenwidth,
        height: screenwidth * .7,
        padding: flyternMediumPaddingHorizontal,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            FlightRecommendedItemCard(
                imageUrl: ASSETS_RECOMMENDED_1_SAMPLE,
                title: "Four Seasons Resort Bora Bora",
                rating: 4.4
            ),
            addHorizontalSpace(flyternSpaceMedium),
            FlightRecommendedItemCard(
                imageUrl: ASSETS_RECOMMENDED_1_SAMPLE,
                title: "Four Seasons Resort Bora Bora",
                rating: 4.4
            ),
            addHorizontalSpace(flyternSpaceMedium),
            FlightRecommendedItemCard(
                imageUrl: ASSETS_RECOMMENDED_1_SAMPLE,
                title: "Four Seasons Resort Bora Bora",
                rating: 4.4
            ),
          ],
        ));
  }
}
