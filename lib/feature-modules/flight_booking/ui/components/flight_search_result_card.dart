import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_data_capsule_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';

class FlightSearchResultCard extends StatelessWidget {
  const FlightSearchResultCard({super.key});

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      decoration: flyternBorderedContainerSmallDecoration,
      padding: flyternMediumPaddingAll,
      width: screenwidth - (flyternSpaceLarge*2),
      margin: flyternLargePaddingHorizontal,
      child: Wrap(
        children: [
          Row(
            children: [
              Image.asset(ASSETS_FLIGHT_1_SAMPLE,width: screenwidth*.25),
              Expanded(child: Container()),
              FlightDataCapsuleCard(
                label: "2 Stops",
                theme: 2,
              ),
              addHorizontalSpace(flyternSpaceSmall),
              FlightDataCapsuleCard(
                label: "Refundable",
                theme: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
