import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/constants/flight_mode.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper.flight_booking.service.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_destinations_container.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_destinations_loader.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_for_you_container.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_for_you_loader.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_container.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_loader.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/booking_form.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_type_tab.flight_booking.component.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/section_title/section_title_container.shared.component.dart';
import 'package:flytern/shared-module/ui/components/section_title/section_title_container_loader.shared.component.dart';
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
  final flightBookingController = Get.put(FlightBookingController()); 
  var flightBookingHelperServices = FlightBookingHelperServices();
  final packageBookingController = Get.put(PackageBookingController());

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
        () => ListView(
          children: [
            Container(
              padding: EdgeInsets.all(flyternSpaceLarge),
              // height:
              //     flightBookingHelperServices.getFlightBookingContainerHeight(
              //         screenheight,
              //         flightBookingController ),
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
                        // height: screenheight * .025,
                        height:25,
                        width: screenwidth - (flyternSpaceLarge * 2),
                      ),
                      Container(
                        // height:flightBookingHelperServices.getFlightBookingContainerHeight(
                        //     screenheight,
                        //     flightBookingController ) - (screenheight * .025) - (flyternSpaceLarge * 2),
                        decoration: flyternShadowedContainerSmallDecoration,
                        width: screenwidth - (flyternSpaceLarge * 2),
                        padding: flyternMediumPaddingAll,
                        child: Container(
                          margin: EdgeInsets.only(top: flyternSpaceLarge),
                          child: FlightBookingForm(
                            isRedirectionRequired:true,
                            flightBookingController: flightBookingController,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          // height: screenheight * .05,
                          height:50,
                          width: screenwidth - (flyternSpaceLarge * 2),
                          padding: flyternMediumPaddingHorizontal,
                          child: Row(
                            children: [
                              Expanded(
                                child: FlightTypeTab(
                                  onPressed: () {
                                    flightBookingController
                                        .setFlightMode(FlightMode.ONEWAY);
                                  },
                                  icon: Ionicons.arrow_forward_outline,
                                  label: 'one_way'.tr,
                                  isSelected: flightBookingController
                                          .flightSearchData.value.mode ==
                                      FlightMode.ONEWAY,
                                ),
                              ),
                              addHorizontalSpace(flyternSpaceSmall),
                              Expanded(
                                child: FlightTypeTab(
                                  onPressed: () {
                                    flightBookingController
                                        .setFlightMode(FlightMode.ROUNDTRIP);
                                  },
                                  icon: Ionicons.swap_horizontal_outline,
                                  label: 'round_trip'.tr,
                                  isSelected: flightBookingController
                                          .flightSearchData.value.mode ==
                                      FlightMode.ROUNDTRIP,
                                ),
                              ),
                              addHorizontalSpace(flyternSpaceSmall),
                              Expanded(
                                child: FlightTypeTab(
                                  onPressed: () {
                                    flightBookingController
                                        .setFlightMode(FlightMode.MULTICITY);
                                  },
                                  icon: Ionicons.git_branch_outline,
                                  label: 'multi_city'.tr,
                                  isSelected: flightBookingController
                                          .flightSearchData.value.mode ==
                                      FlightMode.MULTICITY,
                                ),
                              )
                            ],
                          )),
                      Container(
                        // height:flightBookingHelperServices.getFlightBookingContainerHeight(
                        //     screenheight,
                        //     flightBookingController )- (screenheight * .05) - (flyternSpaceLarge * 2),
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
                    bottom: flyternSpaceLarge),
                child: SectionTitleContainer(
                  name: 'recommended_for_you'.tr,
                  linkName: 'see_all'.tr,
                  linkUrl: Approute_allrecommendedpackages,
                  isLarge: true,
                ),
              ),
            ),
            Visibility(
              visible: flightBookingController.isInitialDataLoading.value,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge),
                child: SectionTitleContainerLoader(),
              ),
            ),
            Visibility(
                visible: !flightBookingController.isInitialDataLoading.value &&
                    flightBookingController.recommendedPackages.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  child: RecommendedForYouContainer(
                      packageBookingController:packageBookingController,
                      recommendedPackages:
                          flightBookingController.recommendedPackages),
                )),
            Visibility(
                visible: flightBookingController.isInitialDataLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  child: RecommendedForYouLoader(),
                )),

            //popular destinations
            Visibility(
              visible: !flightBookingController.isInitialDataLoading.value &&
                  flightBookingController.popularDestinations.isNotEmpty,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge),
                child: SectionTitleContainer(
                  name: 'popular_destinations'.tr,
                  linkName: 'see_all'.tr,
                  linkUrl: Approute_allpopulardestinations,
                  isLarge: true,
                ),
              ),
            ),
            Visibility(
              visible: flightBookingController.isInitialDataLoading.value,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge),
                child: SectionTitleContainerLoader(),
              ),
            ),
            Visibility(
                visible: !flightBookingController.isInitialDataLoading.value &&
                    flightBookingController.popularDestinations.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  child: PopularDestinationsContainer(
                      packageBookingController:packageBookingController,
                      popularDestinations:
                          flightBookingController.popularDestinations),
                )),
            Visibility(
                visible: flightBookingController.isInitialDataLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  child: PopularDestinationsLoader(),
                )),

            //travel stories
            Visibility(
              visible: !flightBookingController.isInitialDataLoading.value &&
                  flightBookingController.popularDestinations.isNotEmpty,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge),
                child: SectionTitleContainer(
                  name: 'travel_stories'.tr,
                  linkName: 'see_all'.tr,
                  linkUrl: Approute_alltravelstories,
                  isLarge: true,
                ),
              ),
            ),
            Visibility(
              visible: flightBookingController.isInitialDataLoading.value,
              child: Padding(
                padding: flyternMediumPaddingHorizontal.copyWith(
                    bottom: flyternSpaceLarge),
                child: SectionTitleContainerLoader(),
              ),
            ),
            Visibility(
                visible: !flightBookingController.isInitialDataLoading.value &&
                    flightBookingController.popularDestinations.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  child: TravelStoriesContainer(
                      travelStories: flightBookingController.travelStories),
                )),
            Visibility(
                visible: flightBookingController.isInitialDataLoading.value,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: flyternSpaceLarge * 2),
                  child: TravelStoriesLoader(),
                )),

            addVerticalSpace(flyternSpaceLarge),
          ],
        ),
      ),
    );
  }
}
