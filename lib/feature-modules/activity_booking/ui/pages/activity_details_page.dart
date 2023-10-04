import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/travel_stories_item_card.dart';
import 'package:flytern/shared/ui/components/contact_details_getter.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_addon_service_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class ActivityDetailsPage extends StatefulWidget {
  const ActivityDetailsPage({super.key});

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: flyternBackgroundWhite),
          elevation: 0.5,
          backgroundColor: Colors.transparent,
          title: Text("Shrek's Adventure",style: TextStyle(color: flyternBackgroundWhite)),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          width: screenwidth,
          height: screenheight,
          color: flyternBackgroundWhite,
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(ASSETS_ACTIVITY_1_SAMPLE),
                    ),
                  ),
                ),
                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  color: flyternGrey10,
                  child:  Text(
                    "reviews_rating".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),

                addVerticalSpace(flyternSpaceSmall),
                TravelStoriesItemCard(
                  profilePicUrl: ASSETS_USER_1_SAMPLE,
                  name: "Andrew Martin",
                  rating: 4.4,
                  description: "lorem_ipsum_description".tr,
                  imageUrl: ASSETS_TESTIMONIAL_SAMPLE,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                  child: Divider(),
                ),
                TravelStoriesItemCard(
                  profilePicUrl: ASSETS_USER_1_SAMPLE,
                  name: "Andrew Martin",
                  rating: 4.4,
                  description: "lorem_ipsum_description".tr,
                  imageUrl: ASSETS_TESTIMONIAL_SAMPLE,
                ),

                addVerticalSpace(flyternSpaceMedium),

                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  color: flyternGrey10,
                  child:  Text(
                    "price_details".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),
                Padding(
                  padding: flyternLargePaddingAll,
                  child:    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "select_ticket".tr,
                      )),
                ),

                Container(
                  padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                  color: flyternBackgroundWhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ticket Price",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      Text("AED 20",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                    ],
                  ),
                ),
                Container(
                    padding: flyternLargePaddingHorizontal,
                    color:flyternBackgroundWhite,
                    child: Divider()),
                Container(
                  padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                  color: flyternBackgroundWhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      Text("AED 20",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                    ],
                  ),
                ),
                addVerticalSpace(flyternSpaceLarge),

                Container(
                  height: 70+(flyternSpaceSmall*2),
                  padding: flyternLargePaddingAll,
                )
              ],
            ),
          )
        ),
        bottomSheet: Container(
          width: screenwidth,
          color: flyternBackgroundWhite,
          height: 60 + (flyternSpaceSmall * 2),
          padding: flyternLargePaddingAll.copyWith(
              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    openContactDetailsGetterBottomSheet( );
                  },
                  child: Text("buy_now".tr)),
            ),
          ),
        ),
      ),
    );
  }


  void openContactDetailsGetterBottomSheet( ) {
    showModalBottomSheet(
        useSafeArea: false,
        shape:   RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ContactDetailsGetter(route: Approute_activitiesSummary);
        });
  }
}
