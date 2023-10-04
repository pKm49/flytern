import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_data_capsule_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_addon_service_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightDetailsPage extends StatefulWidget {
  const FlightDetailsPage({super.key});

  @override
  State<FlightDetailsPage> createState() => _FlightDetailsPageState();
}

class _FlightDetailsPageState extends State<FlightDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("flight_details".tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("itinerary".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            FlightDetailsItineraryCard(),
            addVerticalSpace(flyternSpaceLarge),
            FlightDetailsItineraryCard(),
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("baggage".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            FlightDetailsAddonServiceCard(
              ImageUrl: ASSETS_LUGGAGE_ICON,
              keyLabel: "baggage".tr,
              valueLabel: "economy_budget".tr,
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            FlightDetailsAddonServiceCard(
              ImageUrl: ASSETS_LUGGAGE_SIZE_ICON,
              keyLabel: "size".tr,
              valueLabel: "one_piece_luggage".tr,
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingAll.copyWith(top: 0),
              child: FlightDataCapsuleCard(
                label: "Note : " + "one_piece_luggage".tr,
                theme: 2,
              ),
            ),
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("fare_rule".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            FlightDetailsAddonServiceCard(
              ImageUrl: ASSETS_CLOCK_ICON,
              keyLabel: "time".tr,
              valueLabel: "fare_rule_time_message".tr,
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            FlightDetailsAddonServiceCard(
              ImageUrl: ASSETS_LUGGAGE_SIZE_ICON,
              keyLabel: "fee".tr,
              valueLabel:
                  "${"no_baggage".tr} : AED 150\n${"standard_baggage".tr} : AED 150",
            ),
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("price_details".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            FlightDetailsAddonServiceCard(
              ImageUrl: ASSETS_COUPLE_ICON,
              keyLabel: "adult".tr,
              valueLabel: "${"base_fare".tr} : AED 150",
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            FlightDetailsAddonServiceCard(
              ImageUrl: ASSETS_KIDS_ICON,
              keyLabel: "child".tr,
              valueLabel:
                  "${"base_fare".tr} : AED 150\n${"tax_fare".tr} : AED 150",
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingAll,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "total".tr,
                      style: getHeadlineMediumStyle(context),
                    ),
                    Text(
                      "AED 1500",
                      style: getHeadlineMediumStyle(context).copyWith(
                          fontWeight: flyternFontWeightBold,
                          color: flyternGrey80),
                    ),
                  ],
                )),
            Container(
              height: 70+(flyternSpaceSmall*2),
              padding: flyternLargePaddingAll,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: screenwidth,
        color: flyternBackgroundWhite,
        height: 60+(flyternSpaceSmall*2),
        padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Approute_flightsAddonServices);
                },
                child:Text("next".tr )),
          ),
        ),
      ),
    );
  }
}
