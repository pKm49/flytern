import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:ionicons/ionicons.dart';

class PackageListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String fromTo;
  final String hotelName;
  final String airline;
  final String currency;
  final double price;
  final String ratings;
  final GestureTapCallback packageSelected;

  PackageListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.fromTo,
    required this.hotelName,
    required this.airline,
    required this.price,
    required this.currency,
    required this.ratings,
    required this.packageSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: packageSelected,
      child: Container(
        decoration: BoxDecoration(
          color: flyternBackgroundWhite,
        ),
        padding: flyternMediumPaddingAll,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(imageUrl,
                  width: screenwidth * .25, height: screenwidth * .25,
                  errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: screenwidth * .25,
                  height: screenwidth * .25,
                  color: flyternGrey20,
                );
              }),
            ),
            addHorizontalSpace(flyternSpaceMedium),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  style: getBodyMediumStyle(context)
                      .copyWith(fontWeight: flyternFontWeightBold),
                ),
                addVerticalSpace(flyternSpaceSmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${currency} ${price.toStringAsFixed(3)}",
                      style: getBodyMediumStyle(context).copyWith(
                          fontWeight: flyternFontWeightBold,
                          color: flyternSecondaryColor),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Ionicons.star,
                                color: flyternAccentColor,
                                size: flyternFontSize20),
                            addHorizontalSpace(flyternSpaceExtraSmall),
                            Text(
                              ratings,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey80),
                            ),
                          ],
                        )),
                  ],
                ),
                addVerticalSpace(flyternSpaceSmall),
                Visibility(
                  visible: airline !="" || fromTo !="",
                  child: Row(
                    children: [
                      Visibility(
                        visible: fromTo !="",
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Ionicons.location_outline,
                                  color: flyternGrey40),
                              addHorizontalSpace(flyternSpaceSmall),
                              Text(fromTo,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey40)),
                            ],
                          ),
                        ),
                      ),
                      addHorizontalSpace(flyternSpaceSmall),
                      Visibility(
                        visible: airline !="",
                        child: Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Ionicons.airplane_outline,
                                    color: flyternGrey40),
                                addHorizontalSpace(flyternSpaceSmall),
                                Text(
                                  airline,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey40),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
