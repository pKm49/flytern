import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/recommended_item_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';

class RecommendedForYouContainer extends StatelessWidget {

  List <RecommendedPackage> recommendedPackages;

  RecommendedForYouContainer({super.key, required this.recommendedPackages});

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

    return Container(
        width: screenwidth,
        height: screenwidth * .7,
        padding: flyternMediumPaddingHorizontal,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: recommendedPackages.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(right: flyternSpaceMedium),
                child:FlightRecommendedItemCard(
                    imageUrl: recommendedPackages[index].url,
                    title: recommendedPackages[index].name,
                    rating: recommendedPackages[index].ratings
                ),
              );
            }
        ));
  }
}
