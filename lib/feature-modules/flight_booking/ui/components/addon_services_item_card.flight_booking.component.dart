import 'package:flutter/material.dart';
   import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';

class FlightAddonServicesItemCard extends StatelessWidget {

  bool isComplete;
  String ImageUrl;
  String keyLabel;
  String valueLabel;
  final GestureTapCallback onPressed;

  FlightAddonServicesItemCard({
    super.key, required this.ImageUrl,
    required this.isComplete,
    required this.keyLabel,
    required this.onPressed,
    required this.valueLabel});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      color: flyternBackgroundWhite,
      padding: flyternMediumPaddingAll,
      width: screenwidth ,
      child: Wrap(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                  child: Image.asset(ImageUrl)),
              addHorizontalSpace(flyternSpaceMedium),
              Text(keyLabel,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80),),
              // addHorizontalSpace(flyternSpaceSmall),
              // Icon(Ionicons.checkmark_circle_outline,
              // size: flyternFontSize20,
              //   color: isComplete?flyternGuideGreen:flyternGrey20,
              // ),
              Expanded(child: Container()),
              Expanded(
                  flex: 5,
                  child:  InkWell(
                    onTap: onPressed,
                    child: Container(
                      decoration: flyternBorderedContainerSmallDecoration.copyWith(
                          border: Border.all(color: flyternSecondaryColor, width: .5)),
                      padding: flyternSmallPaddingAll,
                      child: Text(valueLabel,
                        textAlign: TextAlign.center,
                        style: getBodyMediumStyle(context).copyWith(color: flyternSecondaryColor),
                    )),
                  )
              )
            ],
          )
        ],
      )
    );
  }
}
