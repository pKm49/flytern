import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking.controller.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/list_card.activity_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/booking_summary_card.flight_booking.component.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/search_result_card.hotel_booking.component.dart';
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

class ActivityBookingSummaryPage extends StatefulWidget {
  const ActivityBookingSummaryPage({super.key});

  @override
  State<ActivityBookingSummaryPage> createState() => _ActivityBookingSummaryPageState();
}

class _ActivityBookingSummaryPageState extends State<ActivityBookingSummaryPage> {

  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();
  final activityBookingController = Get.find<ActivityBookingController>();

  int selectedPaymentMethod = 1;

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
                  visible: activityBookingController
                      .isSaveContactLoading.value,
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
                visible: !activityBookingController
                    .isSaveContactLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: ListView(
                    children: [
                      for (var i = 0;
                      i < activityBookingController.alert.length;
                      i++)
                        Container(
                          padding: flyternLargePaddingAll.copyWith(bottom: 0),
                          child: DataCapsuleCard(
                            label: activityBookingController.alert[i],
                            theme: 1,
                          ),
                        ),
                      for (var i = 0;
                      i < getBookingInfoGroupLength(activityBookingController.bookingInfo);
                      i++)
                        Wrap(
                          children: [
                            Padding(
                              padding: flyternLargePaddingAll,
                              child: Text(
                                  getBookingInfoGroupName(activityBookingController.bookingInfo,i),
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ),
                            Container(
                              height: ( getBookingInfoGroupSize(activityBookingController.bookingInfo,i) *
                                  50)+(flyternSpaceLarge*2),
                              child: Column(
                                children: [
                                  for (var ind = 0;
                                  ind < getBookingInfoGroupSize(activityBookingController.bookingInfo,i);
                                  ind++)
                                    getBookingInfoTitle(activityBookingController.bookingInfo,
                                        i, ind) !=
                                        "DIVIDER"
                                        ? Container(
                                      padding: flyternLargePaddingHorizontal
                                          .copyWith(
                                          top: ind == 0
                                              ? flyternSpaceLarge
                                              : flyternSpaceMedium,
                                          bottom: ind == getBookingInfoGroupSize(activityBookingController.bookingInfo,
                                              i) -
                                              1
                                              ? flyternSpaceLarge
                                              : flyternSpaceMedium),
                                      decoration: BoxDecoration(
                                          color: flyternBackgroundWhite,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ind == getBookingInfoGroupSize(activityBookingController.bookingInfo,
                                                  i) -
                                                  1
                                                  ? Colors.transparent
                                                  : flyternGrey20,
                                              width: 0.5,
                                            ),
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              getBookingInfoTitle(activityBookingController.bookingInfo,
                                                  i, ind),
                                              style: getBodyMediumStyle(
                                                  context)
                                                  .copyWith(
                                                  color:
                                                  flyternGrey60)),
                                          Text( getBookingInfoValue(activityBookingController.bookingInfo,
                                              i, ind),
                                              style: getBodyMediumStyle(
                                                  context)
                                                  .copyWith(
                                                  color:
                                                  flyternGrey80)),
                                        ],
                                      ),
                                    )
                                        : ind != getBookingInfoGroupSize(activityBookingController.bookingInfo,
                                        i) -
                                        1?Container(
                                        padding:
                                        flyternLargePaddingHorizontal,
                                        color: flyternBackgroundWhite,
                                        child:
                                        Divider(height: 3, thickness: 3)):Container(),
                                ],
                              ),
                            )
                          ],
                        ),

                      Padding(
                        padding: flyternLargePaddingAll.copyWith(top: 0),
                        child: Text("select_payment_method".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      for (var i = 0;
                      i < activityBookingController.paymentGateways.length;
                      i++)
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: i == activityBookingController.paymentGateways.length-1?Colors.transparent:flyternGrey20,
                                width: 0.5,
                              ),
                            ),
                            color: flyternBackgroundWhite,
                          ),
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium,
                              bottom: i ==
                                  activityBookingController
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
                                              activityBookingController.paymentGateways
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
                                        activityBookingController
                                            .paymentGateways.value[i].displayName,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: flyternGrey80)),
                                  ],
                                ),
                              ),
                              Radio(
                                activeColor: flyternSecondaryColor,
                                value: activityBookingController
                                    .paymentGateways.value[i].processID,
                                groupValue:
                                activityBookingController.selectedGateway.value.processID,
                                onChanged: (value) {
                                  activityBookingController.updateProcessId(value);
                                },
                              ),
                            ],
                          ),
                        ),
                      Visibility(
                        visible: activityBookingController.selectedGateway.value.processingFee  != 0.0,
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
                                  "${activityBookingController.selectedGateway.value.currencyCode} "
                                      "${activityBookingController.selectedGateway.value.processingFee}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: activityBookingController.selectedGateway.value.finalAmount != 0.0,                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: activityBookingController.selectedGateway.value.finalAmount != 0.0,
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
                                  "${activityBookingController.selectedGateway.value.currencyCode}"
                                      " ${activityBookingController.selectedGateway.value.finalAmount}",
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ],
                          ),
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
                        activityBookingController.setPaymentGateway();
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${activityBookingController.selectedGateway.value.currencyCode}"
                                  " ${activityBookingController.selectedGateway.value.finalAmount}",
                            ),
                          ),
                          Visibility(
                              visible: !activityBookingController.isActivitySavePaymentGatewayLoading.value,
                              child: Text("next".tr)),
                          Visibility(
                              visible: activityBookingController.isActivitySavePaymentGatewayLoading.value,
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
            activityBookingController.resetAndNavigateToHome();
          },
          titleKey: 'cancel_booking'.tr + " ?",
          subtitleKey: 'cancel_confirm'.tr),
    );
  }
  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat.yMMMMd();
    return f.format(dateTime);
  }
}
