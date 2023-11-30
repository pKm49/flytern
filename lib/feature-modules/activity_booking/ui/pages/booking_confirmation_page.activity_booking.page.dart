import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking.controller.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/list_card.activity_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/booking_summary_card.flight_booking.component.dart';
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
      body: Stack(
        children: [
          Visibility(
              visible: activityBookingController
                  .isActivityConfirmationDataLoading.value,
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
                .isActivityConfirmationDataLoading.value,
            child: Container(
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
                          Icon(
                              activityBookingController.isIssued.value?
                              Ionicons.checkmark_circle_outline:
                              Ionicons.close_circle_outline,
                              size: screenwidth*.4,color:
                          activityBookingController.isIssued.value?
                          flyternGuideGreen:flyternGuideRed),
                          Padding(
                            padding: EdgeInsets.only(top: flyternSpaceLarge),
                            child: Text(
                                activityBookingController.isIssued.value?
                                "success".tr:"failed".tr,
                                textAlign: TextAlign.center,
                                style: getHeadlineLargeStyle(context).copyWith(
                                    color: activityBookingController.isIssued.value?
                                    flyternGuideGreen:flyternGuideRed, fontWeight: flyternFontWeightBold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  addVerticalSpace(flyternSpaceMedium),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                    color: flyternBackgroundWhite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("booking_status".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Text(activityBookingController.isIssued.value?
                        "success".tr:"failed".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: activityBookingController.isIssued.value?
                                flyternGuideGreen:flyternGuideRed,
                                fontWeight: flyternFontWeightBold)),
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
                    visible: activityBookingController.isIssued.value,
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
                  i < activityBookingController.getBookingInfoGroupLength();
                  i++)
                    Wrap(
                      children: [
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Text(
                              activityBookingController
                                  .getBookingInfoGroupName(i),
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                        Container(
                          height: (activityBookingController
                              .getBookingInfoGroupSize(i) *
                              50)+(flyternSpaceLarge*2),
                          child: Column(
                            children: [
                              for (var ind = 0;
                              ind <
                                  activityBookingController
                                      .getBookingInfoGroupSize(i);
                              ind++)
                                activityBookingController.getBookingInfoTitle(
                                    i, ind) !=
                                    "DIVIDER"
                                    ? Container(
                                  padding: flyternLargePaddingHorizontal
                                      .copyWith(
                                      top: ind == 0
                                          ? flyternSpaceLarge
                                          : flyternSpaceMedium,
                                      bottom: ind ==
                                          activityBookingController
                                              .getBookingInfoGroupSize(
                                              i) -
                                              1
                                          ? flyternSpaceLarge
                                          : flyternSpaceMedium),
                                  decoration: BoxDecoration(
                                      color: flyternBackgroundWhite,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ind ==
                                              activityBookingController
                                                  .getBookingInfoGroupSize(
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
                                          activityBookingController
                                              .getBookingInfoTitle(
                                              i, ind),
                                          style: getBodyMediumStyle(
                                              context)
                                              .copyWith(
                                              color:
                                              flyternGrey60)),
                                      Text(
                                          activityBookingController
                                              .getBookingInfoValue(
                                              i, ind),
                                          style: getBodyMediumStyle(
                                              context)
                                              .copyWith(
                                              color:
                                              flyternGrey80)),
                                    ],
                                  ),
                                )
                                    : ind !=
                                    activityBookingController
                                        .getBookingInfoGroupSize(
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
                            activityBookingController.processId.value,
                            onChanged: (value) {
                              activityBookingController.updateProcessId(value);
                            },
                          ),
                        ],
                      ),
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
                    padding: flyternLargePaddingAll.copyWith(top: flyternSpaceLarge*2),
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
