import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_destinations_container.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_destinations_loader.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_for_you_container.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_for_you_loader.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_container.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_loader.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_form.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_type_tab.dart';
  import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/section_title/section_title_container.dart';
import 'package:flytern/shared/ui/components/section_title/section_title_container_loader.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FlightBookingLandingPage extends StatefulWidget {
  const FlightBookingLandingPage({super.key});

  @override
  State<FlightBookingLandingPage> createState() =>
      _FlightBookingLandingPageState();
}

class _FlightBookingLandingPageState extends State<FlightBookingLandingPage>
    with SingleTickerProviderStateMixin {

  final flightBookingController =  Get.put(FlightBookingController());

  int selectedTab = 1;
  int multicityCount = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      height: screenheight,
      width: screenwidth,
      color: flyternGrey10,
      child: Obx(
          ()=> ListView(
          children: [
            Container(
              padding: EdgeInsets.all(flyternSpaceLarge),
              height: (screenheight * .7) + (flyternSpaceLarge * 2.5) +
                  (   (multicityCount-1)*230  )+(selectedTab==3?65:0),
              width: screenwidth - (flyternSpaceLarge * 2),
              decoration: BoxDecoration(

                image: DecorationImage(
                  image: AssetImage(ASSETS_FLIGHTS_BG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: screenheight * .025,
                        width: screenwidth - (flyternSpaceLarge * 2),
                      ),
                      Container(
                        height: screenheight * .675+((multicityCount-1)*230)+(selectedTab==3?65:0),
                        decoration: flyternShadowedContainerSmallDecoration,
                        width: screenwidth - (flyternSpaceLarge * 2),
                        padding: flyternMediumPaddingAll,
                        child: Container(
                          margin: EdgeInsets.only(top: flyternSpaceLarge),
                          child: FlightBookingForm(
                              onCityAdded:(){
                                print("onCityAdded");
                                print(multicityCount);
                                setState(() {
                                  multicityCount = 2;
                                });
                                print(multicityCount);
                              },
                              selectedTab: selectedTab),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          height: screenheight * .05,
                          width: screenwidth - (flyternSpaceLarge * 2),
                          padding: flyternMediumPaddingHorizontal,
                          child: Row(
                            children: [
                              Expanded(
                                child: FlightTypeTab(
                                  onPressed: () {
                                    setState(() {
                                      selectedTab = 1;
                                      multicityCount = 1;
                                    });
                                  },
                                  index: 1,
                                  icon: Ionicons.arrow_forward_outline,
                                  label: 'one_way'.tr,
                                  selectedTab: selectedTab,
                                ),
                              ),
                              addHorizontalSpace(flyternSpaceSmall),
                              Expanded(
                                child: FlightTypeTab(
                                  onPressed: () {
                                    setState(() {
                                      selectedTab = 2;
                                      multicityCount = 1;
                                    });
                                  },
                                  index: 2,
                                  icon: Ionicons.swap_horizontal_outline,
                                  label: 'round_trip'.tr,
                                  selectedTab: selectedTab,
                                ),
                              ),
                              addHorizontalSpace(flyternSpaceSmall),
                              Expanded(
                                child: FlightTypeTab(
                                  onPressed: () {
                                    setState(() {
                                      selectedTab = 3;
                                    });
                                  },
                                  index: 3,
                                  icon: Ionicons.share_social_outline,
                                  label: 'multi_city'.tr,
                                  selectedTab: selectedTab,
                                ),
                              )
                            ],
                          )),
                      Container(
                        height: screenheight * .65 +
                            ( (multicityCount-1)*230  )+(selectedTab==3?65:0),
                        width: screenwidth - (flyternSpaceLarge * 2),
                      )
                    ],
                  )
                ],
              ),
            ),
            addVerticalSpace(flyternSpaceLarge),

            //recommended for you
            Visibility(
              visible: !flightBookingController.isInitialDataLoading.value &&
                  flightBookingController.recommendedPackages.isNotEmpty,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                  bottom: flyternSpaceLarge
                ),
                child:SectionTitleContainer(
                  name: 'recommended_for_you'.tr,
                  linkName: 'see_all'.tr,
                  linkUrl: '',
                  isLarge: true,
                ) ,
              ),
            ),
            Visibility(
              visible:  flightBookingController.isInitialDataLoading.value,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                  bottom: flyternSpaceLarge
                ),
                child:SectionTitleContainerLoader( ) ,
              ),
            ),
            Visibility(
                visible: !flightBookingController.isInitialDataLoading.value &&
                flightBookingController.recommendedPackages.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:flyternSpaceLarge*2),
                  child: RecommendedForYouContainer(
                      recommendedPackages:flightBookingController.recommendedPackages
                  ),
                )),
            Visibility(visible:  flightBookingController.isInitialDataLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:flyternSpaceLarge*2),
                  child: RecommendedForYouLoader(),
                )),

             //popular destinations
            Visibility(
              visible: !flightBookingController.isInitialDataLoading.value &&
                  flightBookingController.popularDestinations.isNotEmpty,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge
                ),
                child:SectionTitleContainer(
                  name: 'popular_destinations'.tr,
                  linkName: 'see_all'.tr,
                  linkUrl: '',
                  isLarge: true,
                ) ,
              ),
            ),
            Visibility(
              visible:  flightBookingController.isInitialDataLoading.value,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge
                ),
                child:SectionTitleContainerLoader( ) ,
              ),
            ),
            Visibility(
                visible: !flightBookingController.isInitialDataLoading.value &&
                    flightBookingController.popularDestinations.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:flyternSpaceLarge*2),
                  child: PopularDestinationsContainer(
                      popularDestinations:flightBookingController.popularDestinations
                  ),
                )),
            Visibility(visible:  flightBookingController.isInitialDataLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:flyternSpaceLarge*2),
                  child: PopularDestinationsLoader(),
                )),



            //travel stories
            Visibility(
              visible: !flightBookingController.isInitialDataLoading.value &&
                  flightBookingController.popularDestinations.isNotEmpty,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge
                ),
                child:SectionTitleContainer(
                  name: 'travel_stories'.tr,
                  linkName: 'see_all'.tr,
                  linkUrl: '',
                  isLarge: true,
                ) ,
              ),
            ),
            Visibility(
              visible:  flightBookingController.isInitialDataLoading.value,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge
                ),
                child:SectionTitleContainerLoader( ) ,
              ),
            ),
            Visibility(
                visible: !flightBookingController.isInitialDataLoading.value &&
                    flightBookingController.popularDestinations.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:flyternSpaceLarge*2),
                  child: TravelStoriesContainer(
                      travelStories:flightBookingController.travelStories
                  ),
                )),
            Visibility(visible:  flightBookingController.isInitialDataLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:flyternSpaceLarge*2),
                  child: TravelStoriesLoader(),
                )),

            addVerticalSpace(flyternSpaceLarge),
          ],
        ),
      ),
    );
  }
}
