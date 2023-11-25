import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking_controller.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_response.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
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

    return Obx(
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


                    // Payment summary

                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("payment_summary".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),

                    for(var i=0;i<hotelBookingController.hotelSearchData.value.rooms.length;i++)
                      Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top:i==0 ?flyternSpaceLarge:flyternSpaceMedium, bottom:i==0 ?flyternSpaceSmall: flyternSpaceMedium),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${hotelBookingController.hotelDetails.value.rooms[i].roomDisplayNo} - "
                                "${hotelBookingController.hotelDetails.value.rooms[i].roomref}" ,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${hotelBookingController.hotelDetails.value.priceUnit}"
                                    " ${hotelBookingController.selectedRoomOption.value[i].totalPrice}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),

                    Container(
                      padding: flyternLargePaddingHorizontal.copyWith(
                          top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("total_fare".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey60)),
                          Text(
                              "${hotelBookingController.hotelDetails.value.priceUnit}"
                                  " ${getBaseTotal()}",
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
                          top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("processing_fee".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey60)),
                          Text(
                              "${hotelBookingController.hotelDetails.value.priceUnit} ${hotelBookingController.processingFee.value}",
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),

                    Container(
                        padding: flyternLargePaddingHorizontal,
                        color: flyternBackgroundWhite,
                        child: Divider()),
                    Visibility(
                      visible: hotelBookingController.selectedPaymentGateway.value.discount > 0.0,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${'discount'.tr}  ",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                " - ${hotelBookingController.hotelDetails.value.priceUnit} ${hotelBookingController.selectedPaymentGateway.value.discount}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGuideGreen)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible:hotelBookingController.selectedPaymentGateway.value.discount>0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
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
                              "${hotelBookingController.hotelDetails.value.priceUnit}"
                                  " ${getGrandTotal()}",
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ],
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
                          border: flyternDefaultBorderBottomOnly,
                          color: flyternBackgroundWhite,
                        ),
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceMedium,
                            bottom: i==hotelBookingController.paymentGateways.length-1?
                            flyternSpaceLarge: flyternSpaceMedium),
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
                              groupValue: hotelBookingController.processId.value,
                              onChanged: (value) {
                                hotelBookingController.updateProcessId(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: flyternLargePaddingAll,
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
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("users".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),

                    for (var i = 0;
                    i <
                        hotelBookingController
                            .selectedTravelInfo.value.length;
                    i++)
                      Container(
                        decoration: BoxDecoration(
                          border: flyternDefaultBorderBottomOnly,
                          color: flyternBackgroundWhite,
                        ),
                        child: UserDetailsCard(
                          onDelete: () {},
                          onEdit: () {},
                          isActionAllowed: false,
                          name:
                          "${hotelBookingController.selectedTravelInfo[i].firstName} ${hotelBookingController.selectedTravelInfo[i].lastName}",
                          age: "",
                          gender: hotelBookingController
                              .selectedTravelInfo[i].gender,
                          passportNumber:"",
                        ),
                      ),
                    Container(
                      height: 70+(flyternSpaceSmall*2),
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
                            "${hotelBookingController.hotelDetails.value.priceUnit} "
                                "${getGrandTotal()}",
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
    );
  }


  getGrandTotal() {
    double grandTotal = 0;
    hotelBookingController.selectedRoomOption.value.forEach((element) {
      grandTotal += element.totalPrice;
    });
    grandTotal +=hotelBookingController.selectedPaymentGateway.value.processingFee;
    grandTotal -=hotelBookingController.selectedPaymentGateway.value.discount;
    return grandTotal;
  }

  getBaseTotal() {
    double grandTotal = 0;
    hotelBookingController.selectedRoomOption.value.forEach((element) {
      grandTotal += element.totalPrice;
    });
    return grandTotal;
  }
}
