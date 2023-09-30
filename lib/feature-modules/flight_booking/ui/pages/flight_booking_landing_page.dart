import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_form.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_type_tab.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/popular_package_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/recommended_item_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:ionicons/ionicons.dart';

class FlightBookingLandingPage extends StatefulWidget {
  const FlightBookingLandingPage({super.key});

  @override
  State<FlightBookingLandingPage> createState() =>
      _FlightBookingLandingPageState();
}

class _FlightBookingLandingPageState extends State<FlightBookingLandingPage>
    with SingleTickerProviderStateMixin {
  int selectedTab = 1;

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
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(flyternSpaceLarge),
            height: (screenheight * .7) + (flyternSpaceLarge * 2.5),
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
                      height: screenheight * .675,
                      decoration: flyternShadowedContainerSmallDecoration,
                      width: screenwidth - (flyternSpaceLarge * 2),
                      padding: flyternMediumPaddingAll,
                      child: FlightBookingForm(selectedTab: selectedTab),
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
                                  });
                                },
                                index: 1,
                                icon: Ionicons.arrow_forward_outline,
                                label: 'One Way',
                                selectedTab: selectedTab,
                              ),
                            ),
                            addHorizontalSpace(flyternSpaceSmall),
                            Expanded(
                              child: FlightTypeTab(
                                onPressed: () {
                                  setState(() {
                                    selectedTab = 2;
                                  });
                                },
                                index: 2,
                                icon: Ionicons.swap_horizontal_outline,
                                label: 'Round Trip',
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
                                label: 'Multi City',
                                selectedTab: selectedTab,
                              ),
                            )
                          ],
                        )),
                    Container(
                      height: screenheight * .65,
                      width: screenwidth - (flyternSpaceLarge * 2),
                    )
                  ],
                )
              ],
            ),
          ),
          addVerticalSpace(flyternSpaceLarge),
          Padding(
            padding: flyternMediumPaddingHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Recommended For You',
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'See All',
                          style: getBodyMediumStyle(context)
                              .copyWith(color: flyternTertiaryColor),
                        ),
                        addHorizontalSpace(flyternSpaceExtraSmall),
                        Icon(Ionicons.chevron_forward,
                            color: flyternTertiaryColor,
                            size: flyternFontSize20)
                      ],
                    ))
              ],
            ),
          ),
          addVerticalSpace(flyternSpaceLarge),
          Container(
              width: screenwidth,
              height: screenwidth * .7,
              padding: flyternMediumPaddingHorizontal,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlightRecommendedItemCard(
                      imageUrl: ASSETS_RECOMMENDED_1_SAMPLE,
                      title: "Four Seasons Resort Bora Bora",
                      rating: 4.4
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  FlightRecommendedItemCard(
                      imageUrl: ASSETS_RECOMMENDED_1_SAMPLE,
                      title: "Four Seasons Resort Bora Bora",
                      rating: 4.4
                  ),
                  addHorizontalSpace(flyternSpaceMedium),
                  FlightRecommendedItemCard(
                      imageUrl: ASSETS_RECOMMENDED_1_SAMPLE,
                      title: "Four Seasons Resort Bora Bora",
                      rating: 4.4
                  ),
                ],
              )),
          addVerticalSpace(flyternSpaceLarge),
          addVerticalSpace(flyternSpaceLarge),
          Padding(
            padding: flyternMediumPaddingHorizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Popular Destinations',
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternGrey80,
                        fontWeight: flyternFontWeightBold),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'See All',
                          style: getBodyMediumStyle(context)
                              .copyWith(color: flyternTertiaryColor),
                        ),
                        addHorizontalSpace(flyternSpaceExtraSmall),
                        Icon(Ionicons.chevron_forward,
                            color: flyternTertiaryColor,
                            size: flyternFontSize20)
                      ],
                    ))
              ],
            ),
          ),
          addVerticalSpace(flyternSpaceLarge),
          Container(
            color: flyternBackgroundWhite,
            child: Wrap(
              children: [
                PopularPackageListCard(
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Kabul Holiday Package',
                  destination: 'Japan',
                  rating: 4.4,
                  price: 15000,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                  child: Divider(),
                ),
                PopularPackageListCard(
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Kabul Holiday Package',
                  destination: 'Japan',
                  rating: 4.4,
                  price: 15000,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
                  child: Divider(),
                ),
                PopularPackageListCard(
                  imageUrl: ASSETS_PACKAGE_1_SAMPLE,
                  title: 'Kabul Holiday Package',
                  destination: 'Japan',
                  rating: 4.4,
                  price: 15000,
                ),
              ],
            ),
          ),
          addVerticalSpace(flyternSpaceLarge),
        ],
      ),
    );
  }
}
