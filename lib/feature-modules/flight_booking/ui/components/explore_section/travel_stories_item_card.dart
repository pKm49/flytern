import 'package:flutter/material.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class TravelStoriesItemCard extends StatelessWidget {

  final String profilePicUrl;
  final String name;
  final double rating;
  final String description;
  final String imageUrl;

    TravelStoriesItemCard({super.key,
    required this.profilePicUrl,
    required this.name,
    required this.rating,
    required this.description,
    required this.imageUrl,
    });

  @override
  Widget build(BuildContext context) {

    for(var i=1;i<=5;i++){
      print("star iterations");
      print(i<=rating.round());
      print(rating < i+1 && rating > i);
    }

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      padding: flyternMediumPaddingAll,
      child: Wrap(
        children: [
          Row(
            children: [
              Container(
                height: screenwidth*.12,
                width: screenwidth*.12,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Image.asset(profilePicUrl),
              ),
              addHorizontalSpace(flyternSpaceMedium),
              Expanded(child: Text(name,style: getBodyMediumStyle(context).copyWith( color: flyternGrey80,fontWeight: flyternFontWeightBold),),
              )
            ],
          ),
          addVerticalSpace(flyternSpaceMedium),
          Row(
            children: [
              for(var i=1;i<=5;i++)
               Padding(
                 padding: const EdgeInsets.only(right:flyternSpaceSmall),
                 child: Icon(
                     rating < i+1 && rating > i ?
                     Ionicons.star_half:
                     i<=rating.round()?Ionicons.star:
                     Ionicons.star_outline,
                     color:
                     i<=rating.round()?
                     flyternAccentColor:flyternGrey40),
               ),

            ],
          ),
          addVerticalSpace(flyternSpaceMedium),
          Text( description,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
          addVerticalSpace(flyternSpaceMedium),

          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                  imageUrl,width: screenwidth - (flyternSpaceMedium*2) )),
        ],
      ),
    );
  }
}
