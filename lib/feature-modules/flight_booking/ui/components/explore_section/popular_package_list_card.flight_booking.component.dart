import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:ionicons/ionicons.dart';

class PopularPackageListCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String destination;
  final double price;
  final String rating;

  PopularPackageListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.destination,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
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
              child: Image.network(
                imageUrl,
                width: screenwidth * .25,
                height: screenwidth * .25,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ASSETS_DESTINATION_1_SAMPLE,width: screenwidth*.25, height:  screenwidth*.25);
                },
              )),
          addHorizontalSpace(flyternSpaceMedium),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      title,
                      style: getBodyMediumStyle(context)
                          .copyWith(fontWeight: flyternFontWeightBold),
                    ),
                  ),
                  addHorizontalSpace(flyternSpaceSmall),
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
                            rating.toString(),
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80),
                          ),
                        ],
                      )),
                ],
              ),
              addVerticalSpace(flyternSpaceSmall),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'AED 15,000',
                    style: getBodyMediumStyle(context).copyWith(
                        fontWeight: flyternFontWeightBold,
                        color: flyternSecondaryColor),
                  ),
                ],
              ),
              addVerticalSpace(flyternSpaceSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Ionicons.location_outline, color: flyternGrey40),
                  addHorizontalSpace(flyternSpaceSmall),
                  Text(
                    destination,
                    style: getBodyMediumStyle(context)
                        .copyWith(color: flyternGrey40),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
