import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightAirportLabelCard extends StatelessWidget {

  String topLabel;
  String midLabel;
  String bottomLabel;
    FlightAirportLabelCard({super.key, required this.topLabel, required this.midLabel, required this.bottomLabel});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        Text(
           topLabel,
          style: getLabelLargeStyle(context).copyWith(
              color: flyternGrey40,
              fontWeight: FontWeight.  w400),
        ),
        addVerticalSpace(flyternSpaceExtraSmall),
        Text(midLabel,
            style: getHeadlineLargeStyle(context)
                .copyWith(fontSize: flyternFontSize24 * 1.5)),
        addVerticalSpace(flyternSpaceExtraSmall),
        Text(bottomLabel),
      ],
    );
  }
}
