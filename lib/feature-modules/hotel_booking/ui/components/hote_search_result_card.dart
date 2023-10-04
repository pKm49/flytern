import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:ionicons/ionicons.dart';

class HotelSearchResultCard extends StatefulWidget {
  const HotelSearchResultCard({super.key});

  @override
  State<HotelSearchResultCard> createState() => _HotelSearchResultCardState();
}

class _HotelSearchResultCardState extends State<HotelSearchResultCard> {

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(flyternBorderRadiusExtraSmall),

              ),
              clipBehavior: Clip.hardEdge,
              width: screenwidth*.2,
              child: Image.asset(ASSETS_HOTEL_1_SAMPLE,width: screenwidth*.2)),
          addHorizontalSpace(flyternSpaceMedium),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex:4,
                      child: Text('Rixos Premium Dubai JBR',style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold),)),

                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Ionicons.star, color: flyternAccentColor,size: flyternFontSize20,),
                          addHorizontalSpace(flyternSpaceExtraSmall),
                          Text(
                            "4",
                            style: getBodyMediumStyle(context),
                          ),
                        ],
                      ))
                ],
              ),
              addVerticalSpace(flyternSpaceExtraSmall),
              Text('AED 1500',style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold, color: flyternSecondaryColor),),
              addVerticalSpace(flyternSpaceExtraSmall),
              Text('Free Wifi - Free Cancellation',style: getBodyMediumStyle(context) ),

            ],
          ))
        ],
      ),
    );
  }
}
