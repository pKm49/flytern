import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';

class DataCapsuleCard extends StatelessWidget {
  String label;
  int theme;

    DataCapsuleCard({super.key, required this.label,required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: flyternSmallPaddingHorizontal.copyWith(top: flyternSpaceExtraSmall,bottom: flyternSpaceExtraSmall),
      decoration: BoxDecoration(
        color: theme==1?flyternPrimaryColorBg:theme==2?flyternSecondaryColorBg:flyternGuideRedLight,
        borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
      ),
      child: Center(
        child: Text(
          label,style: getLabelLargeStyle(context).copyWith(color:
        theme==1?flyternPrimaryColor :theme==2?flyternSecondaryColor :flyternGuideRed ),
        ),
      ),
    );
  }
}
