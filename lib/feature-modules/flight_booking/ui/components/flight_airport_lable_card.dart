import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightAirportLabelCard extends StatelessWidget {

  String topLabel;
  String midLabel;
  String bottomLabel;
  int sideNumber;
    FlightAirportLabelCard({super.key,
      required this.topLabel,
      required this.sideNumber,
      required this.midLabel, required this.bottomLabel});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.start,
      crossAxisAlignment:sideNumber==1? WrapCrossAlignment.start: WrapCrossAlignment.end,
      children: [
        Text(
           topLabel,
          textAlign: sideNumber==1?TextAlign.start:TextAlign.end,
          style: getLabelLargeStyle(context).copyWith(
              color: flyternGrey40,
              fontWeight: FontWeight.  w400),
        ),
        addVerticalSpace(flyternSpaceExtraSmall),
        Text(midLabel,
            textAlign: sideNumber==1?TextAlign.start:TextAlign.end,

            style: getHeadlineLargeStyle(context)
                .copyWith(fontSize: flyternFontSize24 * 1.5)),
        addVerticalSpace(flyternSpaceExtraSmall),
        Text(bottomLabel,
            style: getHeadlineMediumStyle(context),
            textAlign: sideNumber==1?TextAlign.start:TextAlign.end,
            maxLines: 2),
      ],
    );
  }
}
