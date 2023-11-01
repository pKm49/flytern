import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_segment.dart';
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
  FlightSegment flightSegment;
    FlightDetailsItineraryCard({super.key, required this.flightSegment});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      decoration: flyternBorderedContainerSmallDecoration,
      width: screenwidth - (flyternSpaceLarge * 2),
      margin: flyternLargePaddingHorizontal,
      child: Wrap(
        runSpacing: 0,
        children: [
          for(var i=0;i<flightSegment.flightSegmentDetails.length;i++)
          Container(
            width: screenwidth - (flyternSpaceLarge * 2),
            height:flightSegment.flightSegmentDetails[i].stopover !=""||
                flightSegment.flightSegmentDetails[i].layover !=""? 285:250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child:
                Container(
                  padding: flyternMediumPaddingAll ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: FlightAirportLabelCard(
                                topLabel: getTopLabel(
                                    flightSegment.flightSegmentDetails[i].depaturecntry),
                                midLabel: flightSegment.flightSegmentDetails[i].depature,
                                bottomLabel: flightSegment.flightSegmentDetails[i].depaturetime,
                                sideNumber: 1,
                              )),
                          Padding(
                            padding: flyternSmallPaddingHorizontal,
                            child: Image.asset(ASSETS_FLIGHT_CHART_ICON,width: screenwidth*.35, ),
                          ),
                          Expanded(
                              child: FlightAirportLabelCard(
                                topLabel: getTopLabel(
                                    flightSegment.flightSegmentDetails[i].arrivalcntry),
                                midLabel: flightSegment.flightSegmentDetails[i].arrival,
                                bottomLabel: flightSegment.flightSegmentDetails[i].arrivaltime,
                                sideNumber: 2,
                              ))
                        ],
                      ),
                      addVerticalSpace(flyternSpaceMedium),
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
                      addVerticalSpace(flyternSpaceMedium),
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
                                          flightSegment.flightSegmentDetails[i].flightNumber,
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
                                          flightSegment.flightSegmentDetails[i].cabin,
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
                                          flightSegment.flightSegmentDetails[i].depaturedt,
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
                                          flightSegment.flightSegmentDetails[i].flightName,
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
                                          flightSegment.flightSegmentDetails[i].duration,
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
                      ),
                    ],
                  ),
                )),
                Visibility(
                  visible: flightSegment.flightSegmentDetails[i].stopover !=""||
                      flightSegment.flightSegmentDetails[i].layover !="",
                  child: Container(
                    padding: flyternMediumPaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                    color: flyternPrimaryColorBg,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child:DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: flyternGrey60,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor:flyternPrimaryColorBg,
                          dashGapRadius: 0.0,
                        )),
                        Visibility(
                          visible: flightSegment.flightSegmentDetails[i].stopover !="" ,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                            child: Text(
                                '${'stopover'.tr} ${flightSegment.flightSegmentDetails[i].stopover}',
                                style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                          ),
                        ),
                        Visibility(
                          visible: flightSegment.flightSegmentDetails[i].layover !="" ,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                            child: Text(
                                "${'layover'.tr} ${flightSegment.flightSegmentDetails[i].layover}",
                            style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                          ),
                        ),
                        const Expanded(child:DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: flyternGrey60,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor:flyternPrimaryColorBg,
                          dashGapRadius: 0.0,
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  getTopLabel(String toCountry) {
    if (toCountry.split(",").toList().length > 1) {
      return toCountry.split(",").toList()[1];
    }
    if (toCountry.split(",").toList().length == 1) {
      return toCountry.split(",").toList()[0];
    }
    return toCountry;
  }
}
