import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';

class ProfileHotelBookingsList extends StatelessWidget {
  const ProfileHotelBookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: flyternBackgroundWhite,
      child: ListView(
        children: [
          Container(
            color: flyternGrey10,
            height: flyternSpaceLarge,
          ),
          addVerticalSpace(flyternSpaceLarge),
          HotelSearchResultCard(),
          Padding(
            padding: flyternLargePaddingHorizontal,
            child: Divider(),
          ),
          HotelSearchResultCard(),
        ],
      ),
    );
  }
}
