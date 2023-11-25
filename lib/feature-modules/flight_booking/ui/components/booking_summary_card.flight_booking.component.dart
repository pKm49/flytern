import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';

class FlightBookingSummaryCard extends StatelessWidget {

  String mode ;
  final GestureTapCallback onDateChange;
  final GestureTapCallback onCancel;

  FlightBookingSummaryCard({super.key, required this.mode,
  required this.onCancel,
  required this.onDateChange,
  });

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
                    topLabel: "Kabul, AFG",
                    midLabel: "KBL",
                    bottomLabel: "08:00 AM",
                    sideNumber: 2,
                  ))
            ],
          ),

          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "date".tr,
                        style: getLabelLargeStyle(context).copyWith(
                            color: flyternGrey40,
                            fontWeight: FontWeight.  w400),
                      ),
                      addVerticalSpace(flyternSpaceExtraSmall),
                      Text(
                        "Tue, July 4 2023",
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
                        "time".tr,
                        style: getLabelLargeStyle(context).copyWith(
                            color: flyternGrey40,
                            fontWeight: FontWeight.  w400),
                      ),
                      addVerticalSpace(flyternSpaceExtraSmall),
                      Text(
                        "08:00 AM - 12:00 PM",
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
              Expanded(
                  child: FlightAirportLabelCard(
                    topLabel: "Kabul, AFG",
                    midLabel: "KBL",
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

          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "date".tr,
                        style: getLabelLargeStyle(context).copyWith(
                            color: flyternGrey40,
                            fontWeight: FontWeight.  w400),
                      ),
                      addVerticalSpace(flyternSpaceExtraSmall),
                      Text(
                        "Tue, July 4 2023",
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
                        "time".tr,
                        style: getLabelLargeStyle(context).copyWith(
                            color: flyternGrey40,
                            fontWeight: FontWeight.  w400),
                      ),
                      addVerticalSpace(flyternSpaceExtraSmall),
                      Text(
                        "08:00 AM - 12:00 PM",
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
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "passengers".tr,
                        style: getLabelLargeStyle(context).copyWith(
                            color: flyternGrey40,
                            fontWeight: FontWeight.  w400),
                      ),
                      addVerticalSpace(flyternSpaceExtraSmall),
                      Text(
                        "1 Adult, 1 Child",
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
                        "cabin_class".tr,
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
              ],
            ),
          ),
          Visibility(
            visible: mode == "edit",
            child: Row(
              children: [
                Expanded(child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(color: flyternSecondaryColor, width: 1)),
                      textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                          fontWeight: flyternFontWeightMedium, color: flyternSecondaryColor)),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(flyternSecondaryColor),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: flyternSpaceLarge, vertical: flyternSpaceMedium)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall))),),
                    onPressed: onDateChange, child: Text("change_date".tr))),
                addHorizontalSpace(flyternSpaceSmall),
                Expanded(child: ElevatedButton(style: getElevatedButtonStyle(context),onPressed: onCancel, child: Text("cancel".tr)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
