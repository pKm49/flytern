import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/activity_booking/models/option.activity_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class ActivityOptionInfo extends StatelessWidget {

  ActivityOption activityOption;
  ActivityOptionInfo({super.key, required this.activityOption});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: screenheight*.8,
      color: flyternBackgroundWhite,
      child: ListView(
        children: [
          Container(
            padding: flyternLargePaddingAll,
            color: flyternBackgroundWhite,
            child: Text("description".tr,
                style: getBodyMediumStyle(context).copyWith(
                    color: flyternGrey80,
                    fontWeight: flyternFontWeightBold)),
          ),
          Container(
            padding: flyternLargePaddingHorizontal,
            color: flyternBackgroundWhite,
            child: Html(
              data: activityOption.optionDescription ,
            ),
          ),
          Container(
            color: flyternBackgroundWhite,
            padding: flyternLargePaddingAll,
            child: Text("cancellation_policy".tr,
                style: getBodyMediumStyle(context).copyWith(
                    color: flyternGrey80,
                    fontWeight: flyternFontWeightBold)),
          ),
          Container(
            padding: flyternLargePaddingHorizontal,
            color: flyternBackgroundWhite,
            child: Html(
              data: activityOption.cancellationPolicy ,
            ),
          ),
          Container(
            padding: flyternLargePaddingHorizontal,
            color: flyternBackgroundWhite,
            child: Html(
              data: activityOption.childPolicyDescription ,
            ),
          ),
        ],
      ),
    );
  }

}
