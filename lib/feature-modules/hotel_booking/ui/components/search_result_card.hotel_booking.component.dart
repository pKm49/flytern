import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';

import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';

import 'package:ionicons/ionicons.dart';

class HotelSearchResultCard extends StatefulWidget {
  HotelSearchResponse hotelSearchResponse;
  final GestureTapCallback onPressed;

  HotelSearchResultCard(  {super.key,
    required this.hotelSearchResponse,
    required this.onPressed

  });

  @override
  State<HotelSearchResultCard> createState() => _HotelSearchResultCardState();
}

class _HotelSearchResultCardState extends State<HotelSearchResultCard> {

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap:widget.onPressed,
      child: Container(
        padding: flyternMediumPaddingVertical,
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(flyternBorderRadiusExtraSmall),

                ),
                clipBehavior: Clip.hardEdge,
                width: screenwidth*.2,
                child: Image.network(widget.hotelSearchResponse.imageUrl,
                      height: screenwidth * .2,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                          color: flyternGrey10,
                          height: screenwidth * .2,
                      child: Center(
                        child: Icon(Icons.business,color: flyternGrey40,),
                      ),);
                    })  ),
            addHorizontalSpace(flyternSpaceMedium),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.hotelSearchResponse.hotelName} ",style: getBodyMediumStyle(context).copyWith(
                    fontWeight: flyternFontWeightBold),),


                addVerticalSpace(flyternSpaceExtraSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(child: Row(
                      children: [
                        for(var i = 1; i <= 5; i++)
                          Padding(
                            padding: const EdgeInsets.only(
                                right: flyternSpaceExtraSmall),
                            child: Icon(
                               i<= widget.hotelSearchResponse.rating.round()  ? Ionicons.star :
                                Ionicons.star_outline,
                                color:
                                i <= widget.hotelSearchResponse.rating.round()  ?
                                flyternAccentColor : flyternGrey40,size: flyternFontSize12,),
                          ),

                      ],
                    )),
                    Expanded(
                      child: Text("${widget.hotelSearchResponse.priceUnit} ${widget.hotelSearchResponse.fromPrice.toStringAsFixed(3)}",style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold, color: flyternSecondaryColor),textAlign: TextAlign.end,),
                    ),


                  ],
                ),
                addVerticalSpace(flyternSpaceExtraSmall),
                Text(widget.hotelSearchResponse.location,
                    maxLines: 1,
                    style: getBodyMediumStyle(context) ),

              ],
            ))
          ],
        ),
      ),
    );
  }
}
