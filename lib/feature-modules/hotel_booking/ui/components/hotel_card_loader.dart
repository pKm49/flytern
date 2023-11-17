import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:shimmer/shimmer.dart';

class HotelCardLoader extends StatelessWidget {

  HotelCardLoader({super.key });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    return  Container(
      color: flyternBackgroundWhite,
      child: Wrap(
        children: [
          Container(
            decoration:  BoxDecoration(
              color: flyternBackgroundWhite,
            ),
            padding: flyternMediumPaddingAll,
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color:flyternGrey10,
                      borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth*.25,
                    height: screenwidth*.25,
                  ),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                      ],
                    ))

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
            child: Divider(),
          ),
          Container(
            decoration:  BoxDecoration(
              color: flyternBackgroundWhite,
            ),
            padding: flyternMediumPaddingAll,
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color:flyternGrey10,
                      borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth*.25,
                    height: screenwidth*.25,
                  ),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                      ],
                    ))

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
            child: Divider(),
          ),
          Container(
            decoration:  BoxDecoration(
              color: flyternBackgroundWhite,
            ),
            padding: flyternMediumPaddingAll,
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color:flyternGrey10,
                      borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth*.25,
                    height: screenwidth*.25,
                  ),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                      ],
                    ))

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
            child: Divider(),
          ),
          Container(
            decoration:  BoxDecoration(
              color: flyternBackgroundWhite,
            ),
            padding: flyternMediumPaddingAll,
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color:flyternGrey10,
                      borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth*.25,
                    height: screenwidth*.25,
                  ),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                      ],
                    ))

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: flyternSpaceMedium),
            child: Divider(),
          ),
          Container(
            decoration:  BoxDecoration(
              color: flyternBackgroundWhite,
            ),
            padding: flyternMediumPaddingAll,
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: flyternBackgroundWhite,
                  highlightColor: flyternGrey20,
                  child: Container(
                    decoration: BoxDecoration(
                      color:flyternGrey10,
                      borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                    ),
                    width: screenwidth*.25,
                    height: screenwidth*.25,
                  ),
                ),
                addHorizontalSpace(flyternSpaceMedium),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                        addVerticalSpace(flyternSpaceSmall),
                        Shimmer.fromColors(
                          baseColor: flyternBackgroundWhite,
                          highlightColor: flyternGrey20,
                          child: Container(
                            decoration: BoxDecoration(
                              color:flyternGrey10,
                              borderRadius:
                              BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            height: 30,
                            width: screenwidth*.4,
                          ),
                        ),
                      ],
                    ))

              ],
            ),
          ),
        ],
      ),
    );
  }

}
