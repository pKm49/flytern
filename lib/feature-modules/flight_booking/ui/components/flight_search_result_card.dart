import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightSearchResultCard extends StatelessWidget {
  final GestureTapCallback onPressed;
  final GestureTapCallback onMoreOptionsPressed;
  FlightSearchResponse flightSearchResponse;

  FlightSearchResultCard(
      {super.key, required this.flightSearchResponse, required this.onPressed,required this.onMoreOptionsPressed});

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
        runSpacing: flyternSpaceSmall,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: flyternSpaceSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(flyternBorderRadiusExtraSmall)),
                  child: Image.network(flightSearchResponse.airlineImageUrl,
                      height: 30, errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 20,
                      width: screenwidth * .2,
                    );
                  }),
                ),
                Expanded(child: Container()),
                Visibility(
                  visible: flightSearchResponse.dTOSegments.isNotEmpty,
                  child: DataCapsuleCard(
                    label:
                        "${flightSearchResponse.dTOSegments.isNotEmpty ? flightSearchResponse.dTOSegments[0].stops : 0} ${'stops'.tr}",
                    theme: 2,
                  ),
                ),
                addHorizontalSpace(flyternSpaceSmall),
                DataCapsuleCard(
                  label: flightSearchResponse.isRefund
                      ? "refundable".tr
                      : "non_refundable".tr,
                  theme: flightSearchResponse.isRefund ? 1 : 3,
                ),
              ],
            ),
          ),
          for (var i = 0; i < flightSearchResponse.dTOSegments.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(),
                  clipBehavior: Clip.hardEdge,
                  child: FlightAirportLabelCard(
                    topLabel: getTopLabel(
                        flightSearchResponse.dTOSegments[i].fromCountry),
                    midLabel: flightSearchResponse.dTOSegments[i].from,
                    bottomLabel:
                        flightSearchResponse.dTOSegments[i].departureTime,
                    sideNumber: 1,
                  ),
                )),
                Padding(
                  padding: flyternSmallPaddingHorizontal,
                  child: Image.asset(
                    ASSETS_FLIGHT_CHART_ICON,
                    width: screenwidth * .3,
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(),
                  clipBehavior: Clip.hardEdge,
                  child: FlightAirportLabelCard(
                    topLabel: getTopLabel(
                        flightSearchResponse.dTOSegments[i].toCountry),
                    midLabel: flightSearchResponse.dTOSegments[i].to,
                    bottomLabel:
                        flightSearchResponse.dTOSegments[i].arrivalTime,
                    sideNumber: 2,
                  ),
                ))
              ],
            ),
          Padding(
            padding: const EdgeInsets.only(top: flyternSpaceSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < (screenwidth - (screenwidth / 1.3)); i++)
                  Container(
                    color: i % 2 == 0 ? flyternGrey40 : Colors.transparent,
                    height: 1,
                    width: 3,
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: flightSearchResponse.isSale,
                child: Text(
                  "${flightSearchResponse.totalPrc.toStringAsFixed(2)} ${flightSearchResponse.currency}",
                  style: getBodyMediumStyle(context).copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: flyternFontWeightBold,
                      color: flyternGrey40),
                ),
              ),
              addHorizontalSpace(flyternSpaceSmall),
              Text(
                "${flightSearchResponse.finalPrc.toStringAsFixed(2)} ${flightSearchResponse.currency}",
                style: getHeadlineMediumStyle(context).copyWith(
                    fontWeight: flyternFontWeightBold,
                    color: flyternSecondaryColor),
              ),
              Expanded(child: Container()),
              ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(flyternBorderRadiusExtraSmall)),
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: 0, vertical: flyternSpaceExtraSmall)),
                    ),
                    onPressed: onPressed,
                    child: Icon(Ionicons.chevron_forward)),
              ),
            ],
          ),
          Visibility(
              visible: flightSearchResponse.moreOptioncount > 0,
              child: Row(
                children: [
                  InkWell(
                    onTap:onMoreOptionsPressed,
                    child: Container(
                      decoration: BoxDecoration(
                          border: const Border(
                        bottom: BorderSide(
                          color: flyternTertiaryColor,
                          width: 1,
                        ),
                      )),
                      child: Text(
                          "other_option".tr.replaceAll('3',
                              flightSearchResponse.moreOptioncount.toString()),
                          style: getLabelLargeStyle(context)
                              .copyWith(color: flyternTertiaryColor)),
                    ),
                  )
                ],
              ))
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
