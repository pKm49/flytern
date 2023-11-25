import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class ActivityListCardLoader extends StatelessWidget {

  ActivityListCardLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: flyternBackgroundWhite,
      ),
      padding: flyternMediumPaddingAll,
      child: Row(
        children: [
          Container(
              width: screenwidth * .25,
              height: screenwidth * .25,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
              ),
              clipBehavior: Clip.hardEdge,
              child: Shimmer.fromColors(
                baseColor: flyternBackgroundWhite,
                highlightColor: flyternGrey20,
                child: Container(
                  decoration: BoxDecoration(
                    color:flyternGrey10,
                    borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  ),
                  width: screenwidth * .25 ,
                  height: screenwidth * .25 ,
                ),
              ),),
          addHorizontalSpace(flyternSpaceMedium),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  height: 20 ,
                ),
              ),
              addVerticalSpace(flyternSpaceSmall),
              Shimmer.fromColors(
                baseColor: flyternBackgroundWhite,
                highlightColor: flyternGrey20,
                child: Container(
                  decoration: BoxDecoration(
                    color:flyternGrey10,
                    borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  ),
                  height: 20 ,
                ),
              ),
              addVerticalSpace(flyternSpaceSmall),
              Shimmer.fromColors(
                baseColor: flyternBackgroundWhite,
                highlightColor: flyternGrey20,
                child: Container(
                  decoration: BoxDecoration(
                    color:flyternGrey10,
                    borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  ),
                  height: 20 ,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
