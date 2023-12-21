import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';

import 'package:shimmer/shimmer.dart';

class SectionTitleContainerLoader extends StatelessWidget {


  SectionTitleContainerLoader({super.key
  });

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            height: 30,
            width: screenwidth*.4,
          ),
        ),
      ],
    );
  }

}
