import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking_controller.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityBookingConfirmationPage extends StatefulWidget {
  const ActivityBookingConfirmationPage({super.key});

  @override
  State<ActivityBookingConfirmationPage> createState() => _ActivityBookingConfirmationPageState();
}

class _ActivityBookingConfirmationPageState extends State<ActivityBookingConfirmationPage> {

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
        title: Text('booking_confirmation'.tr),
        elevation: 0.5,
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        color: flyternGrey10,
        child: ListView(
          children: [
            Container(
              width: screenwidth,
              height: screenwidth*.6,
              child: Center(
                child: Column(
                  children: [
                    Icon(Ionicons.checkmark_circle_outline,size: screenwidth*.4,color: flyternGuideGreen),
                    Padding(
                      padding: EdgeInsets.only(top: flyternSpaceLarge),
                      child: Text(
                          activityBookingController.bookingRef.value !=""?
                          "success".tr:"failed".tr,
                          textAlign: TextAlign.center,
                          style: getHeadlineLargeStyle(context).copyWith(
                              color: flyternGuideGreen, fontWeight: flyternFontWeightBold)),
                    ),
                  ],
                ),
              ),
            ),
            addVerticalSpace(flyternSpaceMedium),
            Padding(
              padding: flyternLargePaddingAll,
              child: Text("booking_details".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("booking_status".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("Confirmed",style: getBodyMediumStyle(context).copyWith(color: flyternPrimaryColor,fontWeight: flyternFontWeightBold)),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("booking_id".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text(activityBookingController.bookingRef.value,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            Visibility(
              visible: activityBookingController.pdfLink.value !="" && activityBookingController.pdfLink.value!="null",
              child: InkWell(
                onTap: (){
                  _launchUrl(activityBookingController.pdfLink.value);
                },
                child: Container(
                  padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
                  color: flyternBackgroundWhite,
                  child:  Text("get_eticket".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          decoration: TextDecoration.underline,
                          color: flyternTertiaryColor)),
                ),
              ),
            ),

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
            Visibility(
              visible: activityBookingController.selectedActivityTransferType.value.tourId != "",
              child: Container(
                padding: flyternLargePaddingHorizontal.copyWith(
                    top: flyternSpaceSmall, bottom: flyternSpaceLarge),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${'payment_gateway'.tr} ",
                        style: getBodyMediumStyle(context)
                            .copyWith(color: flyternGrey60)),
                    Text(
                        "${activityBookingController.paymentCode.value}",
                        style: getBodyMediumStyle(context).copyWith(
                            color: flyternGrey80,
                            fontWeight: flyternFontWeightBold)),
                  ],
                ),
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
                      getFormattedDate(activityBookingController.travelDate.value) +
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
                  activityBookingController.resetAndNavigateToHome();
                },
                child:Text("continue".tr )),
          ),
        ),
      ),
    );
  }

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat.yMMMMd();
    return f.format(dateTime);
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
      print('Could not launch $_url');
    }
  }
  }
