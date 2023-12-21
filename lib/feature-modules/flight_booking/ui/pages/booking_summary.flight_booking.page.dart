import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/details_itinerary_card.flight_booking.component.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
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

    return WillPopScope(
      onWillPop: () async {
        showConfirmDialog();
        return false;
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Text('payment_summary'.tr),
            elevation: 0.5,
          ),
          body: Stack(
            children: [
              Visibility(
                  visible: flightBookingController
                          .isFlightTravellerDataSaveLoading.value ||
                      flightBookingController
                          .isFlightGatewayStatusCheckLoading.value ||
                      flightBookingController
                          .isFlightSavePaymentGatewayLoading.value ||
                      flightBookingController
                          .isFlightConfirmationDataLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight * .9,
                    color: flyternGrey10,
                    child: Center(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            LoadingAnimationWidget.prograssiveDots(
                              color: flyternSecondaryColor,
                              size: 50,
                            ),
                            Visibility(
                              visible: flightBookingController
                                  .isFlightSavePaymentGatewayLoading.value,
                              child: Padding(
                                padding: flyternLargePaddingAll,
                                child: DataCapsuleCard(
                                  label: "flight_gateway_submission_message".tr,
                                  theme: 1,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: flightBookingController
                                  .isFlightConfirmationDataLoading.value,
                              child: Padding(
                                padding: flyternLargePaddingAll,
                                child: DataCapsuleCard(
                                  label: "flight_confirmation_loading_message".tr,
                                  theme: 1,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: flightBookingController
                                  .isFlightTravellerDataSaveLoading.value,
                              child: Padding(
                                padding: flyternLargePaddingAll,
                                child: DataCapsuleCard(
                                  label: "flight_traveller_submission_message".tr,
                                  theme: 1,
                                ),
                              ),
                            ),
                          ],
                        )),
                  )),
              Visibility(
                visible: !flightBookingController
                        .isFlightTravellerDataSaveLoading.value &&
                    !flightBookingController
                        .isFlightGatewayStatusCheckLoading.value &&
                    !flightBookingController
                        .isFlightSavePaymentGatewayLoading.value &&
                    !flightBookingController
                        .isFlightConfirmationDataLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: ListView(
                    children: [

                      Visibility(
                        visible:flightBookingController.alert.isEmpty && flightBookingController.paymentGateways.isEmpty &&
                            flightBookingController
                                .flightDetails.value.flightSegments.isEmpty,
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
                          i < flightBookingController.alert.length;
                          i++)
                        Container(
                          padding: flyternMediumPaddingAll,
                          margin: flyternLargePaddingAll.copyWith(
                              bottom: flyternSpaceMedium),
                          decoration: BoxDecoration(
                            color: flyternPrimaryColorBg,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: Html(
                            data: flightBookingController.alert[i],
                          ),
                        ),
                      Visibility(
                        visible:
                            flightBookingController.paymentGateways.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Text("select_payment_method".tr,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      for (var i = 0;
                          i < flightBookingController.paymentGateways.length;
                          i++)
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: i ==
                                        flightBookingController
                                                .paymentGateways.length -
                                            1
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
                                      flightBookingController
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
                                          flightBookingController
                                              .paymentGateways
                                              .value[i]
                                              .gatewayImageUrl,
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
                                        flightBookingController.paymentGateways
                                            .value[i].displayName,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: flyternGrey80)),
                                  ],
                                ),
                              ),
                              Radio(
                                activeColor: flyternSecondaryColor,
                                value: flightBookingController
                                    .paymentGateways.value[i].processID,
                                groupValue: flightBookingController
                                    .selectedPaymentGateway.value.processID,
                                onChanged: (value) {
                                  flightBookingController
                                      .updateProcessId(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      Visibility(
                        visible:
                            flightBookingController.paymentGateways.isNotEmpty,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall,
                              bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("processing_fee".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.selectedPaymentGateway.value.currencyCode} "
                                  "${flightBookingController.selectedPaymentGateway.value.processingFee}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            flightBookingController.paymentGateways.isNotEmpty,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible:
                            flightBookingController.paymentGateways.isNotEmpty,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall,
                              bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${'grand_total'.tr} ",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.selectedPaymentGateway.value.currencyCode}"
                                  " ${flightBookingController.selectedPaymentGateway.value.finalAmount}",
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ],
                          ),
                        ),
                      ),
                      for (var i = 0;
                          i <
                              getBookingInfoGroupLength(
                                  flightBookingController.bookingInfo);
                          i++)
                        Wrap(
                          children: [
                            Padding(
                              padding: flyternLargePaddingAll,
                              child: Text(
                                  getBookingInfoGroupName(
                                      flightBookingController.bookingInfo, i),
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
                                              flightBookingController
                                                  .bookingInfo,
                                              i);
                                      ind++)
                                    getBookingInfoTitle(
                                                flightBookingController
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
                                                                flightBookingController
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
                                                                    flightBookingController
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
                                                        flightBookingController
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
                                                          flightBookingController
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
                                                        flightBookingController
                                                            .bookingInfo,
                                                        i) -
                                                    1
                                            ? Container(
                                                color: flyternBackgroundWhite,
                                                child: const Divider(
                                                    color: flyternTertiaryColor,
                                                    height: 3,
                                                    thickness: 1))
                                            : Container(),
                                ],
                              ),
                            )
                          ],
                        ),
                      Visibility(
                        visible: flightBookingController
                            .flightDetails.value.flightSegments.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll.copyWith(
                              top: flyternSpaceLarge * 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("flight_summary".tr,
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ],
                          ),
                        ),
                      ),
                      for (var i = 0;
                          i <
                              flightBookingController
                                  .flightDetails.value.flightSegments.length;
                          i++)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: flyternSpaceLarge),
                          child: FlightDetailsItineraryCard(
                              flightSegment: flightBookingController
                                  .flightDetails.value.flightSegments[i]),
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
                      .isFlightTravellerDataSaveLoading.value ||
              flightBookingController
                  .isFlightGatewayStatusCheckLoading.value ||
            flightBookingController
                .isFlightSavePaymentGatewayLoading.value ||
                  flightBookingController
                      .isFlightConfirmationDataLoading.value ||
                  flightBookingController.paymentGateways.isEmpty
              ? Container(width: screenwidth, height: 60)
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
                                  "${flightBookingController.selectedPaymentGateway.value.currencyCode}"
                                  " ${flightBookingController.selectedPaymentGateway.value.finalAmount}",
                                ),
                              ),
                              Visibility(
                                  visible: !flightBookingController
                                      .isFlightSavePaymentGatewayLoading.value,
                                  child: Text("next".tr)),
                              Visibility(
                                  visible: flightBookingController
                                      .isFlightSavePaymentGatewayLoading.value,
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
      builder: (_) => ConfirmDialogue(
          onClick: () async {
            flightBookingController.resetAndNavigateToHome();
          },
          titleKey: 'cancel_booking'.tr + " ?",
          subtitleKey: 'cancel_confirm'.tr),
    );
  }

  getAge(DateTime dateOfBirth) {
    return "${DateTime.now().year - dateOfBirth.year} years";
  }
}
