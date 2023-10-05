import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:get/get.dart';

class ProfileFlightBookingsList extends StatelessWidget {
  const ProfileFlightBookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        addVerticalSpace(flyternSpaceLarge),
        FlightSearchResultCard(
          onPressed: (){
            Get.toNamed(Approute_flightsConfirmation,arguments: [
                {"mode": "edit"}
                ] );
          },
        ),
        addVerticalSpace(flyternSpaceLarge),
        FlightSearchResultCard(
          onPressed: (){
            Get.toNamed(Approute_flightsConfirmation,arguments: [
              {"mode": "edit"}
            ] );
          },
        ),
      ],
    );
  }
}
