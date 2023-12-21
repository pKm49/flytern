import 'package:flutter/material.dart';
 import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
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
