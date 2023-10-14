import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:shimmer/shimmer.dart';

class RecommendedForYouLoader extends StatelessWidget {
  const RecommendedForYouLoader({super.key});

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
            Shimmer.fromColors(
              baseColor: flyternBackgroundWhite,
              highlightColor: flyternGrey20,
              child: Container(
                decoration: BoxDecoration(
                    color:flyternGrey10,
                    borderRadius:
                  BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                  width: screenwidth * .7,
                  height: screenwidth * .7,
              ),
            ),
            addHorizontalSpace(flyternSpaceMedium),
            Shimmer.fromColors(
              baseColor: flyternBackgroundWhite,
              highlightColor: flyternGrey20,
              child: Container(
                decoration: BoxDecoration(
                  color:flyternGrey10,
                  borderRadius:
                  BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                width: screenwidth * .7,
                height: screenwidth * .7,
              ),
            ),
            addHorizontalSpace(flyternSpaceMedium),
            Shimmer.fromColors(
              baseColor: flyternBackgroundWhite,
              highlightColor: flyternGrey20,
              child: Container(
                decoration: BoxDecoration(
                  color:flyternGrey10,
                  borderRadius:
                  BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                width: screenwidth * .7,
                height: screenwidth * .7,
              ),
            ),
          ],
        ));

  }
}
