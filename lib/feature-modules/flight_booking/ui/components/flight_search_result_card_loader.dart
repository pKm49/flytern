import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_response.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card_loader.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

class FlightSearchResultCardLoader extends StatelessWidget {
  FlightSearchResultCardLoader({super.key});

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
                Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: flyternGrey10,
                      borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth * .2,
                    height: 20,
                  ),
                ),
                Expanded(child: Container()),
                Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: flyternGrey10,
                      borderRadius:
                          BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth * .2,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(),
                      clipBehavior: Clip.hardEdge,
                      child: FlightAirportLabelCardLoader(
                        sideNumber: 1,
                      ))),
              Padding(
                padding: flyternSmallPaddingHorizontal,
                child:  Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: flyternGrey10,
                      borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth * .2,
                    height: 20,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(),
                clipBehavior: Clip.hardEdge,
                child: FlightAirportLabelCardLoader(
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
              Shimmer.fromColors(
                baseColor: flyternBackgroundWhite,
                highlightColor: flyternGrey20,
                child: Container(
                  decoration: BoxDecoration(
                    color: flyternGrey10,
                    borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  ),
                  width: screenwidth * .3,
                  height: 20,
                ),
              ),
              Expanded(child: Container()),
              Shimmer.fromColors(
                baseColor: flyternBackgroundWhite,
                highlightColor: flyternGrey20,
                child: Container(
                  decoration: BoxDecoration(
                    color: flyternGrey10,
                    borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  ),
                  width: screenwidth * .3,
                  height: 20,
                ),
              ),
            ],
          )
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