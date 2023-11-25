import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/profile/controllers/profile.controller.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:get/get.dart';

class ProfileActivityBookingsList extends StatefulWidget {
  const ProfileActivityBookingsList({super.key});

  @override
  State<ProfileActivityBookingsList> createState() =>
      _ProfileActivityBookingsListState();
}

class _ProfileActivityBookingsListState
    extends State<ProfileActivityBookingsList> {
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
