import 'package:flutter/material.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:ionicons/ionicons.dart';

class FlightRecommendedItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;

    FlightRecommendedItemCard({super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    });

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;


    return Container(
      width: screenwidth * .7,
      alignment: Alignment.bottomCenter,
      height: screenwidth * .7,
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(flyternBorderRadiusExtraSmall),
        image:   DecorationImage(
          image:  NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(

        padding: flyternSmallPaddingAll,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Color(0xff000000)],
              stops: [0, 0.8],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                maxLines: 1,
                style: getBodyMediumStyle(context).copyWith(
                    color: flyternBackgroundWhite,
                    fontWeight: flyternFontWeightBold),
              ),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Ionicons.star, color: flyternAccentColor),
                    addHorizontalSpace(flyternSpaceExtraSmall),
                    Text(
                      rating.toString(),
                      style: getBodyMediumStyle(context)
                          .copyWith(color: flyternBackgroundWhite),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
