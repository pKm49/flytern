import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking_controller.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ActivityBookingSummaryPage extends StatefulWidget {
  const ActivityBookingSummaryPage({super.key});

  @override
  State<ActivityBookingSummaryPage> createState() => _ActivityBookingSummaryPageState();
}

class _ActivityBookingSummaryPageState extends State<ActivityBookingSummaryPage> {

  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();
  final activityBookingController = Get.put(ActivityBookingController());

  int selectedPaymentMethod = 1;

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('summary'.tr),
        elevation: 0.5,
      ),
      body: Container(
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
              visible: activityBookingController.selectedActivityTransferType.value.tourId != "",
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
                        "${activityBookingController.selectedActivityTransferType.value.currency} "
                            "${activityBookingController.selectedActivityTransferType.value.finalAmount}",
                        style: getBodyMediumStyle(context)
                            .copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: activityBookingController.selectedActivityTransferType.value.tourId != "",
              child: Container(
                  padding: flyternLargePaddingHorizontal,
                  color: flyternBackgroundWhite,
                  child: Divider()),
            ),

            Visibility(
              visible: activityBookingController.processingFee.value  != 0.0,
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
                        "${activityBookingController.selectedActivityTransferType.value.currency} ${activityBookingController.processingFee.value}",
                        style: getBodyMediumStyle(context)
                            .copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
            ),

            Visibility(
              visible: activityBookingController.selectedActivityTransferType.value.tourId != "",
              child: Container(
                  padding: flyternLargePaddingHorizontal,
                  color: flyternBackgroundWhite,
                  child: Divider()),
            ),
            Visibility(
              visible: activityBookingController.selectedActivityTransferType.value.tourId != "",
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
                        "${activityBookingController.selectedActivityTransferType.value.currency}"
                            " ${(double.parse(activityBookingController.selectedActivityTransferType.value.finalAmount) +
                            activityBookingController.processingFee.value)}",
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
            i < activityBookingController.paymentGateways.length;
            i++)
              Container(
                decoration: BoxDecoration(
                  border: flyternDefaultBorderBottomOnly,
                  color: flyternBackgroundWhite,
                ),
                padding: flyternLargePaddingHorizontal.copyWith(
                    top: flyternSpaceMedium,
                    bottom: i==activityBookingController.paymentGateways.length-1?
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
                      groupValue: activityBookingController.processId.value,
                      onChanged: (value) {
                        activityBookingController.updateProcessId(value);
                      },
                    ),
                  ],
                ),
              ),
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("activity_details".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(
                  top: flyternSpaceLarge, bottom: flyternSpaceSmall),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      "${activityBookingController.activityDetails.value.tourName}" ,
                      maxLines: 2,
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
              child: Text(
                  "${activityBookingController
                      .selectedActivityOption.value.optionName}" ,
                  maxLines: 2,
                  style: getBodyMediumStyle(context)
                      .copyWith(color: flyternGrey80)),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color: flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(
                  top: flyternSpaceSmall, bottom: flyternSpaceSmall),
              color: flyternBackgroundWhite,
              width: screenwidth,
              child:Text(
                  activityBookingController
                      .selectedActivityTransferType.value.transferName ,
                  maxLines: 2,
                  style: getBodyMediumStyle(context)
                      .copyWith(color: flyternGrey80)),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      getFormattedDate(activityBookingController.travelDate.value)+
                      " - ${activityBookingController.selectedActivityTime.value.timeSlot}",
                      maxLines: 2,
                      style: getBodyMediumStyle(context)
                          .copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Container(
              height: 70+(flyternSpaceSmall*2),
              padding: flyternLargePaddingAll,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: screenwidth,
        color: flyternBackgroundWhite,
        height: 60+(flyternSpaceSmall*2),
        padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(style: getElevatedButtonStyle(context),
                onPressed: () {
                    activityBookingController.setPaymentGateway();
                 },
                child:Text("proceed".tr )),
          ),
        ),
      ),
    );
  }

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat.yMMMMd();
    return f.format(dateTime);
  }
}
