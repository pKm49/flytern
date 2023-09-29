import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class SharedPrivacyPolicyPage extends StatelessWidget {
  const SharedPrivacyPolicyPage({super.key});

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
          Text("privacy_policy".tr,
              style: getHeadlineMediumStyle(context).copyWith(
                  color: flyternGrey80, fontWeight: flyternFontWeightBold),textAlign: TextAlign.center),
          addVerticalSpace(flyternSpaceLarge),
          Text("lorem_ipsum_description".tr,
              style: getBodyMediumStyle(context).copyWith( )),
          addVerticalSpace(flyternSpaceMedium),
          Text("lorem_ipsum_description".tr,
              style: getBodyMediumStyle(context).copyWith( )),
          Text("lorem_ipsum_description".tr,
              style: getBodyMediumStyle(context).copyWith( )),
        ],
      ),
    );
  }
}
