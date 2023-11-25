import 'package:flutter/material.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
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
