import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_data.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ActivityListCard extends StatelessWidget {
  final ActivityData activityData;

  final GestureTapCallback onPressed;

  ActivityListCard({
    super.key,
    required this.activityData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: flyternBackgroundWhite,
        ),
        padding: flyternMediumPaddingAll,
        child: Row(
          children: [
            Container(
                width: screenwidth * .25,
                height: screenwidth * .25,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(activityData.imagePath,
                    width: screenwidth * .25, height: screenwidth * .25,
                    errorBuilder: (context, error, stackTrace) {
                  return Container(
                      color: flyternGrey10,
                      width: screenwidth * .25,
                      height: screenwidth * .25);
                })),
            addHorizontalSpace(flyternSpaceMedium),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activityData.tourName,
                  style: getBodyMediumStyle(context)
                      .copyWith(fontWeight: flyternFontWeightBold),
                ),
                addVerticalSpace(flyternSpaceSmall),
                Row(
                  children: [
                    Expanded(
                      child:      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${activityData.currency} ${activityData.price}',
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightBold,
                                color: flyternSecondaryColor),
                          ),
                        ],
                      ),
                    ),
                    addHorizontalSpace(flyternSpaceSmall),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Ionicons.star,
                                color: flyternAccentColor,
                                size: flyternFontSize20),
                            addHorizontalSpace(flyternSpaceExtraSmall),
                            Text(
                              activityData.rating.toString(),
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey80),
                            ),
                            addHorizontalSpace(flyternSpaceExtraSmall),
                            Text(
                              "(${activityData.reviewCount.toString()})",
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey80),
                            ),
                          ],
                        )),
                  ],
                ),
                addVerticalSpace(flyternSpaceSmall),
                Row(
                  children: [
                    // Expanded(child:  Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Icon(Ionicons.ticket_outline,color: flyternGrey40),
                    //     addHorizontalSpace(flyternSpaceSmall),
                    //     Text(flightName,
                    //         style:  getBodyMediumStyle(context).copyWith(color: flyternGrey40)),
                    //   ],
                    // ),),
                    //
                    // addHorizontalSpace(flyternSpaceSmall),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Ionicons.time_outline,
                                color: flyternGrey40,
                            size: flyternFontSize20),
                            addHorizontalSpace(flyternSpaceSmall),
                            Text(
                              activityData.duration,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey40),
                            ),
                          ],
                        )),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
