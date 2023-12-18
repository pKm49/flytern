import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:ionicons/ionicons.dart';

class StarRatingSelector extends StatelessWidget {

  bool isSelected;
  int count;
  GestureTapCallback onClick;
  StarRatingSelector({super.key, required this.isSelected, required this.count, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          for(var i=0;i<count;i++)
            Padding(
              padding: const EdgeInsets.only(right:flyternSpaceExtraSmall),
              child: Icon(Ionicons.star, color:isSelected? flyternAccentColor:flyternGrey40,size: flyternFontSize20),
            )

        ],
      ),
    );
  }
}
