import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class PackageListCard extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String flightName;
  final String hotelName;
  final String sponsoredBy;
  final String currency;
  final double price;
  final String ratings;
  final GestureTapCallback packageSelected;

    PackageListCard({
      super.key,
    required this.imageUrl,
    required this.title,
    required this.flightName,
    required this.hotelName,
    required this.sponsoredBy,
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
        decoration:  BoxDecoration(
          color: flyternBackgroundWhite,
        ),
        padding: flyternMediumPaddingAll,
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                clipBehavior: Clip.hardEdge,
                child:Image.network(imageUrl,width: screenwidth*.25, height:  screenwidth*.25,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(ASSETS_PACKAGE_1_SAMPLE,width: screenwidth*.25, height:  screenwidth*.25);
                    }), ),
            addHorizontalSpace(flyternSpaceMedium),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  maxLines: 2,
                  style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold),),

                addVerticalSpace(flyternSpaceSmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${currency} ${price}",style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold, color: flyternSecondaryColor),),
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
                              ratings ,
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
                    Expanded(child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Ionicons.share_social_outline,color: flyternGrey40),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text(flightName,
                            style:  getBodyMediumStyle(context).copyWith(color: flyternGrey40)),
                      ],
                    ),),

                    addHorizontalSpace(flyternSpaceSmall),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                        Icon(Ionicons.airplane_outline,color: flyternGrey40),
                        addHorizontalSpace(flyternSpaceSmall),
                        Text(sponsoredBy,style: getBodyMediumStyle(context).copyWith(color: flyternGrey40),),
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
