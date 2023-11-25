import 'package:flutter/material.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:ionicons/ionicons.dart';

class FlightTypeTab extends StatelessWidget {

  final IconData icon;
  final String label;
  final GestureTapCallback onPressed;
  final bool isSelected;

    FlightTypeTab({super.key,
      required this.onPressed,
      required this.icon,
      required this.label,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(
            horizontal: flyternSpaceExtraSmall,
            vertical  : flyternSpaceSmall),
        decoration: BoxDecoration(
          color: isSelected
              ? flyternSecondaryColor
              : flyternBackgroundWhite,
          boxShadow: flyternContainerShadow,
          borderRadius: BorderRadius.circular(
              flyternBorderRadiusExtraSmall),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                color: isSelected
                    ? flyternBackgroundWhite
                    : flyternGrey60,
                size: flyternFontSize16),
            Expanded(
              child:FittedBox(
                fit: BoxFit.scaleDown,
                child:  Text(label,
                  style: TextStyle(
                    color: isSelected
                        ? flyternBackgroundWhite
                        : flyternGrey60,
                  ),)
              ),
            )
          ],
        ),
      ),
    );
  }
}
