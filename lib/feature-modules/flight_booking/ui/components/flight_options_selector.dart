import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightOptionsSelector extends StatelessWidget {
  const FlightOptionsSelector({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight*.85,
      width: screenwidth,
      padding: flyternLargePaddingAll,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("select_options".tr,
                  style: getHeadlineMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold),textAlign: TextAlign.center),
              Text("done".tr,
                  style: getHeadlineMediumStyle(context).copyWith(
                      color: flyternPrimaryColor, fontWeight: flyternFontWeightBold),textAlign: TextAlign.center),
            ],
          ),
          addVerticalSpace(flyternSpaceLarge),
          Text("passengers".tr,
              style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold )),
          addVerticalSpace(flyternSpaceLarge),
          Text("cabin_class".tr,
              style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold )),
          addVerticalSpace(flyternSpaceMedium),
        ],
      ),
    );
  }

}
