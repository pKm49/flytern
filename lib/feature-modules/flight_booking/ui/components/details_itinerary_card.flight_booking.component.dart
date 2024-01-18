import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/models/segment.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightDetailsItineraryCard extends StatelessWidget {
  FlightSegment flightSegment;

  FlightDetailsItineraryCard({super.key, required this.flightSegment});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: flyternBorderedContainerSmallDecoration,
      width: screenwidth - (flyternSpaceLarge * 2),
      margin: flyternLargePaddingHorizontal,
      child: Wrap(
        runSpacing: 0,
        children: [
          Container(
            width: screenwidth - (flyternSpaceLarge * 2),
            padding: flyternMediumPaddingAll.copyWith(bottom: 0),
            child: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.flight_takeoff_outlined,
                    color: flyternSecondaryColor),
                addHorizontalSpace(flyternSpaceSmall),
                Expanded(
                  child: Text(
                    "${flightSegment.departure}",
                    style: getBodyMediumStyle(context),
                  ),
                ),
              ],
            )),
          ),
          Container(
            width: screenwidth - (flyternSpaceLarge * 2),
            padding: flyternMediumPaddingAll.copyWith(
                top: flyternSpaceSmall, bottom: flyternSpaceMedium),
            child: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.linear_scale, color: flyternSecondaryColor),
                addHorizontalSpace(flyternSpaceSmall),
                Expanded(
                  child: Text(
                    flightSegment.arrival,
                    style: getBodyMediumStyle(context),
                  ),
                ),
              ],
            )),
          ),
          Container(
            width: screenwidth - (flyternSpaceLarge * 2),
            margin: EdgeInsets.only(bottom: flyternSpaceSmall),
            padding: flyternMediumPaddingHorizontal,
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              spacing: flyternSpaceSmall,
              runSpacing: flyternSpaceSmall,
              children: [
                Visibility(
                  visible: flightSegment.flightSegmentDetails.length > 1,
                  child: Container(
                    padding: flyternSmallPaddingHorizontal.copyWith(
                        top: flyternSpaceExtraSmall,
                        bottom: flyternSpaceExtraSmall),
                    decoration: BoxDecoration(
                      color: flyternPrimaryColorBg,
                      borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    child: Text(
                      "${flightSegment.flightSegmentDetails.isNotEmpty ? flightSegment.flightSegmentDetails.length - 1 : 0} ${'stops'.tr}",
                      style: getLabelLargeStyle(context)
                          .copyWith(color: flyternPrimaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: flyternSmallPaddingHorizontal.copyWith(
                      top: flyternSpaceExtraSmall,
                      bottom: flyternSpaceExtraSmall),
                  decoration: BoxDecoration(
                    color: flyternPrimaryColorBg,
                    borderRadius:
                        BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(Ionicons.time_outline,
                          color: flyternPrimaryColor, size: flyternFontSize16),
                      addHorizontalSpace(flyternSpaceSmall),
                      Text(
                        "${flightSegment.travelTime} ",
                        style: getLabelLargeStyle(context)
                            .copyWith(color: flyternPrimaryColor),
                      ),
                    ],
                  ),
                ),
                for (var i = 0;
                    i < flightSegment.flightSegmentBaggages.length;
                    i++)
                  Container(
                    padding: flyternSmallPaddingHorizontal.copyWith(
                        top: flyternSpaceExtraSmall,
                        bottom: flyternSpaceExtraSmall),
                    decoration: BoxDecoration(
                      color: flyternPrimaryColorBg,
                      borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Icon(Ionicons.bag_outline,
                            color: flyternPrimaryColor,
                            size: flyternFontSize16),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text(
                          "${flightSegment.flightSegmentBaggages[i].passTy} - ${flightSegment.flightSegmentBaggages[i].cabin}",
                          style: getLabelLargeStyle(context)
                              .copyWith(color: flyternPrimaryColor),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Divider(),
          for (var i = 0; i < flightSegment.flightSegmentDetails.length; i++)
            Wrap(
              children: [
                //airline data

                Visibility(
                  visible: flightSegment.flightSegmentDetails[i].flightNumber !=
                          "" &&
                      flightSegment.flightSegmentDetails[i].flightName != "",
                  child: Padding(
                    padding: flyternMediumPaddingAll.copyWith(
                        bottom: 0,
                        top: i == 0 ? flyternSpaceSmall : flyternSpaceMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(flyternBlurRadiusSmall)),
                          child: Image.network(
                              flightSegment
                                  .flightSegmentDetails[i].carrierImageUrl,
                              height: 25,
                              errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 25,
                              width: screenwidth * .2,
                            );
                          }),
                        ),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text(
                          "${flightSegment.flightSegmentDetails[i].flightName} - ${flightSegment.flightSegmentDetails[i].flightNumber}",
                          style: getBodyMediumStyle(context),
                        )
                      ],
                    ),
                  ),
                ),

                // operator data
                Visibility(
                  visible: flightSegment.flightSegmentDetails[i].isOperatedBy,
                  child: Padding(
                    padding: flyternMediumPaddingAll.copyWith(bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                              Radius.circular(flyternBorderRadiusExtraSmall)),
                          child: Image.network(
                              flightSegment.flightSegmentDetails[i]
                                  .operatingCarrierImageUrl,
                              height: 25,
                              errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 25,
                              width: screenwidth * .2,
                            );
                          }),
                        ),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text(
                          "operated_by".tr.replaceAll(
                                  "name",
                                  flightSegment.flightSegmentDetails[i]
                                      .operatingCarrierName) +
                              " - ${flightSegment.flightSegmentDetails[i].operatingCarrierFlightNumber}",
                          style: getBodyMediumStyle(context),
                        )
                      ],
                    ),
                  ),
                ),

                //flight data
                Container(
                  padding: flyternMediumPaddingAll.copyWith(
                      bottom: flyternSpaceLarge, top: flyternSpaceLarge),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FlightAirportLabelCard(
                                topLabel: flightSegment
                                    .flightSegmentDetails[i].departuredt,
                                midLabel: flightSegment
                                    .flightSegmentDetails[i].departuretime,
                                bottomLabel: flightSegment
                                    .flightSegmentDetails[i].departure,
                                sideNumber: 1,
                              ),
                            ],
                          )),
                          Container(
                            width: screenwidth * .2,
                            padding: flyternSmallPaddingHorizontal,
                            child: Column(
                              children: [
                                Image.asset(
                                  ASSETS_FLIGHT_CHART_ICON,
                                  width: screenwidth * .2,
                                  matchTextDirection: true,
                                ),
//                                 addVerticalSpace(flyternSpaceSmall),
                                addVerticalSpace(flyternSpaceSmall),
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    flightSegment
                                        .flightSegmentDetails[i].duration,
                                    style: getLabelLargeStyle(context),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              FlightAirportLabelCard(
                                topLabel: flightSegment
                                    .flightSegmentDetails[i].arrivaldt,
                                midLabel: flightSegment
                                    .flightSegmentDetails[i].arrivaltime,
                                bottomLabel: flightSegment
                                    .flightSegmentDetails[i].arrival,
                                sideNumber: 2,
                              ),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                ),

                // airport data
                Container(
                  padding: flyternMediumPaddingAll.copyWith(top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                flightSegment
                                    .flightSegmentDetails[i].departurecntry,
                                maxLines: 2,
                              ),
                              addVerticalSpace(flyternSpaceSmall),
                              Visibility(
                                visible: flightSegment.flightSegmentDetails[i]
                                    .departureTerminal !="",
                                child: Text("terminal".tr.replaceAll(
                                    "1",
                                    flightSegment.flightSegmentDetails[i]
                                        .departureTerminal)),
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  flightSegment
                                      .flightSegmentDetails[i].arrivalcntry,
                                  maxLines: 2,
                                  textAlign: TextAlign.end),
                              addVerticalSpace(flyternSpaceSmall),
                              Visibility(
                                visible: flightSegment.flightSegmentDetails[i]
                                    .arrivalTerminal !="",
                                child: Text(
                                    "terminal".tr.replaceAll(
                                        "1",
                                        flightSegment.flightSegmentDetails[i]
                                            .arrivalTerminal),
                                    textAlign: TextAlign.end),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                ),

                // layover & sleepover
                Visibility(
                  visible:
                      flightSegment.flightSegmentDetails[i].stopover != "" ||
                          flightSegment.flightSegmentDetails[i].layover != "",
                  child: Container(
                    padding: flyternMediumPaddingAll.copyWith(
                        top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                    color: flyternPrimaryColorBg,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: flyternGrey60,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: flyternPrimaryColorBg,
                          dashGapRadius: 0.0,
                        )),
                        Visibility(
                          visible:
                              flightSegment.flightSegmentDetails[i].stopover !=
                                  "",
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: flyternSpaceMedium),
                            child: Text(
                                '${'stopover'.tr} ${flightSegment.flightSegmentDetails[i].stopover}',
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                          ),
                        ),
                        Visibility(
                          visible:
                              flightSegment.flightSegmentDetails[i].layover !=
                                  "",
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: flyternSpaceMedium),
                            child: Text(
                                "${'layover'.tr} ${flightSegment.flightSegmentDetails[i].layover}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                          ),
                        ),
                        const Expanded(
                            child: DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineLength: double.infinity,
                          lineThickness: 1.0,
                          dashLength: 4.0,
                          dashColor: flyternGrey60,
                          dashRadius: 0.0,
                          dashGapLength: 4.0,
                          dashGapColor: flyternPrimaryColorBg,
                          dashGapRadius: 0.0,
                        )),
                      ],
                    ),
                  ),
                ),
              ],
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

  String getBaggageWeight(FlightSegment flightSegment) {
    String baggage = "";
    if (flightSegment.flightSegmentBaggages.isNotEmpty) {
      baggage = flightSegment.flightSegmentBaggages[0].cabin;
    }
    return baggage;
  }
}
