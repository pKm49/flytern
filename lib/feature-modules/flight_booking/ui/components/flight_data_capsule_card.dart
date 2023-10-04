import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';

class FlightDataCapsuleCard extends StatelessWidget {
  String label;
  int theme;

    FlightDataCapsuleCard({super.key, required this.label,required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: flyternSmallPaddingAll,
      decoration: BoxDecoration(
        color: theme==1?flyternPrimaryColorBg:flyternSecondaryColorBg,
        borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
      ),
      child: Center(
        child: Text(
          label,style: getLabelLargeStyle(context).copyWith(color: theme ==1?flyternPrimaryColor:flyternSecondaryColor),
        ),
      ),
    );
  }
}
