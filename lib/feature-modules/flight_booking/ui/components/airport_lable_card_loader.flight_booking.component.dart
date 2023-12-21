import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
 import 'package:shimmer/shimmer.dart';

class FlightAirportLabelCardLoader extends StatelessWidget {

  int sideNumber;
  FlightAirportLabelCardLoader({super.key,
      required this.sideNumber, });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.start,
      crossAxisAlignment:sideNumber==1? WrapCrossAlignment.start: WrapCrossAlignment.end,
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
            height: 20,
            width: 60,
          ),
        ),
        addVerticalSpace(flyternSpaceExtraSmall),
        Shimmer.fromColors(
          baseColor: flyternBackgroundWhite,
          highlightColor: flyternGrey20,
          child: Container(
            decoration: BoxDecoration(
              color:flyternGrey10,
              borderRadius:
              BorderRadius.circular(flyternBorderRadiusExtraSmall),
            ),
            height: 60,
            width: 80,
          ),
        ),
        addVerticalSpace(flyternSpaceExtraSmall),

        Shimmer.fromColors(
          baseColor: flyternBackgroundWhite,
          highlightColor: flyternGrey20,
          child: Container(
            decoration: BoxDecoration(
              color:flyternGrey10,
              borderRadius:
              BorderRadius.circular(flyternBorderRadiusExtraSmall),
            ),
            height: 20,
            width: 50,
          ),
        ),
      ],
    );
  }
}
