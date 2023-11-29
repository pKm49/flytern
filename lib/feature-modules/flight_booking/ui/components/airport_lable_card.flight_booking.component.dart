import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class FlightAirportLabelCard extends StatelessWidget {
  String topLabel;
  String midLabel;
  String bottomLabel;
  int sideNumber;

  FlightAirportLabelCard(
      {super.key,
      required this.topLabel,
      required this.sideNumber,
      required this.midLabel,
      required this.bottomLabel});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.start,
      crossAxisAlignment:
          sideNumber == 1 ? WrapCrossAlignment.start : WrapCrossAlignment.end,
      children: [
        Row(
          children: [
            Visibility(
              visible: topLabel == "to".tr,
              child: Icon(
                Icons.flight_land_outlined,
                color: flyternSecondaryColor,
                size: flyternFontSize16,
              ),
            ),
            Visibility(
                visible: topLabel == "to".tr,
                child: addHorizontalSpace(flyternSpaceSmall)),
            Text(
              topLabel,
              textAlign: sideNumber == 1 ? TextAlign.start : TextAlign.end,
              style: getLabelLargeStyle(context)
                  .copyWith(color: flyternGrey40, fontWeight: FontWeight.w400),
            ),
            Visibility(
                visible: topLabel == "from".tr,
                child: addHorizontalSpace(flyternSpaceSmall)),
            Visibility(
              visible: topLabel == "from".tr,
              child: Icon(
                Icons.flight_takeoff_outlined,
                color: flyternSecondaryColor,
                size: flyternFontSize16,
              ),
            ),
          ],
        ),
        addVerticalSpace(flyternSpaceExtraSmall),
        Text(midLabel,
            textAlign: sideNumber == 1 ? TextAlign.start : TextAlign.end,
            style: getHeadlineLargeStyle(context)
                .copyWith(fontSize: flyternFontSize24 * 1.5)),
        Text(bottomLabel,
            style: getBodyMediumStyle(context),
            textAlign: sideNumber == 1 ? TextAlign.start : TextAlign.end,
            maxLines: 2),
      ],
    );
  }
}
