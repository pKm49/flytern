import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_data_capsule_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightSearchResultCard extends StatelessWidget {
  const FlightSearchResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      decoration: flyternBorderedContainerSmallDecoration,
      padding: flyternMediumPaddingAll,
      width: screenwidth - (flyternSpaceLarge * 2),
      margin: flyternLargePaddingHorizontal,
      child: Wrap(
        runSpacing: flyternSpaceLarge,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(ASSETS_FLIGHT_1_SAMPLE, width: screenwidth * .2),
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: FlightAirportLabelCard(
                topLabel: "Istanbul, TR",
                midLabel: "IST",
                bottomLabel: "08:00 AM",
                    sideNumber: 1,
              )),
              Padding(
                padding: flyternSmallPaddingHorizontal,
                child: Image.asset(ASSETS_FLIGHT_CHART_ICON,width: screenwidth*.35, ),
              ),
              Expanded(
                  child: FlightAirportLabelCard(
                    topLabel: "Istanbul, TR",
                    midLabel: "IST",
                    bottomLabel: "08:00 AM",
                    sideNumber: 2,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: FlightAirportLabelCard(
                topLabel: "Istanbul, TR",
                midLabel: "IST",
                bottomLabel: "08:00 AM",
                    sideNumber: 1,
              )),
              Padding(
                padding: flyternSmallPaddingHorizontal,
                child: Image.asset(ASSETS_FLIGHT_CHART_ICON,width: screenwidth*.35, ),
              ),
              Expanded(
                  child: FlightAirportLabelCard(
                    topLabel: "Istanbul, TR",
                    midLabel: "IST",
                    bottomLabel: "08:00 AM",
                    sideNumber: 2,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (var i = 0; i < (screenwidth -  (screenwidth/1.3)); i++)
                Container(
                  color: i % 2 == 0
                      ? flyternGrey40
                      : Colors.transparent,
                  height: 1,
                  width: 3,
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("AED 15,000",style: getHeadlineMediumStyle(context).copyWith(
                  fontWeight: flyternFontWeightBold,
                  color: flyternSecondaryColor),),
              Expanded(child: Container()),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(
                            horizontal: flyternSpaceLarge,
                            vertical: flyternSpaceSmall)),
                  ),
                    onPressed: ()   {
                    }, child: Text("select".tr)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
