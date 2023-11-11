import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_option.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
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
