import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightAddonServicesItemCard extends StatelessWidget {

  String ImageUrl;
  String keyLabel;
  String valueLabel;
  String route;

  FlightAddonServicesItemCard({super.key, required this.ImageUrl,
    required this.route, required this.keyLabel,
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
              Expanded(
              flex: 5,
                  child: Text(keyLabel,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80),),
              ),
              Expanded(
                  flex: 5,
                  child:  InkWell(
                    onTap: (){
                      Get.toNamed(route);
                    },
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
