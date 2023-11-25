import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';

class SelectableTilePill extends StatelessWidget {

  String label;
  bool isSelected;
  int themeNumber;
  final GestureTapCallback onPressed;

  SelectableTilePill({super.key, required this.label, required this.isSelected, required this.themeNumber,
  required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: flyternSmallPaddingAll,
        decoration: BoxDecoration(
          color: isSelected?themeNumber==1?flyternPrimaryColor:flyternSecondaryColor: flyternBackgroundWhite,
          border: Border.all(color: isSelected?themeNumber==1?flyternPrimaryColor:flyternSecondaryColor: flyternGrey60
              , width: .2),
          borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
        ),
        child: Text(label,style: getBodyMediumStyle(context).copyWith(color:
        isSelected? flyternBackgroundWhite:flyternGrey60 )),
      ),
    );
  }

}
