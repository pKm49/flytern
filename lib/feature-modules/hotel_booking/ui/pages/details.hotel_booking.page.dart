import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/room_option.hotel_booking.model.dart';
import 'package:flytern/shared-module/services/utility-services/element_style_helper.shared.service.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetailsPage extends StatefulWidget {
  const HotelDetailsPage({super.key});

  @override
  State<HotelDetailsPage> createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage> {
  final hotelBookingController = Get.find<HotelBookingController>();
  var elementStyleHelpers = ElementStyleHelpers();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("hotel_details".tr),
          // title: Text(hotelBookingController.hotelDetails.value.name),
          elevation: 0.5,
        ),
        body: Container(
            width: screenwidth,
            height: screenheight,
            color: flyternBackgroundWhite,
            child: Stack(
              children: [
                Visibility(
                  visible: !hotelBookingController.isHotelDetailsLoading.value &&
                      hotelBookingController.hotelDetails.value.hotelId == 0  ,
                  child: Container(
                    padding: flyternMediumPaddingAll,
                    margin: flyternLargePaddingAll,
                    decoration: BoxDecoration(
                      color: flyternPrimaryColorBg,
                      borderRadius: BorderRadius.circular(
                          flyternBorderRadiusExtraSmall),
                    ),
                    child: Html(
                      data:
                          hotelBookingController.hotelDetails.value.alertMsg,
                    ),
                  ),
                ),
                Visibility(
                  visible: !hotelBookingController
                          .isHotelDetailsLoading.value &&
                      hotelBookingController.hotelDetails.value.hotelId != 0,
                  child: Container(
                    child: ListView(
                      children: [
                        Visibility(
                          visible:
                              hotelBookingController.selectedImageIndex.value >
                                      -1 &&
                                  getSelectedImageUrl() != "",
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(Approute_imageViewer, arguments: [
                                hotelBookingController
                                        .hotelDetails.value.imageUrls[
                                    hotelBookingController
                                        .selectedImageIndex.value],
                                hotelBookingController
                                    .hotelDetails.value.imageUrls
                              ]);
                            },
                            child: Container(
                              width: screenwidth,
                              height: screenwidth,
                              clipBehavior: Clip.hardEdge,
                              //default is none
                              decoration: BoxDecoration(
                                color: flyternGrey10,
                              ),
                              child: Image.network(
                                  hotelBookingController
                                              .selectedImageIndex.value >
                                          -1
                                      ? hotelBookingController
                                              .hotelDetails.value.imageUrls[
                                          hotelBookingController
                                              .selectedImageIndex.value]
                                      : "",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: flyternGrey10,
                                  height: screenwidth,
                                  child: Center(
                                    child: Icon(
                                      Icons.business,
                                      color: flyternGrey40,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: hotelBookingController
                              .hotelDetails.value.imageUrls.isNotEmpty,
                          child: Container(
                            padding: flyternLargePaddingAll.copyWith(
                                bottom: 0, top: 0),
                            margin: flyternLargePaddingVertical,
                            color: flyternBackgroundWhite,
                            height: screenwidth * .15,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var i = 0;
                                    i <
                                        hotelBookingController.hotelDetails
                                            .value.imageUrls.length;
                                    i++)
                                  InkWell(
                                    onTap: () {
                                      hotelBookingController
                                          .changeSelectedImage(i);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                flyternBorderRadiusExtraSmall),
                                            border: Border.all(
                                                color: i ==
                                                        hotelBookingController
                                                            .selectedImageIndex
                                                            .value
                                                    ? flyternSecondaryColor
                                                    : Colors.transparent,
                                                width: 2)),
                                        margin: EdgeInsets.only(
                                            right: flyternSpaceSmall),
                                        clipBehavior: Clip.hardEdge,
                                        height: screenwidth * .16,
                                        child: Image.network(
                                            hotelBookingController.hotelDetails
                                                .value.imageUrls[i],
                                            height: screenwidth * .2, errorBuilder:
                                                (context, error, stackTrace) {
                                          return Container(
                                            color: flyternGrey10,
                                            height: screenwidth * .2,
                                            child: Center(
                                              child: Icon(
                                                Icons.business,
                                                color: flyternGrey40,
                                              ),
                                            ),
                                          );
                                        })),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: hotelBookingController
                                  .hotelDetails.value.hotelName !=
                              "",
                          child: Container(
                            padding: flyternLargePaddingAll.copyWith(
                                bottom: 0, top: 0),
                            color: flyternBackgroundWhite,
                            child: Text(
                                hotelBookingController
                                    .hotelDetails.value.hotelName,
                                style: getHeadlineMediumStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold)),
                          ),
                        ),
                        Visibility(
                          visible: hotelBookingController
                                  .hotelDetails.value.hotelName !=
                              "",
                          child: Container(
                              padding: flyternLargePaddingAll.copyWith(
                                  top: flyternSpaceMedium,
                                  bottom: flyternSpaceExtraSmall),
                              color: flyternBackgroundWhite,
                              child:Row(
                                children: [
                                  for(var i = 1; i <= 5; i++)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: flyternSpaceExtraSmall),
                                      child: Icon(
                                        i<= hotelBookingController.hotelDetails.value.rating.round()  ? Ionicons.star :
                                        Ionicons.star_outline,
                                        color:
                                        i <=hotelBookingController.hotelDetails.value.rating.round()  ?
                                        flyternAccentColor : flyternGrey40,size: flyternFontSize14,),
                                    ),

                                ],
                              ),  ),
                        ),

                        Visibility(
                            visible: hotelBookingController
                                    .hotelDetails.value.location !=
                                "",
                            child: addVerticalSpace(flyternSpaceMedium)),

                        Visibility(
                          visible: hotelBookingController
                                  .hotelDetails.value.location !=
                              "",
                          child: Padding(
                            padding: flyternMediumPaddingHorizontal,
                            child: InkWell(
                              onTap: () {
                                _launchUrl(hotelBookingController
                                    .hotelDetails.value.locationurl);
                              },
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: flyternSecondaryColor,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(
                                            flyternBorderRadiusExtraSmall),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      width: screenwidth * .25,
                                      child: Image.asset(ASSETS_LOCATION_ICON,
                                          width: screenwidth * .25)),
                                  addHorizontalSpace(flyternSpaceMedium),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hotelBookingController
                                            .hotelDetails.value.location,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: flyternGrey80),
                                      ),
                                      addVerticalSpace(flyternSpaceExtraSmall),
                                      Text(
                                        hotelBookingController
                                            .hotelDetails.value.address,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(
                                          color: flyternGrey60,
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: hotelBookingController
                                    .hotelDetails.value.location !=
                                "",
                            child: addVerticalSpace(flyternSpaceSmall)),
                        Visibility(
                            visible: hotelBookingController
                                    .hotelDetails.value.descriptionInfo !=
                                "",
                            child: Divider()),
                        Visibility(
                          visible: hotelBookingController
                                  .hotelDetails.value.descriptionInfo !=
                              "",
                          child: Container(
                            padding: flyternLargePaddingAll.copyWith(
                                top: flyternSpaceSmall,
                                bottom: flyternSpaceSmall),
                            color: flyternBackgroundWhite,
                            child: Text(
                                hotelBookingController
                                    .hotelDetails.value.descriptionInfo,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                          ),
                        ),
                        addVerticalSpace(flyternSpaceLarge),
                        Visibility(
                          visible:  hotelBookingController
                              .hotelDetails.value.amenitys.isNotEmpty,
                          child: Container(
                              width: screenwidth,
                              color: flyternGrey10,
                              height: 1),
                        ),
                        Visibility(
                          visible:  hotelBookingController
                              .hotelDetails.value.amenitys.isNotEmpty,
                          child: Container(
                            padding: flyternLargePaddingAll,
                            width: screenwidth,
                            height: screenwidth * .22 + (flyternSpaceLarge * 2),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: hotelBookingController
                                    .hotelDetails.value.amenitys.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: flyternSpaceMedium),
                                    width: screenwidth * .2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.network(
                                            hotelBookingController.hotelDetails
                                                .value.amenitys[i].imagePath,
                                            height: screenwidth * .1,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                          return Container(
                                              color: flyternGrey10,
                                              height: screenwidth * .1);
                                        }),
                                        addVerticalSpace(flyternSpaceSmall),
                                        Text(
                                          hotelBookingController.hotelDetails
                                              .value.amenitys[i].amenityName,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: getLabelLargeStyle(context)
                                              .copyWith(color: flyternGrey60),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),

                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() ==
                                      0 &&
                                  hotelBookingController
                                          .hotelDetails.value.alertMsg !=
                                      "",
                          child: Container(
                            color: flyternGrey10,
                            child: Container(
                              padding: flyternMediumPaddingAll,
                              margin: flyternLargePaddingAll,
                              decoration: BoxDecoration(
                                color: flyternPrimaryColorBg,
                                borderRadius: BorderRadius.circular(
                                    flyternBorderRadiusExtraSmall),
                              ),
                              child: Html(
                                data: hotelBookingController
                                    .hotelDetails.value.alertMsg,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Container(
                            padding: flyternLargePaddingAll,
                            width: screenwidth,
                            color: flyternGrey10,
                            child: Text(
                              "room_selection".tr,
                              style: getHeadlineMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold),
                            ),
                          ),
                        ),
                        // Visibility(
                        //   visible: hotelBookingController
                        //           .hotelSearchData.value.rooms.length >
                        //       1,
                        //   child: Container(
                        //     padding: flyternLargePaddingAll,
                        //     width: screenwidth,
                        //     height: 77,
                        //     child: ListView.builder(
                        //         scrollDirection: Axis.horizontal,
                        //         itemCount: hotelBookingController
                        //             .hotelDetails.value.rooms.length,
                        //         itemBuilder: (context, i) {
                        //           return Padding(
                        //             padding: EdgeInsets.only(
                        //                 right: flyternSpaceMedium),
                        //             child: SelectableTilePill(
                        //               onPressed: () {
                        //                 hotelBookingController
                        //                     .changeSelectedRoomSelectionIndex(
                        //                         i);
                        //               },
                        //               label:
                        //                   "${hotelBookingController.hotelDetails.value.rooms[i].roomDisplayNo} - ${hotelBookingController.hotelDetails.value.rooms[i].roomref}",
                        //               isSelected: i ==
                        //                   hotelBookingController
                        //                       .selectedRoomSelectionIndex.value,
                        //               themeNumber: 2,
                        //             ),
                        //           );
                        //         }),
                        //   ),
                        // ),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Padding(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: hotelBookingController
                                            .hotelDetails.value.rooms.length >
                                        2
                                    ? 0
                                    : flyternSpaceMedium,
                                bottom: flyternSpaceExtraSmall),
                            child: Container(
                              padding: flyternSmallPaddingAll,
                              decoration:
                                  flyternBorderedContainerSmallDecoration
                                      .copyWith(
                                          color: flyternGrey10,
                                          border: Border.all(
                                              color: flyternGrey10, width: .2)),
                              child: DropdownButton<HotelRoomOption>(
                                itemHeight: 110 + flyternSpaceMedium,
                                icon: Icon(Ionicons.caret_down,
                                    color: flyternGrey60),
                                value: hotelBookingController
                                    .getSelectedRoomOption(),
                                iconSize: flyternFontSize16,
                                isExpanded: true,
                                elevation: 16,
                                borderRadius: BorderRadius.all(
                                    const Radius.circular(
                                        flyternBorderRadiusExtraSmall)),
                                style: TextStyle(
                                    fontSize: screenwidth * .035,
                                    color: flyternGrey60),
                                underline: Container(
                                  height: 1,
                                ),
                                onChanged: (HotelRoomOption? Value) {
                                  if (Value != null) {
                                    hotelBookingController
                                        .changeSelectedRoomOptionForIndex(
                                            Value);
                                  }
                                },
                                items:hotelBookingController
                                    .getRoomOptions().asMap().map((i, value) =>
                                    MapEntry(i, DropdownMenuItem<HotelRoomOption>(
                                      value: value,
                                      child: Container(

                                        decoration: BoxDecoration(
                                            border:hotelBookingController.selectedRoomOption.value.isNotEmpty?
                                            hotelBookingController.selectedRoomOption.value[0].roomOptionid !=value.roomOptionid?
                                            Border(
                                              top: BorderSide(
                                                color: i==0?Colors.transparent:flyternGrey20,
                                                width: 1.0,
                                              ),
                                              bottom: BorderSide(
                                                color: i==(hotelBookingController
                                                    .getRoomOptions().length-1)?Colors.transparent: flyternGrey20,
                                                width:  1.0,
                                              ),
                                            ):null:null
                                        ),
                                        padding: flyternSmallPaddingVertical,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                    visible: value
                                                        .imageURLs.isNotEmpty,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .only(
                                                          right:
                                                          flyternSpaceMedium),
                                                      child: Image.network(
                                                          value.imageURLs
                                                              .isNotEmpty
                                                              ? value.imageURLs[0]
                                                              : "",
                                                          height: 80 -
                                                              flyternSpaceSmall),
                                                    )),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(value.roomName,
                                                          textAlign:
                                                          TextAlign.start,
                                                          maxLines: 2,
                                                          style:
                                                          getLabelLargeStyle(
                                                              context)),
                                                      addVerticalSpace(
                                                          flyternSpaceSmall),
                                                      Container(
                                                        padding: flyternSmallPaddingHorizontal
                                                            .copyWith(
                                                            top:
                                                            flyternSpaceExtraSmall,
                                                            bottom:
                                                            flyternSpaceExtraSmall),
                                                        decoration: BoxDecoration(
                                                          color:
                                                          flyternPrimaryColorBg,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              flyternBorderRadiusExtraSmall),
                                                        ),
                                                        child: Text(
                                                          "${value.currency} ${value.totalPrice.toStringAsFixed(3)}",
                                                          style: getLabelLargeStyle(
                                                              context)
                                                              .copyWith(
                                                              color:
                                                              flyternPrimaryColor),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            addVerticalSpace(flyternSpaceSmall),
                                            Expanded(
                                              child: ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: [
                                                  for (var i = 0;
                                                  i < value.shortdesc.length;
                                                  i++)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right:
                                                          flyternSpaceExtraSmall),
                                                      padding: flyternSmallPaddingHorizontal
                                                          .copyWith(
                                                          top:
                                                          flyternSpaceExtraSmall,
                                                          bottom:
                                                          flyternSpaceExtraSmall),
                                                      decoration: BoxDecoration(
                                                        color:
                                                        flyternTertiaryColorBg,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            flyternBorderRadiusExtraSmall),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          value.shortdesc[i],
                                                          style: getLabelLargeStyle(
                                                              context)
                                                              .copyWith(
                                                              color:
                                                              flyternTertiaryColor),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ) )).values.toList()

                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible:
                              hotelBookingController.getRoomImagesLength() > 0,
                          child: Container(
                            padding: flyternLargePaddingAll.copyWith(
                                bottom: 0, top: 0),
                            margin: flyternLargePaddingVertical,
                            color: flyternBackgroundWhite,
                            height: screenwidth * .14,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var i = 0;
                                    i <
                                        hotelBookingController
                                            .getRoomImagesLength();
                                    i++)
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(Approute_imageViewer,
                                          arguments: [
                                            hotelBookingController
                                                .getRoomImage(i),
                                            hotelBookingController
                                                .getRoomImages()
                                          ]);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                flyternBorderRadiusExtraSmall),
                                            border: Border.all(
                                                color: i ==
                                                        hotelBookingController
                                                            .selectedRoomImageIndex
                                                            .value
                                                    ? flyternSecondaryColor
                                                    : Colors.transparent,
                                                width: 2)),
                                        margin: EdgeInsets.only(
                                            right: flyternSpaceSmall),
                                        clipBehavior: Clip.hardEdge,
                                        height: screenwidth * .14,
                                        child: Image.network(
                                            hotelBookingController
                                                .getRoomImage(i),
                                            height: screenwidth * .14, errorBuilder:
                                                (context, error, stackTrace) {
                                          return Container(
                                            color: flyternGrey10,
                                            height: screenwidth * .14,
                                            child: Center(
                                              child: Icon(
                                                Icons.business,
                                                color: flyternGrey40,
                                              ),
                                            ),
                                          );
                                        })),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        Visibility(
                          visible: hotelBookingController
                                  .getRoomsLength() >
                              0,
                          child: Padding(
                            padding: flyternLargePaddingAll.copyWith(
                                top: flyternSpaceLarge,
                                bottom: flyternSpaceMedium),
                            child: Text(
                              "rooms_no".tr.replaceAll(
                                  "2",
                                  hotelBookingController
                                      .getRoomsLength()
                                      .toString()),
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold),
                            ),
                          ),
                        ),
                        for (var i = 0;
                            i < hotelBookingController.getRoomsLength();
                            i++)
                          Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: 0,
                                bottom: i ==
                                        hotelBookingController
                                                .getRoomsLength() -
                                            1
                                    ? flyternSpaceSmall
                                    : flyternSpaceMedium),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${"room".tr} ${i + 1}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                addHorizontalSpace(flyternSpaceSmall),
                                Expanded(
                                  child: Text(hotelBookingController.getRoom(i),
                                      maxLines: 2,
                                      textAlign: TextAlign.end,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                ),
                              ],
                            ),
                          ),

                        Visibility(
                          visible: hotelBookingController
                                  .getCancellationPolicyLength() >
                              0,
                          child: Padding(
                            padding: flyternLargePaddingAll.copyWith(
                                top: flyternSpaceLarge,
                                bottom: flyternSpaceMedium),
                            child: Text(
                              "cancellation_policy".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold),
                            ),
                          ),
                        ),
                        for (var i = 0;
                            i <
                                hotelBookingController
                                    .getCancellationPolicyLength();
                            i++)
                          Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: 0,
                                bottom: i ==
                                        hotelBookingController
                                                .getCancellationPolicyLength() -
                                            1
                                    ? flyternSpaceSmall
                                    : flyternSpaceMedium),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    getFormattedDate(hotelBookingController
                                        .getCancellationPolicy(i)
                                        .fromDate),
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                Text(
                                    "${hotelBookingController.getCancellationPolicy(i).cancellationCharge}"
                                    " ${hotelBookingController.getCancellationPolicy(i).chargeType.toLowerCase().contains("fixed") ? hotelBookingController.getCurrency() : "%"}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                              ],
                            ),
                          ),

                        Visibility(
                          visible:
                              hotelBookingController.getSupplementsLength() > 0,
                          child: Padding(
                            padding: flyternLargePaddingAll.copyWith(
                                bottom: flyternSpaceMedium),
                            child: Text(
                              "supplements".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold),
                            ),
                          ),
                        ),
                        for (var i = 0;
                            i < hotelBookingController.getSupplementsLength();
                            i++)
                          Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: 0,
                                bottom: i ==
                                        hotelBookingController
                                                .getSupplementsLength() -
                                            1
                                    ? flyternSpaceSmall
                                    : flyternSpaceMedium),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    hotelBookingController
                                        .getSupplements(i)
                                        .description,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                Text(
                                    "${hotelBookingController.getSupplements(i).currency}"
                                    " ${hotelBookingController.getSupplements(i).price.toStringAsFixed(3)}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                              ],
                            ),
                          ),
                        Padding(
                          padding: flyternLargePaddingAll.copyWith(
                              bottom: flyternSpaceMedium),
                          child: Text(
                            "booking_details".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(fontWeight: flyternFontWeightBold),
                          ),
                        ),
                        Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: 0, bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("checkin".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${hotelBookingController.hotelDetails.value.checkIn}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                        Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: 0, bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("checkout".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${hotelBookingController.hotelDetails.value.checkOut}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                        Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: 0, bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("duration".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${hotelBookingController.hotelDetails.value.duration}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Padding(
                            padding: flyternLargePaddingAll.copyWith(
                                bottom: flyternSpaceMedium),
                            child: Text(
                              "price_details".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold),
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: 0, bottom: flyternSpaceLarge),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("per_night".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                Text(
                                    "${hotelBookingController.getCurrency()}"
                                    " ${hotelBookingController.getPricePerNight()}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: 0, bottom: flyternSpaceLarge),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("total_fare".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                Text(
                                    "${hotelBookingController.getCurrency()}"
                                    " ${hotelBookingController.getTotalPrice()}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: 0, bottom: flyternSpaceLarge),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("tax_fare".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                Text(
                                    "${hotelBookingController.getCurrency()}"
                                    " ${hotelBookingController.getTaxPrice()}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Container(
                              width: screenwidth,
                              color: flyternGrey10,
                              height: 1),
                        ),
                        Visibility(
                            visible:
                                hotelBookingController.getRoomOptionsLength() >
                                    0,
                            child: addVerticalSpace(flyternSpaceLarge)),
                        Visibility(
                          visible:
                              hotelBookingController.getRoomOptionsLength() > 0,
                          child: Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: 0, bottom: flyternSpaceLarge),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("grand_total".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                Text(
                                    "${hotelBookingController.getCurrency()}"
                                    " ${hotelBookingController.getGrandTotal()}",
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: flyternGrey80,
                                        fontWeight: flyternFontWeightBold)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: flyternLargePaddingAll,
                          width: screenwidth,
                          color: flyternGrey10,
                          child: Text(
                            "basic_details".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                          ),
                        ),
                        for (var ind = 0;
                            ind <
                                hotelBookingController
                                    .hotelDetails.value.basicDetails.length;
                            ind++)
                          Container(
                            padding: flyternLargePaddingHorizontal,
                            decoration: BoxDecoration(
                                color: flyternBackgroundWhite,
                                border: flyternDefaultBorderBottomOnly),
                            child: Theme(
                              data: ThemeData()
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.zero,
                                title: Text(
                                  hotelBookingController.hotelDetails.value
                                      .basicDetails[ind].policyName,
                                  style: getBodyMediumStyle(context).copyWith(
                                      fontWeight: flyternFontWeightBold),
                                ),
                                children: <Widget>[
                                  Padding(
                                    padding: flyternSmallPaddingVertical,
                                    child: Html(
                                      data: hotelBookingController.hotelDetails
                                          .value.basicDetails[ind].policyText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Container(
                          color: flyternGrey10,
                          height: 70 + (flyternSpaceSmall * 2),
                          padding: flyternLargePaddingAll,
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: hotelBookingController.isHotelDetailsLoading.value,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                      color: flyternSecondaryColor,
                      size: 50,
                    )))
              ],
            )),
        bottomSheet: !hotelBookingController.isHotelDetailsLoading.value &&
                hotelBookingController.getRoomOptionsLength() > 0 &&
            hotelBookingController.hotelDetails.value.hotelId != 0
            ? Container(
                width: screenwidth,
                color: flyternBackgroundWhite,
                height: 60 + (flyternSpaceSmall * 2),
                padding: flyternLargePaddingAll.copyWith(
                    top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: getElevatedButtonStyle(context),
                        onPressed: () {
                          openContactDetailsGetterBottomSheet();
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${hotelBookingController.hotelDetails.value.priceUnit} "
                                "${hotelBookingController.getGrandTotal()}",
                              ),
                            ),
                            Text("book_now".tr),
                            addHorizontalSpace(flyternSpaceSmall),
                            Icon(
                              Localizations.localeOf(context)
                                  .languageCode
                                  .toString() ==
                                  'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                              size: flyternFontSize20,
                            )
                          ],
                        )),
                  ),
                ),
              )
            : Container(width: screenwidth, height: 0),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
     }
  }

  void openContactDetailsGetterBottomSheet() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ContactDetailsGetter(route: Approute_hotelsUserSelection);
        });
  }

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat('dd-MM-yyyy');
    return f.format(dateTime);
  }

  getSelectedImageUrl() {
    if (hotelBookingController.hotelDetails.value.imageUrls.isEmpty) {
      return "";
    }

    return hotelBookingController.hotelDetails.value
        .imageUrls[hotelBookingController.selectedImageIndex.value];
  }
}
