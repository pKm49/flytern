import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightBookingSummaryPage extends StatefulWidget {
  const FlightBookingSummaryPage({super.key});

  @override
  State<FlightBookingSummaryPage> createState() =>
      _FlightBookingSummaryPageState();
}

class _FlightBookingSummaryPageState extends State<FlightBookingSummaryPage> {

  final flightBookingController = Get.find<FlightBookingController>();

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
                visible: flightBookingController
                    .isFlightTravellerDataSaveLoading.value,
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
              visible:
                  !flightBookingController.isFlightTravellerDataSaveLoading.value,
              child: Container(
                width: screenwidth,
                height: screenheight,
                color: flyternGrey10,
                child: ListView(
                  children: [
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("payment_summary".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceLarge, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("base_fare".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalBase}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("tax_fare".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalTax}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: flightBookingController.processingFee.value != 0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
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
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalPrice}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.seatTotalAmount.value != 0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.seatTotalAmount.value != 0.0,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("seats".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${flightBookingController.cabinInfo.value.currency} "
                                    "${flightBookingController.seatTotalAmount.value}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.mealTotalAmount.value != 0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.mealTotalAmount.value != 0.0,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("meal".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${flightBookingController.cabinInfo.value.currency} "
                                    "${flightBookingController.mealTotalAmount.value}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.baggageTotalAmount.value != 0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.baggageTotalAmount.value != 0.0,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("extra_buggage".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${flightBookingController.cabinInfo.value.currency} "
                                    "${flightBookingController.baggageTotalAmount.value}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.processingFee.value !=
                          0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.processingFee.value  != 0.0,
                      child: Container(
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
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.processingFee.value}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.cabinInfo.value.totalBase > 0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.cabinInfo.value.discount > 0.0,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${'discount'.tr} (${'promo_code'.tr}-${flightBookingController.cabinInfo.value.promoCode})",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                " - ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.discount}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGuideGreen)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
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
                                "${flightBookingController.cabinInfo.value.currency}"
                                    " ${(flightBookingController.cabinInfo.value.finalAmount +
                                    flightBookingController.seatTotalAmount.value +
                                    flightBookingController.mealTotalAmount.value +
                                    flightBookingController.baggageTotalAmount.value +
                                    flightBookingController.processingFee.value)}",
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold)),
                          ],
                        ),
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
                        i < flightBookingController.paymentGateways.length;
                        i++)
                      Container(
                        decoration: BoxDecoration(
                          border: flyternDefaultBorderBottomOnly,
                          color: flyternBackgroundWhite,
                        ),
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceMedium,
                            bottom: i==flightBookingController.paymentGateways.length-1?
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
                                        flightBookingController.paymentGateways
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
                                      flightBookingController
                                          .paymentGateways.value[i].displayName,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                ],
                              ),
                            ),
                            Radio(
                              activeColor: flyternSecondaryColor,
                              value: flightBookingController
                                  .paymentGateways.value[i].processID,
                              groupValue: flightBookingController.processId.value,
                              onChanged: (value) {
                                flightBookingController.updateProcessId(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("flight_summary".tr,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                          Text("flight_details".tr,
                              style: getBodyMediumStyle(context).copyWith(
                                  decoration: TextDecoration.underline,
                                  color: flyternTertiaryColor)),
                        ],
                      ),
                    ),
                    for (var i = 0;
                        i <
                            flightBookingController
                                .flightDetails.value.flightSegments.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: flyternSpaceLarge),
                        child: FlightDetailsItineraryCard(
                            flightSegment: flightBookingController
                                .flightDetails.value.flightSegments[i]),
                      ),
                    Visibility(
                      visible: flightBookingController
                          .selectedTravelInfo.value.isNotEmpty,
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("passengers".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),
                    for (var i = 0;
                        i <
                            flightBookingController
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
                              "${flightBookingController.selectedTravelInfo[i].firstName} ${flightBookingController.selectedTravelInfo[i].lastName}",
                          age: getAge(flightBookingController
                              .selectedTravelInfo[i].dateOfBirth),
                          gender: flightBookingController
                              .selectedTravelInfo[i].gender,
                          passportNumber: flightBookingController
                              .selectedTravelInfo[i].passportNumber,
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
        bottomSheet: flightBookingController
                .isFlightTravellerDataSaveLoading.value
            ? Container(width: screenwidth,height: 60)
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
                          flightBookingController.setPaymentGateway();
                          // Get.toNamed(Approute_flightsConfirmation, arguments: [
                          //   {"mode": "view"}
                          // ]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${flightBookingController.cabinInfo.value.currency}"
                                    " ${(flightBookingController.cabinInfo.value.finalAmount +
                                    flightBookingController.seatTotalAmount.value +
                                    flightBookingController.mealTotalAmount.value +
                                    flightBookingController.baggageTotalAmount.value +
                                    flightBookingController.processingFee.value)}",
                              ),
                            ),
                            Visibility(
                                visible: !flightBookingController.isFlightSavePaymentGatewayLoading.value,
                                child: Text("next".tr)),
                            Visibility(
                                visible: flightBookingController.isFlightSavePaymentGatewayLoading.value,
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

  getAge(DateTime dateOfBirth) {
    return "${DateTime.now().year - dateOfBirth.year} years";
  }
}
