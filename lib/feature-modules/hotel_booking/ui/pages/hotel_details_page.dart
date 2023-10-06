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
import 'package:ionicons/ionicons.dart';

class HotelDetailsPage extends StatefulWidget {
  const HotelDetailsPage({super.key});

  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
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
          title: Text("Rixos Premium Dubai JBR",style: TextStyle(color: flyternBackgroundWhite)),
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
                      image: AssetImage(ASSETS_HOTEL_2_SAMPLE),
                    ),
                  ),
                ),
                addVerticalSpace(flyternSpaceLarge),
                Padding(
                  padding: flyternMediumPaddingHorizontal,
                  child:  Text(
                    "location".tr,
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),
                addVerticalSpace(flyternSpaceMedium),
                Padding(
                  padding: flyternMediumPaddingHorizontal,
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(flyternBorderRadiusExtraSmall),

                          ),
                          clipBehavior: Clip.hardEdge,
                          width: screenwidth*.15,
                          child: Image.asset(ASSETS_LOCATION_ICON,width: screenwidth*.15)),
                      addHorizontalSpace(flyternSpaceMedium),

                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rixos Premium Dubai JBR",
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80),
                          ),
                          addVerticalSpace(flyternSpaceExtraSmall),

                          Text(
                            "Jbr - The Wa+k - A+ Mamsha %t - Jumeirah Beach",
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey60, ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                addVerticalSpace(flyternSpaceLarge),


                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  color: flyternGrey10,
                  child:  Text(
                    "room_details".tr,
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),

                addVerticalSpace(flyternSpaceMedium),

                Container(
                  padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                  color: flyternBackgroundWhite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Single Room",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
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
                      Text("Double Room",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
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
                      Text("Suit",style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                      Text("AED 20",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                    ],
                  ),
                ),
                addVerticalSpace(flyternSpaceLarge),
                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  color: flyternGrey10,
                  child:  Text(
                    "popular_facilities".tr,
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),
                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  height: screenwidth*.22 +(flyternSpaceLarge*2),
                  child:  ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ASSETS_WIFI_ICON,width: screenwidth*.14),
                          addVerticalSpace(flyternSpaceSmall),
                          Text("free_wifi".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),)
                        ],
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ASSETS_ROOM_SERVICE_ICON,width: screenwidth*.14),
                          addVerticalSpace(flyternSpaceSmall),
                          Text("room_service".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),)
                        ],
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ASSETS_MEAL_ICON,width: screenwidth*.14),
                          addVerticalSpace(flyternSpaceSmall),
                          Text("meal".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),)
                        ],
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ASSETS_PARKING_ICON,width: screenwidth*.14),
                          addVerticalSpace(flyternSpaceSmall),
                          Text("free_parking".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),)
                        ],
                      ),
                      addHorizontalSpace(flyternSpaceMedium),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ASSETS_NEARBY_AIRPORT_ICON,width: screenwidth*.14),
                          addVerticalSpace(flyternSpaceSmall),
                          Text("nearby_airport".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60),)
                        ],
                      ),
                      addHorizontalSpace(flyternSpaceMedium),

                    ],
                  ),
                ),
                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  color: flyternGrey10,
                  child:  Text(
                    "room_selection".tr,
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),
                Padding(
                  padding: flyternLargePaddingAll,
                  child: Row(
                    children: [
                      Text("room".tr+" 1",
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey60 ),),
                      Text( "*",
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGuideRed ),),
                    ],
                  ),
                ),
                Padding(
                  padding: flyternLargePaddingAll.copyWith(top: 0),
                  child:    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "select_room_type".tr,
                      )),
                ),
                Padding(
                  padding: flyternLargePaddingAll.copyWith(top: 0),
                  child: Row(
                    children: [
                      Text("room".tr+" 1",
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey60 ),),
                      Text( "*",
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGuideRed ),),
                    ],
                  ),
                ),
                Padding(
                  padding: flyternLargePaddingAll.copyWith(top: 0),
                  child:    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "select_room_type".tr,
                      )),
                ),
                Container(
                  padding: flyternLargePaddingAll,
                  width: screenwidth,
                  color: flyternGrey10,
                  child:  Text(
                    "reviews_rating".tr,
                    style: getHeadlineMediumStyle(context).copyWith(
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
                 openContactDetailsGetterBottomSheet();
                  },
                  child: Row(
                    children: [

                      Expanded(
                        child: Text(
                          "AED 1500",
                        ),
                      ),
                      Text("book_now".tr),
                      addHorizontalSpace(flyternSpaceSmall),
                      Icon(Ionicons.chevron_forward,size: flyternFontSize20,)
                    ],
                  )),
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
          return ContactDetailsGetter(route: Approute_userDetailsSubmission,
              secondRoute:Approute_hotelsSummary);
        });
  }
}
