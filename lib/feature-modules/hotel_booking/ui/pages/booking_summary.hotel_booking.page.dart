import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/search_result_card.hotel_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HotelBookingSummaryPage extends StatefulWidget {
  const HotelBookingSummaryPage({super.key});

  @override
  State<HotelBookingSummaryPage> createState() => _HotelBookingSummaryPageState();
}

class _HotelBookingSummaryPageState extends State<HotelBookingSummaryPage> {

  final hotelBookingController = Get.find<HotelBookingController>();


  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog();
        return false;
      },
      child: Obx(
          ()=> Scaffold(
          appBar: AppBar(
            title: Text('summary'.tr),
            elevation: 0.5,
          ),
          body: Stack(
            children: [
              Visibility(
                  visible: hotelBookingController
                      .isHotelTravellerDataSaveLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight * .8,
                    color: flyternGrey10,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: flyternSecondaryColor,
                          size: 50,
                        )),
                  )),

              Visibility(
                visible: !hotelBookingController
                    .isHotelTravellerDataSaveLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: ListView(
                    children: [
                      for (var i = 0;
                      i < hotelBookingController.alert.length;
                      i++)
                        Container(
                          padding: flyternLargePaddingAll.copyWith(bottom: 0),
                          child: DataCapsuleCard(
                            label: hotelBookingController.alert[i],
                            theme: 1,
                          ),
                        ),


                      Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("select_payment_method".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      for (var i = 0;
                      i < hotelBookingController.paymentGateways.length;
                      i++)
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: i == hotelBookingController.paymentGateways.length-1?Colors.transparent:flyternGrey20,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              hotelBookingController.paymentGateways
                                                  .value[i].gatewayImageUrl,
                                              width: screenwidth * .1,
                                              height: screenwidth * .1,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                    width: screenwidth * .1,
                                                    height: screenwidth * .1);
                                              },
                                            ))),
                                    addHorizontalSpace(flyternSpaceMedium),
                                    Text(
                                        hotelBookingController
                                            .paymentGateways.value[i].displayName,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: flyternGrey80)),
                                  ],
                                ),
                              ),
                              Radio(
                                activeColor: flyternSecondaryColor,
                                value: hotelBookingController
                                    .paymentGateways.value[i].processID,
                                groupValue:
                                hotelBookingController. selectedPaymentGateway.value.processID,
                                onChanged: (value) {
                                  hotelBookingController.updateProcessId(value);
                                },
                              ),
                            ],
                          ),
                        ),

                      Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceLarge, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("processing_fee".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${ hotelBookingController. selectedPaymentGateway.value.currencyCode}"
                                    " ${ hotelBookingController. selectedPaymentGateway.value.processingFee}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),

                      Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),

                      Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceLarge),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${'grand_total'.tr} ",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${ hotelBookingController. selectedPaymentGateway.value.currencyCode}"
                                    " ${ hotelBookingController. selectedPaymentGateway.value.finalAmount}",
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold)),
                          ],
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
                                      hotelBookingController.bookingInfo, i),
                                  style: getBodyMediumStyle(context).copyWith(
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
                                      padding: flyternLargePaddingHorizontal.copyWith(
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
                        padding: flyternLargePaddingAll.copyWith(top: flyternSpaceLarge*2),
                        child: Text("hotel_details".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                      ),
                      Container(
                        color: flyternBackgroundWhite,
                        padding: flyternLargePaddingHorizontal,
                        child: HotelSearchResultCard(
                          onPressed:(){
                          },
                          hotelSearchResponse: hotelBookingController
                              .hotelSearchResponses.value.where((element) => element.hotelId ==
                              hotelBookingController.hotelId.value).toList().isNotEmpty?hotelBookingController
                              .hotelSearchResponses.value.where((element) => element.hotelId ==
                              hotelBookingController.hotelId.value).toList()[0]:mapHotelSearchResponse(
                              {}),
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
            bottomSheet: Container(
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
                              "${ hotelBookingController. selectedPaymentGateway.value.currencyCode}"
                                  " ${ hotelBookingController. selectedPaymentGateway.value.finalAmount}",
                            ),
                          ),
                          Visibility(
                              visible: !hotelBookingController.isHotelSavePaymentGatewayLoading.value,
                              child: Text("next".tr)),
                          Visibility(
                              visible: hotelBookingController.isHotelSavePaymentGatewayLoading.value,
                              child:  LoadingAnimationWidget.prograssiveDots(
                                color: flyternBackgroundWhite,
                                size: 20,
                              )),
                          addHorizontalSpace(flyternSpaceSmall),
                          Icon(
                            Ionicons.chevron_forward,
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
      builder: (_) => ConfirmDialogue(
          onClick: () async {
            hotelBookingController.resetAndNavigateToHome();
          },
          titleKey: 'cancel_booking'.tr + " ?",
          subtitleKey: 'cancel_confirm'.tr),
    );
  }


}
