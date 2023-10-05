import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';

class ProfileActivityBookingsList extends StatelessWidget {
  const ProfileActivityBookingsList({super.key});

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
           ActivityListCard(
            imageUrl: ASSETS_PACKAGE_1_SAMPLE,
            title: 'Shrek\'s Adventure',
            flightName: 'Ticket (PP)',
            hotelName: 'The Bank Hotel',
            sponsoredBy: 'Central London',
            price: 15000,
          ),
          Padding(
            padding: flyternLargePaddingHorizontal,
            child: Divider(),
          ),
          ActivityListCard(
            imageUrl: ASSETS_PACKAGE_1_SAMPLE,
            title: 'Shrek\'s Adventure',
            flightName: 'Ticket (PP)',
            hotelName: 'The Bank Hotel',
            sponsoredBy: 'Central London',
            price: 15000,
          ),
        ],
      ),
    );
  }
}
