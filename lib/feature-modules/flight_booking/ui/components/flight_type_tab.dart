import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:ionicons/ionicons.dart';

class FlightTypeTab extends StatelessWidget {

  final IconData icon;
  final String label;
  final GestureTapCallback onPressed;
  final int selectedTab;
  final int index;

    FlightTypeTab({super.key,
      required this.onPressed,
      required this.icon,
      required this.index,
      required this.label,
      required this.selectedTab});

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
          color: selectedTab == index
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
                color: selectedTab == index
                    ? flyternBackgroundWhite
                    : flyternGrey60,
                size: flyternFontSize20),
            Text(label,
              style: TextStyle(
                color: selectedTab == index
                    ? flyternBackgroundWhite
                    : flyternGrey60,
              ),)
          ],
        ),
      ),
    );
  }
}
