import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightSearchResultPage extends StatefulWidget {
  const FlightSearchResultPage({super.key});

  @override
  State<FlightSearchResultPage> createState() => _FlightSearchResultPageState();
}

class _FlightSearchResultPageState extends State<FlightSearchResultPage> {
  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("search_results".tr),
        actions: [
          Icon(Ionicons.create_outline),
          addHorizontalSpace(flyternSpaceMedium),
        ],
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Column(
          children: [
            addVerticalSpace(flyternSpaceMedium),
            Container(
              padding: flyternMediumPaddingHorizontal,
              child: Text('KWI-DXB - 04-06 July, 23 - Round Trip - 1 Adults 1 Child',style: getLabelLargeStyle(context).copyWith(fontWeight: flyternFontWeightLight,color: flyternGrey40)),
            ),
            addVerticalSpace(flyternSpaceSmall),
            Divider()
          ],
        ),
      ),
    );
  }
}
