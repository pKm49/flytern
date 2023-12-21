import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class FlightDetailsAddonServiceCard extends StatelessWidget {
  String ImageUrl;
  String keyLabel;
  String valueLabel;
  String value;

    FlightDetailsAddonServiceCard({super.key, required this.ImageUrl, required this.keyLabel,
      required this.value,
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
                  flex: 1,
                  child: Image.asset(ImageUrl)),
              addHorizontalSpace(flyternSpaceMedium),
              Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment:

                    MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(keyLabel,style: getBodyMediumStyle(context).copyWith(color: flyternGrey40),),
                      addVerticalSpace(flyternSpaceExtraSmall),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                          Text(valueLabel,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80),) ,
                         Expanded(child:  Text(value,
                           textAlign: TextAlign.end,
                           style: getBodyMediumStyle(context).copyWith(color: flyternGrey80),),)
                       ],
                     )

                    ],
                  ))
            ],
          )
        ],
      )
    );
  }
}
