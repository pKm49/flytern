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

class FlightDetailsItineraryCard extends StatelessWidget {
  const FlightDetailsItineraryCard({super.key});

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(ASSETS_FLIGHT_1_SAMPLE, width: screenwidth * .2),

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
          Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Flight No.",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey40,
                                  fontWeight: FontWeight.  w400),
                            ),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text(
                              "PF-134",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cabin Class",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey40,
                                  fontWeight: FontWeight.  w400),
                            ),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text(
                              "Economy",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Flight Date",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey40,
                                  fontWeight: FontWeight.  w400),
                            ),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text(
                              "July 4, 2023",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                addVerticalSpace(flyternSpaceLarge),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Airline",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey40,
                                  fontWeight: FontWeight.  w400),
                            ),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text(
                              "Emirates",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Baggage",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey40,
                                  fontWeight: FontWeight.  w400),
                            ),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text(
                              "20kg",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Duration",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey40,
                                  fontWeight: FontWeight.  w400),
                            ),
                            addVerticalSpace(flyternSpaceExtraSmall),
                            Text(
                              "2h 35m",
                              style: getLabelLargeStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
