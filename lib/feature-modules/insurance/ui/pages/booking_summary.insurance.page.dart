import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
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

    return Obx(
      ()=> Scaffold(
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
                child: Text("price_details".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),

              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("total_fare".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("${insuranceBookingController.selectedPaymentGateway.value.currencyCode}"
                        " ${insuranceBookingController.selectedPaymentGateway.value.totalAmount}",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),

              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("discount".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("${insuranceBookingController.selectedPaymentGateway.value.currencyCode}"
                        " ${insuranceBookingController.selectedPaymentGateway.value.discount}",
                        style: getBodyMediumStyle(context).copyWith(color: flyternGuideGreen)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),

              Container(
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
                    Text("grand_total".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("${insuranceBookingController.selectedPaymentGateway.value.currencyCode}"
                        " ${insuranceBookingController.selectedPaymentGateway.value.finalAmount}",
                        style: getBodyMediumStyle(context).copyWith(color: flyternGrey80,
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
              i < insuranceBookingController.paymentGateways.length;
              i++)
                Container(
                  decoration: BoxDecoration(
                    border: flyternDefaultBorderBottomOnly,
                    color: flyternBackgroundWhite,
                  ),
                  padding: flyternLargePaddingHorizontal.copyWith(
                      top: flyternSpaceMedium,
                      bottom: i==insuranceBookingController.paymentGateways.length-1?
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
                        groupValue: insuranceBookingController.processId.value,
                        onChanged: (value) {
                          insuranceBookingController.updateProcessId(value);
                        },
                      ),
                    ],
                  ),
                ),


              Padding(
                padding: flyternLargePaddingAll,
                child: Text("insurance_details".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text(insuranceBookingController.policyHeaderObj.value.name,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy_type".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text(insuranceBookingController.policyTypeObj.value.name,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy_plan".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text(insuranceBookingController.policyOptionObj.value.name,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
              Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
              Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("policy_period".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text(insuranceBookingController.policyPeriodObj.value.name,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                    Text("policy_start_date".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text(getFormattedDOB(insuranceBookingController.policyDate.value),style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),

              Padding(
                padding: flyternLargePaddingAll,
                child: Text("user_details".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),
              for (var i = 0;
              i <
                  insuranceBookingController
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
                    "${insuranceBookingController.selectedTravelInfo[i].firstName} ${insuranceBookingController.selectedTravelInfo[i].lastName}",
                    age: getAge(insuranceBookingController
                        .selectedTravelInfo[i].dateOfBirth),
                    gender: insuranceBookingController
                        .selectedTravelInfo[i].gender,
                    passportNumber: insuranceBookingController
                        .selectedTravelInfo[i].passportNumber,
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
                    insuranceBookingController.setPaymentGateway();

                   },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            "${insuranceBookingController.selectedPaymentGateway.value.currencyCode}"
                                " ${(insuranceBookingController.selectedPaymentGateway.value.finalAmount )}"
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
  String getFormattedDOB(DateTime dateOfBirth) {
    final f = DateFormat.yMMMMd('en_US');
    return f.format(dateOfBirth);
  }
}