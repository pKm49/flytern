import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class InsuranceBookingSummaryPage extends StatefulWidget {
  const InsuranceBookingSummaryPage({super.key});

  @override
  State<InsuranceBookingSummaryPage> createState() => _InsuranceBookingSummaryPageState();
}

class _InsuranceBookingSummaryPageState extends State<InsuranceBookingSummaryPage> {

  final insuranceBookingController = Get.find<InsuranceBookingController>();

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
            title: Text('payment_summary'.tr),
            elevation: 0.5,
          ),
          body: Stack(
            children: [
              Visibility(
                  visible:insuranceBookingController
                      .isInsuranceConfirmationDataLoading.value ||
                      insuranceBookingController
                          .isInsuranceGatewayStatusCheckLoading.value ||
                      insuranceBookingController
                      .isInsuranceSaveTravellerLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight * .9,
                    color: flyternGrey10,
                    child: Center(
                        child: LoadingAnimationWidget.prograssiveDots(
                          color: flyternSecondaryColor,
                          size: 50,
                        )),
                  )),

              Visibility(
                visible: !insuranceBookingController
                    .isInsuranceConfirmationDataLoading.value &&
                    !insuranceBookingController
                        .isInsuranceConfirmationDataLoading.value &&
                    !insuranceBookingController
                        .isInsuranceGatewayStatusCheckLoading.value &&
                    !insuranceBookingController
                    .isInsuranceSaveTravellerLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight,
                  color: flyternGrey10,
                  child: ListView(
                    children: [

                      Visibility(
                        visible:insuranceBookingController.alert.isEmpty
                            && insuranceBookingController.paymentGateways.isEmpty &&
                            getBookingInfoGroupLength(
                                insuranceBookingController.bookingInfo)==
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
                      i < insuranceBookingController.alert.length;
                      i++)
                        Container(
                          padding: flyternLargePaddingAll.copyWith(bottom: 0),
                          child: DataCapsuleCard(
                            label: insuranceBookingController.alert[i],
                            theme: 1,
                          ),
                        ),


                      Visibility(
                        visible: insuranceBookingController.paymentGateways.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Text("select_payment_method".tr,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      for (var i = 0;
                      i < insuranceBookingController.paymentGateways.length;
                      i++)
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: i == insuranceBookingController.paymentGateways.length-1?Colors.transparent:flyternGrey20,
                                width: 0.5,
                              ),
                            ),
                            color: flyternBackgroundWhite,
                          ),
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium,
                              bottom: i ==
                                  insuranceBookingController
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
                                              insuranceBookingController.paymentGateways
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
                                        insuranceBookingController
                                            .paymentGateways.value[i].displayName,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: flyternGrey80)),
                                  ],
                                ),
                              ),
                              Radio(
                                activeColor: flyternSecondaryColor,
                                value: insuranceBookingController
                                    .paymentGateways.value[i].processID,
                                groupValue:
                                insuranceBookingController.selectedPaymentGateway.value.processID,
                                onChanged: (value) {
                                  insuranceBookingController.updateProcessId(value);
                                },
                              ),
                            ],
                          ),
                        ),


                      Visibility(
                        visible: insuranceBookingController.paymentGateways.isNotEmpty,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("processing_fee".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                              Text("${insuranceBookingController.selectedPaymentGateway.value.currencyCode}"
                                  " ${insuranceBookingController.selectedPaymentGateway.value.processingFee}",
                                  style: getBodyMediumStyle(context).copyWith(color: flyternGrey80 )),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: insuranceBookingController.paymentGateways.isNotEmpty,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color:flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: insuranceBookingController.paymentGateways.isNotEmpty,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("grand_total".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                              Text("${insuranceBookingController.selectedPaymentGateway.value.currencyCode}"
                                  " ${insuranceBookingController.selectedPaymentGateway.value.finalAmount.toStringAsFixed(3)}",
                                  style: getBodyMediumStyle(context).copyWith(color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ],
                          ),
                        ),
                      ),


                      for (var i = 0;
                      i <
                          getBookingInfoGroupLength(
                              insuranceBookingController.bookingInfo);
                      i++)
                        Wrap(
                          children: [
                            Padding(
                              padding: flyternLargePaddingAll,
                              child: Text(
                                  getBookingInfoGroupName(
                                      insuranceBookingController.bookingInfo, i),
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
                                          insuranceBookingController
                                              .bookingInfo,
                                          i);
                                  ind++)
                                    getBookingInfoTitle(
                                        insuranceBookingController
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
                                                  insuranceBookingController
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
                                                      insuranceBookingController
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
                                                  insuranceBookingController
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
                                                    insuranceBookingController
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
                                            insuranceBookingController
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
          insuranceBookingController
              .isInsuranceConfirmationDataLoading.value ||
              insuranceBookingController
                  .isInsuranceGatewayStatusCheckLoading.value ||
              insuranceBookingController
                  .isInsuranceSaveTravellerLoading.value ||
          insuranceBookingController.paymentGateways.isEmpty?Container(width: screenwidth,height: 1,):Container(
            width: screenwidth,
            color: flyternBackgroundWhite,
            height: 60+(flyternSpaceSmall*2),
            padding: flyternLargePaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(style: getElevatedButtonStyle(context),
                    onPressed: () {
                      insuranceBookingController.setPaymentGateway();

                     },
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                              "${insuranceBookingController.selectedPaymentGateway.value.currencyCode}"
                                  " ${(insuranceBookingController.selectedPaymentGateway.value.finalAmount.toStringAsFixed(3) )}"
                          ),
                        ),
                        Visibility(
                            visible: !insuranceBookingController.isInsuranceSavePaymentGatewayLoading.value,
                            child: Text("next".tr)),
                        Visibility(
                            visible: insuranceBookingController.isInsuranceSavePaymentGatewayLoading.value,
                            child:  LoadingAnimationWidget.prograssiveDots(
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
            insuranceBookingController.resetAndNavigateToHome();
          },
          titleKey: 'cancel_booking'.tr + " ?",
          subtitleKey: 'cancel_confirm'.tr),
    );
  }
  getAge(DateTime dateOfBirth) {
    return "${DateTime.now().year - dateOfBirth.year} years";
  }
  String getFormattedDOB(DateTime dateOfBirth) {
    final f = DateFormat.yMMMMd('en_US');
    return f.format(dateOfBirth);
  }
}
