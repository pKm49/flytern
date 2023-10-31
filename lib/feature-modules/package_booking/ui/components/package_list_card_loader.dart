import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class PackageListCardLoader extends StatelessWidget {


    PackageListCardLoader({
      super.key
    });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      decoration:  BoxDecoration(
        color: flyternBackgroundWhite,
      ),
      padding: flyternMediumPaddingAll,
      child: Row(
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
              width: screenwidth*.25, height:  screenwidth*.25,
            ),
          ),
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
                  ),  height:  30,
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
                  ),  height:  30,
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
                  ),  height:  30,
                ),
              ),
            ],
          ))

        ],
      ),
    );
  }
}
