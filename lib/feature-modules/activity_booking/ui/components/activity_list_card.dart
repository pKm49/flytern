import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ActivityListCard extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String flightName;
  final String hotelName;
  final String sponsoredBy;
  final double price;
  final GestureTapCallback onPressed;


    ActivityListCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.flightName,
    required this.hotelName,
    required this.sponsoredBy,
    required this.price,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap:onPressed ,
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
                child: Image.asset(imageUrl,width: screenwidth*.25, height:  screenwidth*.25)),
            addHorizontalSpace(flyternSpaceMedium),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold),),

                addVerticalSpace(flyternSpaceSmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('AED 15,000',style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold, color: flyternSecondaryColor),),


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
                        Icon(Ionicons.location_outline,color: flyternGrey40),
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
