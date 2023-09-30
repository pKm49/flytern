import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';

class PackageBookingLandingPage extends StatefulWidget {
  const PackageBookingLandingPage({super.key});

  @override
  State<PackageBookingLandingPage> createState() => _PackageBookingLandingPageState();
}

class _PackageBookingLandingPageState extends State<PackageBookingLandingPage> {
  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight,
      width: screenwidth,
      color: flyternGrey20,
      child: Column(
        children: [
          Container(
            width: screenwidth-flyternSpaceLarge*2,
            padding: flyternMediumPaddingHorizontal,
            margin: flyternLargePaddingAll,
            decoration: BoxDecoration(
              color: flyternBackgroundWhite,
              borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
            ),
            child: DropDownSelector(
              titleText: "Select Destination",
              selected:null  ,
              items: [],
              hintText:"Select Destination",
              valueChanged: (newZone) {

              },
            ),
          ),
          Expanded(child: ListView(
            children: [],
          ))
        ],
      ),
    );
  }
}
