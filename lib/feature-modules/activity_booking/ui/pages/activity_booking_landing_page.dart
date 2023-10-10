import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:get/get.dart';

class ActivityBookingLandingPage extends StatefulWidget {
  const ActivityBookingLandingPage({super.key});

  @override
  State<ActivityBookingLandingPage> createState() => _ActivityBookingLandingPageState();
}

class _ActivityBookingLandingPageState extends State<ActivityBookingLandingPage> {
  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight,
      width: screenwidth,
      color: flyternGrey10,
      child: Column(
        children: [
          Container(
            width: screenwidth-flyternSpaceMedium*2,
            padding: flyternMediumPaddingHorizontal,
            margin: flyternMediumPaddingAll,
            decoration: BoxDecoration(
              color: flyternBackgroundWhite,
              boxShadow: flyternItemShadow,
              borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
            ),
            child: DropDownSelector(
              titleText: "select_destination".tr,
              selected:null  ,
              items: [
                GeneralItem(id: 1, name: "select_destination".tr),
                GeneralItem(id: 2, name: "India"),
                GeneralItem(id: 3, name: "Spain"),
                GeneralItem(id: 4, name: "Nepal"),
              ],
              hintText:"select_destination".tr,
              valueChanged: (newZone) {

              },
            ),
          ),
          Expanded(child: Container(
            color: flyternBackgroundWhite,
            child: ListView(
              children: [
                ActivityListCard(
                  onPressed: (){
                    Get.toNamed(Approute_activitiesDetails);
                  },
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Shrek\'s Adventure',
                  flightName: 'Ticket (PP)',
                  hotelName: 'The Bank Hotel',
                  sponsoredBy: 'Central London',
                  price: 15000,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                  child: Divider(),
                ),
                ActivityListCard(
                  onPressed: (){
                    Get.toNamed(Approute_activitiesDetails);
                  },
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Shrek\'s Adventure',
                  flightName: 'KBL to IST',
                  hotelName: 'The Bank Hotel',
                  sponsoredBy: 'Central London',
                  price: 15000,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                  child: Divider(),
                ),
                ActivityListCard(
                  onPressed: (){
                    Get.toNamed(Approute_activitiesDetails);
                  },
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Shrek\'s Adventure',
                  flightName: 'KBL to IST',
                  hotelName: 'The Bank Hotel',
                  sponsoredBy: 'Central London',
                  price: 15000,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                  child: Divider(),
                ),
                ActivityListCard(
                  onPressed: (){
                    Get.toNamed(Approute_activitiesDetails);
                  },
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Shrek\'s Adventure',
                  flightName: 'KBL to IST',
                  hotelName: 'The Bank Hotel',
                  sponsoredBy: 'Central London',
                  price: 15000,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                  child: Divider(),
                ),
                ActivityListCard(
                  onPressed: (){
                    Get.toNamed(Approute_activitiesDetails);
                  },
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Shrek\'s Adventure',
                  flightName: 'KBL to IST',
                  hotelName: 'The Bank Hotel',
                  sponsoredBy: 'Central London',
                  price: 15000,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
