import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/search_result_card.hotel_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HotelBookingSummaryPage extends StatefulWidget {
  const HotelBookingSummaryPage({super.key});

  @override
  State<HotelBookingSummaryPage> createState() =>
      _HotelBookingSummaryPageState();
}

class _HotelBookingSummaryPageState extends State<HotelBookingSummaryPage> {

  final hotelBookingController = Get.find<HotelBookingController>();


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog();
        return false;
      },
      child: Obx(
            () =>
            Scaffold(
              appBar: AppBar(
                title: Text('payment_summary'.tr),
                elevation: 0.5,
              ),
              body: Stack(
                children: [
                  Visibility(
                      visible: hotelBookingController
                          .isHotelConfirmationDataLoading.value ||
                          hotelBookingController
                              .isHotelGatewayStatusCheckLoading.value ||
                          hotelBookingController
                              .isHotelSavePaymentGatewayLoading.value ||
                          hotelBookingController
                              .isHotelTravellerDataSaveLoading.value,
                      child: Container(
                        width: screenwidth,
                        height: screenheight * .9,
                        color: flyternGrey10,
                        child:Center(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.center,
                              children: [
                                LoadingAnimationWidget.prograssiveDots(
                                  color: flyternSecondaryColor,
                                  size: 50,
                                ),
                                Visibility(
                                  visible: hotelBookingController
                                      .isHotelSavePaymentGatewayLoading.value,
                                  child: Padding(
                                    padding: flyternLargePaddingAll,
                                    child: DataCapsuleCard(
                                      label: "hotel_gateway_submission_message".tr,
                                      theme: 1,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: hotelBookingController
                                      .isHotelConfirmationDataLoading.value,
                                  child: Padding(
                                    padding: flyternLargePaddingAll,
                                    child: DataCapsuleCard(
                                      label: "hotel_confirmation_loading_message".tr,
                                      theme: 1,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: hotelBookingController
                                      .isHotelTravellerDataSaveLoading.value,
                                  child: Padding(
                                    padding: flyternLargePaddingAll,
                                    child: DataCapsuleCard(
                                      label: "hotel_traveller_submission_message".tr,
                                      theme: 1,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      )),

                  Visibility(
                    visible: !hotelBookingController
                        .isHotelConfirmationDataLoading.value &&
                        !hotelBookingController
                            .isHotelGatewayStatusCheckLoading.value &&
                        !hotelBookingController
                            .isHotelSavePaymentGatewayLoading.value &&
                        !hotelBookingController
                            .isHotelTravellerDataSaveLoading.value,
                    child: Container(
                      width: screenwidth,
                      height: screenheight,
                      color: flyternGrey10,
                      child: ListView(
                        children: [

                          Visibility(
                            visible:hotelBookingController.alert.isEmpty
                                && hotelBookingController.paymentGateways.isEmpty &&
                                hotelBookingController
                                    .getRoomsLength() ==
                                    0  ,
                            child: Container(
                              padding: flyternMediumPaddingAll,
                              margin: flyternLargePaddingAll.copyWith(
                                  bottom: flyternSpaceMedium),
                              decoration: BoxDecoration(
                                color: flyternPrimaryColorBg,
                                borderRadius: BorderRadius.circular(
                                    flyternBorderRadiusExtraSmall),
                              ),
                              child: Text("couldnt_find_booking".tr),
                            ),
                          ),
                          for (var i = 0;
                          i < hotelBookingController.alert.length;
                          i++)
                            Container(
                              padding: flyternLargePaddingAll.copyWith(
                                  bottom: 0),
                              child: DataCapsuleCard(
                                label: hotelBookingController.alert[i],
                                theme: 1,
                              ),
                            ),


                          Visibility(
                            visible: hotelBookingController.paymentGateways
                                .isNotEmpty,
                            child: Padding(
                              padding: flyternLargePaddingAll,
                              child: Text("select_payment_method".tr,
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ),
                          ),
                          for (var i = 0;
                          i < hotelBookingController.paymentGateways.length;
                          i++)
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: i ==
                                        hotelBookingController.paymentGateways
                                            .length - 1
                                        ? Colors.transparent
                                        : flyternGrey20,
                                    width: 0.5,
                                  ),
                                ),
                                color: flyternBackgroundWhite,
                              ),
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  top: flyternSpaceMedium,
                                  bottom: i ==
                                      hotelBookingController
                                          .paymentGateways.length -
                                          1
                                      ? flyternSpaceLarge
                                      : flyternSpaceMedium),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Container(
                                            decoration:
                                            flyternBorderedContainerSmallDecoration,
                                            clipBehavior: Clip.hardEdge,
                                            width: screenwidth * .15,
                                            height: screenwidth * .15,
                                            child: Center(
                                                child: Image.network(
                                                  hotelBookingController
                                                      .paymentGateways
                                                      .value[i].gatewayImageUrl,
                                                  width: screenwidth * .1,
                                                  height: screenwidth * .1,
                                                  errorBuilder:
                                                      (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                        width: screenwidth * .1,
                                                        height: screenwidth *
                                                            .1);
                                                  },
                                                ))),
                                        addHorizontalSpace(flyternSpaceMedium),
                                        Text(
                                            hotelBookingController
                                                .paymentGateways.value[i]
                                                .displayName,
                                            style: getBodyMediumStyle(context)
                                                .copyWith(
                                                color: flyternGrey80)),
                                      ],
                                    ),
                                  ),
                                  Radio(
                                    activeColor: flyternSecondaryColor,
                                    value: hotelBookingController
                                        .paymentGateways.value[i].processID,
                                    groupValue:
                                    hotelBookingController
                                        .selectedPaymentGateway.value.processID,
                                    onChanged: (value) {
                                      hotelBookingController.updateProcessId(
                                          value);
                                    },
                                  ),
                                ],
                              ),
                            ),

                          Visibility(
                            visible: hotelBookingController.paymentGateways
                                .isNotEmpty,
                            child: Container(
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  top: flyternSpaceLarge,
                                  bottom: flyternSpaceSmall),
                              color: flyternBackgroundWhite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("processing_fee".tr,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey60)),
                                  Text(
                                      "${ hotelBookingController
                                          .selectedPaymentGateway.value
                                          .currencyCode}"
                                          " ${ hotelBookingController
                                          .selectedPaymentGateway.value
                                          .processingFee.toStringAsFixed(3)}",
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                ],
                              ),
                            ),
                          ),

                          Visibility(
                            visible: hotelBookingController.paymentGateways
                                .isNotEmpty,
                            child: Container(
                                padding: flyternLargePaddingHorizontal,
                                color: flyternBackgroundWhite,
                                child: Divider()),
                          ),

                          Visibility(
                            visible: hotelBookingController.paymentGateways
                                .isNotEmpty,
                            child: Container(
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  top: flyternSpaceSmall,
                                  bottom: flyternSpaceLarge),
                              color: flyternBackgroundWhite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("${'grand_total'.tr} ",
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey60)),
                                  Text(
                                      "${ hotelBookingController
                                          .selectedPaymentGateway.value
                                          .currencyCode}"
                                          " ${ hotelBookingController
                                          .selectedPaymentGateway.value
                                          .finalAmount.toStringAsFixed(3)}",
                                      style: getBodyMediumStyle(context)
                                          .copyWith(
                                          color: flyternGrey80,
                                          fontWeight: flyternFontWeightBold)),
                                ],
                              ),
                            ),
                          ),


                          for (var i = 0;
                          i <
                              getBookingInfoGroupLength(
                                  hotelBookingController.bookingInfo);
                          i++)
                            Wrap(
                              children: [
                                Padding(
                                  padding: flyternLargePaddingAll,
                                  child: Text(
                                      getBookingInfoGroupName(
                                          hotelBookingController.bookingInfo,
                                          i),
                                      style: getBodyMediumStyle(context)
                                          .copyWith(
                                          color: flyternGrey80,
                                          fontWeight: flyternFontWeightBold)),
                                ),
                                Container(
                                  child: Wrap(
                                    children: [
                                      for (var ind = 0;
                                      ind <
                                          getBookingInfoGroupSize(
                                              hotelBookingController
                                                  .bookingInfo,
                                              i);
                                      ind++)
                                        getBookingInfoTitle(
                                            hotelBookingController
                                                .bookingInfo,
                                            i,
                                            ind) !=
                                            "DIVIDER"
                                            ? Container(
                                          padding: flyternLargePaddingHorizontal
                                              .copyWith(
                                              top: ind == 0
                                                  ? flyternSpaceLarge
                                                  : flyternSpaceMedium,
                                              bottom: ind ==
                                                  getBookingInfoGroupSize(
                                                      hotelBookingController
                                                          .bookingInfo,
                                                      i) -
                                                      1
                                                  ? flyternSpaceLarge
                                                  : flyternSpaceMedium),
                                          decoration: BoxDecoration(
                                              color: flyternBackgroundWhite,
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ind ==
                                                      getBookingInfoGroupSize(
                                                          hotelBookingController
                                                              .bookingInfo,
                                                          i) -
                                                          1
                                                      ? Colors.transparent
                                                      : flyternGrey20,
                                                  width: 0.5,
                                                ),
                                              )),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  getBookingInfoTitle(
                                                      hotelBookingController
                                                          .bookingInfo,
                                                      i,
                                                      ind),
                                                  style: getBodyMediumStyle(
                                                      context)
                                                      .copyWith(
                                                      color:
                                                      flyternGrey60)),
                                              addHorizontalSpace(
                                                  flyternSpaceLarge),
                                              Expanded(
                                                child: Text(
                                                    getBookingInfoValue(
                                                        hotelBookingController
                                                            .bookingInfo,
                                                        i,
                                                        ind),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.end,
                                                    style: getBodyMediumStyle(
                                                        context)
                                                        .copyWith(
                                                        color:
                                                        flyternGrey80)),
                                              ),
                                            ],
                                          ),
                                        )
                                            : ind !=
                                            getBookingInfoGroupSize(
                                                hotelBookingController
                                                    .bookingInfo,
                                                i) -
                                                1
                                            ? Container(
                                            color: flyternBackgroundWhite,
                                            child: const Divider(
                                                color: flyternTertiaryColor,
                                                height: 3, thickness: 1))
                                            : Container(),
                                    ],
                                  ),
                                )
                              ],
                            ),

                          Padding(
                            padding: flyternLargePaddingAll.copyWith(
                                top: flyternSpaceLarge * 2),
                            child: Text("hotel_details".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold)),
                          ),
                          Container(
                            color: flyternBackgroundWhite,
                            padding: flyternLargePaddingHorizontal,
                            child: HotelSearchResultCard(
                              onPressed: () {},
                              hotelSearchResponse: HotelSearchResponse(
                                  locationFilter: hotelBookingController.hotelDetails.value.location,
                                  fromPrice: hotelBookingController.hotelDetails.value.fromPrice,
                                  rating: hotelBookingController.hotelDetails.value.rating,
                                  imageUrl: hotelBookingController.hotelDetails.value.imageUrls.isNotEmpty?hotelBookingController.hotelDetails.value.imageUrls[0]:"",
                                  location: hotelBookingController.hotelDetails.value.location,
                                  hotelName: hotelBookingController.hotelDetails.value.hotelName,
                                  priceUnit: hotelBookingController.hotelDetails.value.priceUnit,
                                  description: hotelBookingController.hotelDetails.value.descriptionInfo,
                                  hotelId: hotelBookingController.hotelDetails.value.hotelId,
                                  information: []),
                            ),
                          ),

                          Visibility(
                            visible: hotelBookingController
                                .getRoomsLength() >
                                0,
                            child: Container(
                              color: flyternBackgroundWhite,
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
                                    .copyWith(
                                    fontWeight: flyternFontWeightBold),
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
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("${"room".tr} ${i + 1}",
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey60)),
                                  addHorizontalSpace(flyternSpaceSmall),
                                  Expanded(
                                    child: Text(
                                        hotelBookingController.getRoom(i),
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
                                .getSelectedRoomOption() != null,
                            child: Container(
                              color: flyternBackgroundWhite,
                              height: 120 + flyternSpaceMedium,
                              padding: flyternMediumPaddingAll,
                              margin: EdgeInsets.only(top: flyternSpaceMedium),
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
                                          visible: hotelBookingController
                                              .getSelectedRoomOption()!
                                              .imageURLs
                                              .isNotEmpty,
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .only(
                                                right:
                                                flyternSpaceMedium),
                                            child: Image.network(
                                                hotelBookingController
                                                    .getSelectedRoomOption()!
                                                    .imageURLs
                                                    .isNotEmpty
                                                    ? hotelBookingController
                                                    .getSelectedRoomOption()!
                                                    .imageURLs[0]
                                                    : "",
                                                height: 80 -
                                                    flyternSpaceSmall),
                                          )),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(hotelBookingController
                                                .getSelectedRoomOption()!
                                                .roomName,
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
                                                "${hotelBookingController
                                                    .getSelectedRoomOption()!
                                                    .currency} ${hotelBookingController
                                                    .getSelectedRoomOption()!
                                                    .totalPrice}",
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
                                        i < hotelBookingController
                                            .getSelectedRoomOption()!
                                            .shortdesc
                                            .length;
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
                                                hotelBookingController
                                                    .getSelectedRoomOption()!
                                                    .shortdesc[i],
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
                                    .copyWith(
                                    fontWeight: flyternFontWeightBold),
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
                                  top: flyternSpaceSmall,
                                  bottom: (i ==
                                      hotelBookingController
                                          .getCancellationPolicyLength() -
                                          1 && i != 0)
                                      ? flyternSpaceSmall
                                      : flyternSpaceMedium),
                              color: flyternBackgroundWhite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                      getFormattedDate(hotelBookingController
                                          .getCancellationPolicy(i)
                                          .fromDate),
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey60)),
                                  Text(
                                      "${hotelBookingController
                                          .getCancellationPolicy(i)
                                          .cancellationCharge}"
                                          " ${hotelBookingController
                                          .getCancellationPolicy(i)
                                          .chargeType
                                          .toLowerCase()
                                          .contains("fixed")
                                          ? hotelBookingController.getCurrency()
                                          : "%"}",
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
                                    .copyWith(
                                    fontWeight: flyternFontWeightBold),
                              ),
                            ),
                          ),
                          for (var i = 0;
                          i < hotelBookingController.getSupplementsLength();
                          i++)
                            Container(
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  top: flyternSpaceSmall,
                                  bottom: (i ==
                                      hotelBookingController
                                          .getSupplementsLength() -
                                          1 && i != 0)
                                      ? flyternSpaceSmall
                                      : flyternSpaceMedium),

                              color: flyternBackgroundWhite,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                      hotelBookingController
                                          .getSupplements(i)
                                          .description,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey60)),
                                  Text(
                                      "${hotelBookingController
                                          .getSupplements(i)
                                          .currency}"
                                          " ${hotelBookingController
                                          .getSupplements(i)
                                          .price}",
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
                                top: flyternSpaceMedium,
                                bottom: flyternSpaceLarge),
                            color: flyternBackgroundWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("checkin".tr,
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey60)),
                                Text(
                                    "${hotelBookingController.hotelDetails.value
                                        .checkIn}",
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
                                    "${hotelBookingController.hotelDetails.value
                                        .checkOut}",
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
                                    "${hotelBookingController.hotelDetails.value
                                        .duration}",
                                    style: getBodyMediumStyle(context)
                                        .copyWith(color: flyternGrey80)),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: hotelBookingController.hotelDetails.value.roomRateConditions.isNotEmpty,
                            child: Padding(
                              padding: flyternLargePaddingAll.copyWith(
                                  bottom: flyternSpaceMedium),
                              child: Text(
                                "roomRateConditions".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(fontWeight: flyternFontWeightBold),
                              ),
                            ),
                          ),
                          for (var i = 0;
                          i < hotelBookingController.hotelDetails.value.roomRateConditions.length;
                          i++)
                            Container(
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  top: flyternSpaceMedium,
                                  bottom: flyternSpaceLarge),
                              decoration: BoxDecoration(
                                border: flyternDefaultBorderBottomOnly,
                                color: flyternBackgroundWhite
                              ),
                              child: Html(
                                data: hotelBookingController.hotelDetails.value.roomRateConditions[i],
                              ),
                            ),
                          Container(
                            height: 70 + (flyternSpaceSmall * 2),
                            padding: flyternLargePaddingAll,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomSheet:
              hotelBookingController
                  .isHotelSavePaymentGatewayLoading.value ||
              hotelBookingController
                  .isHotelConfirmationDataLoading.value ||
                  hotelBookingController
                      .isHotelGatewayStatusCheckLoading.value ||
                  hotelBookingController
                      .isHotelTravellerDataSaveLoading.value ||
                  hotelBookingController.paymentGateways.isEmpty ? 
              Container(
                width: screenwidth, height: 1,)
                  : Container(
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
                          hotelBookingController.setPaymentGateway();
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${ hotelBookingController
                                    .selectedPaymentGateway.value.currencyCode}"
                                    " ${ hotelBookingController
                                    .selectedPaymentGateway.value.finalAmount.toStringAsFixed(3)}",
                              ),
                            ),
                            Visibility(
                                visible: !hotelBookingController
                                    .isHotelSavePaymentGatewayLoading.value,
                                child: Text("next".tr)),
                            Visibility(
                                visible: hotelBookingController
                                    .isHotelSavePaymentGatewayLoading.value,
                                child: LoadingAnimationWidget.prograssiveDots(
                                  color: flyternBackgroundWhite,
                                  size: 20,
                                )),
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
              ),
            ),
      ),
    );
  }

  showConfirmDialog() async {
    showDialog(
      context: context,
      builder: (_) =>
          ConfirmDialogue(
              onClick: () async {
                hotelBookingController.resetAndNavigateToHome();
              },
              titleKey: 'cancel_booking'.tr + " ?",
              subtitleKey: 'cancel_confirm'.tr),
    );
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
