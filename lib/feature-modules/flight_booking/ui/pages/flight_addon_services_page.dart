import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_addon_services_item_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_addon_service_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightAddonServicesPage extends StatefulWidget {
  const FlightAddonServicesPage({super.key});

  @override
  State<FlightAddonServicesPage> createState() => _FlightAddonServicesPageState();
}

class _FlightAddonServicesPageState extends State<FlightAddonServicesPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("add_ons".tr),
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Padding(
              padding: flyternLargePaddingAll,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("add_on_services".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                  Text("flight_details".tr,
                      style: getBodyMediumStyle(context).copyWith(
                    decoration: TextDecoration.underline,
                          color: flyternTertiaryColor )),
                ],
              ),
            ),

            FlightAddonServicesItemCard(
              route: Approute_flightsSeatSelection,
              ImageUrl: ASSETS_SEAT_ICON,
              keyLabel: "seats".tr,
              valueLabel: "available_seats".tr,
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            FlightAddonServicesItemCard(
              route: Approute_flightsMealSelection,
              ImageUrl: ASSETS_MEAL_ICON,
              keyLabel: "meal".tr,
              valueLabel: "select_meal".tr,
            ),
            Container(
                color: flyternBackgroundWhite,
                padding: flyternLargePaddingHorizontal,
                child: Divider()),
            FlightAddonServicesItemCard(
              route: Approute_flightsBaggageSelection,
              ImageUrl: ASSETS_LUGGAGE_ICON,
              keyLabel: "baggage".tr,
              valueLabel: "select_baggage".tr,
            ),

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
                  Get.toNamed(Approute_flightsUserDetailsSubmission);
                },
                child:Text("next".tr )),
          ),
        ),
      ),
    );
  }
}
