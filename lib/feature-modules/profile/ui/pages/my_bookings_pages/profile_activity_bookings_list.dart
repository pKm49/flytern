import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/feature-modules/profile/controllers/profile_controller.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:get/get.dart';

class ProfileActivityBookingsList extends StatefulWidget {
  const ProfileActivityBookingsList({super.key});

  @override
  State<ProfileActivityBookingsList> createState() => _ProfileActivityBookingsListState();
}

class _ProfileActivityBookingsListState extends State<ProfileActivityBookingsList> {
  final profileController = Get.find<ProfileController>();

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
          //  ActivityListCard(
          //    onPressed: (){
          //
          //    },
          //   imageUrl: ASSETS_PACKAGE_1_SAMPLE,
          //   title: 'Shrek\'s Adventure',
          //   flightName: 'Ticket (PP)',
          //   hotelName: 'The Bank Hotel',
          //   sponsoredBy: 'Central London',
          //   price: 15000,
          // ),
        ],
      ),
    );
  }
}
