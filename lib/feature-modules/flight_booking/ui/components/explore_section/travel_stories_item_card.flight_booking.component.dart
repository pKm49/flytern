import 'package:flutter/material.dart';
import 'package:flytern/shared-module/constants/app_specific/default_values.shared.constant.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class TravelStoriesItemCard extends StatefulWidget {
  final String profilePicUrl;
  final String name;
  final String ratings;
  final String description;
  final String title;
  final String status;
  final DateTime createdOn;
  final String imageUrl;
  final String fileType;
  final String previewImgUrl;

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
    required this.fileType,
    required this.previewImgUrl,
  });

  @override
  State<TravelStoriesItemCard> createState() => _TravelStoriesItemCardState();
}

class _TravelStoriesItemCardState extends State<TravelStoriesItemCard> {
  double rating = 0.0;


  @override
  Widget build(BuildContext context) {
    rating = double.parse(widget.ratings);

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
                    widget.profilePicUrl,
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
                      widget.name,
                      style: getBodyMediumStyle(context).copyWith(
                          color: flyternGrey80, fontWeight: flyternFontWeightBold),
                    ),
                    addVerticalSpace(flyternSpaceExtraSmall),
                    Visibility(
                      visible: widget.createdOn != DefaultInvalidDate,
                      child: Text(
                      getFormattedDate(widget.createdOn),
                      style: getLabelLargeStyle(context).copyWith(
                          color: flyternGrey40),
                    ),)
                  ],
                ),
              ),
              Visibility(
                  visible: widget.status !="",
                  child: OutlinedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(  TextStyle(
                          color:widget.status=="Published"? flyternPrimaryColor:flyternSecondaryColor)),
                      foregroundColor:
                      MaterialStateProperty.all<Color>(widget.status=="Published"? flyternPrimaryColor:flyternSecondaryColor),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: flyternSpaceLarge,
                              vertical: flyternSpaceSmall)),
                    ),
                onPressed: (){},
                child: Text(         widget.status),
              ))
            ],
          ),
          Visibility(
            visible: widget.title !="",
            child: Text(widget.title,
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
            visible: widget.description !="",
            child: Text(widget.description,
                style:
                    getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
          ),
          Visibility(
            visible: widget.fileType == "VIDEO",
            child: Container(
                width: screenwidth - (flyternSpaceLarge * 2),
                color: flyternSecondaryColorBg,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: screenwidth - (flyternSpaceMedium * 2),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          widget.previewImgUrl,
                          height: screenheight*.25,
                          width: screenwidth - (flyternSpaceMedium * 2),
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(ASSETS_DESTINATION_1_SAMPLE,
                                width: screenwidth - (flyternSpaceMedium * 2));
                          },
                        ),
                        Container(
                          height: screenheight*.25,
                          color: flyternTertiaryColorBg,
                          width: screenwidth - (flyternSpaceMedium * 2),
                          child: Center(
                            child: InkWell(
                              onTap: (){
                                Get.toNamed(Approute_videoViewer, arguments: [
                                  widget.imageUrl
                                ]);
                              },
                              child: Icon(
                                  Ionicons.play_circle_outline,
                              size: screenwidth*.3,
                                color: flyternBackgroundWhite,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),
          ),
          Visibility(
            visible: widget.fileType == "IMAGE",
            child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  widget.imageUrl,
                  width: screenwidth - (flyternSpaceMedium * 2),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(ASSETS_DESTINATION_1_SAMPLE,
                        width: screenwidth - (flyternSpaceMedium * 2));
                  },
                )),
          ),
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
