import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';

class ProfilePackageBookingsList extends StatelessWidget {
  const ProfilePackageBookingsList({super.key});

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
          PackageListCard(
            currency: "KD",
              ratings:"4.4",
            imageUrl: ASSETS_PACKAGE_1_SAMPLE,
            title: 'Kabul Holiday Package',
            flightName: 'KBL to IST',
            hotelName: 'The Bank Hotel',
            sponsoredBy: 'Emirates',
            price: 15000,
              packageSelected: () {
              }
          ),
          Padding(
            padding: flyternLargePaddingHorizontal,
            child: Divider(),
          ),
          PackageListCard(
              ratings:"4.4",
            currency: "KD",
            imageUrl: ASSETS_PACKAGE_1_SAMPLE,
            title: 'Kabul Holiday Package',
            flightName: 'KBL to IST',
            hotelName: 'The Bank Hotel',
            sponsoredBy: 'Emirates',
            price: 15000,
              packageSelected: () {
              }
          ),
        ],
      ),
    );
  }
}
