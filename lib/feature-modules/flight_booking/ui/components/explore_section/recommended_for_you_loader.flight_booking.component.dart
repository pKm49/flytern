import 'package:flutter/material.dart';
  import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
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
