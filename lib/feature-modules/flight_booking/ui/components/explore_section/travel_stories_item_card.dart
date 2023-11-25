import 'package:flutter/material.dart';
import 'package:flytern/shared-module/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class TravelStoriesItemCard extends StatelessWidget {
  final String profilePicUrl;
  final String name;
  final String ratings;
  final String description;
  final String title;
  final String status;
  final DateTime createdOn;
  final String imageUrl;

  TravelStoriesItemCard({
    super.key,
    required this.profilePicUrl,
    required this.name,
    required this.status,
    required this.ratings,
    required this.description,
    required this.title,
    required this.createdOn,
    required this.imageUrl,
  });

  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    rating = double.parse(ratings);

    for (var i = 1; i <= 5; i++) {
      print("star iterations");
      print(i <= rating.round());
      print(rating < i + 1 && rating > i);
    }

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      padding: flyternMediumPaddingAll,
      child: Wrap(
        runSpacing: flyternSpaceMedium,
        children: [
          Row(
            children: [
              Container(
                  height: screenwidth * .12,
                  width: screenwidth * .12,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Image.network(
                    profilePicUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Ionicons.person_circle,size: screenwidth*.12);

                    },
                  )),
              addHorizontalSpace(flyternSpaceMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: getBodyMediumStyle(context).copyWith(
                          color: flyternGrey80, fontWeight: flyternFontWeightBold),
                    ),
                    addVerticalSpace(flyternSpaceExtraSmall),
                    Visibility(
                      visible: createdOn != DefaultInvalidDate,
                      child: Text(
                      getFormattedDate(createdOn),
                      style: getLabelLargeStyle(context).copyWith(
                          color: flyternGrey40),
                    ),)
                  ],
                ),
              ),
              Visibility(
                  visible: status !="",
                  child: OutlinedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(  TextStyle(
                          color:status=="Published"? flyternPrimaryColor:flyternSecondaryColor)),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(status=="Published"? flyternPrimaryColor:flyternSecondaryColor),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: flyternSpaceLarge,
                              vertical: flyternSpaceSmall)),
                    ),
                onPressed: (){},
                child: Text(         status),
              ))
            ],
          ),
          Visibility(
            visible: title !="",
            child: Text(title,
                style:
                getHeadlineMediumStyle(context).copyWith(color: flyternGrey80,fontWeight: flyternFontWeightBold)),
          ),
          Row(
            children: [
              for (var i = 1; i <= 5; i++)
                Padding(
                  padding: const EdgeInsets.only(right: flyternSpaceSmall),
                  child: Icon(
                      rating < i + 1 && rating > i
                          ? Ionicons.star_half
                          : i > roundedRating(rating)
                              ? Ionicons.star_outline
                              : Ionicons.star,
                      color: i <= rating.round()
                          ? flyternAccentColor
                          : flyternGrey40),
                ),
            ],
          ),
          Visibility(
            visible: description !="",
            child: Text(description,
                style:
                    getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
          ),

          Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                imageUrl,
                width: screenwidth - (flyternSpaceMedium * 2),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ASSETS_DESTINATION_1_SAMPLE,
                      width: screenwidth - (flyternSpaceMedium * 2));
                },
              )),
        ],
      ),
    );
  }

  num roundedRating(double rating) {
    return rating.round()>rating?rating-1:rating.round();
  }

  getFormattedDate(DateTime dateTime){
    final f = DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }
}
