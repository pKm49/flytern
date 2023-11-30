import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/list_card.activity_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/booking_summary_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance.controller.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
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

class InsuranceBookingConfirmationPage extends StatefulWidget {
  const InsuranceBookingConfirmationPage({super.key});

  @override
  State<InsuranceBookingConfirmationPage> createState() => _InsuranceBookingConfirmationPageState();
}

class _InsuranceBookingConfirmationPageState extends State<InsuranceBookingConfirmationPage> {

  final insuranceBookingController = Get.find<InsuranceBookingController>();

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
              visible: insuranceBookingController
                  .isInsuranceConfirmationDataLoading.value,
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
            visible: !insuranceBookingController
                .isInsuranceConfirmationDataLoading.value,
            child: Container(
              width: screenwidth,
              height: screenheight,
              color: flyternGrey10,
              child: ListView(
                children: [

                  addVerticalSpace(flyternSpaceLarge*2),
                  Text(
                      getPaymentInfo(insuranceBookingController.paymentInfo,"ThankyouMsg"),
                      textAlign: TextAlign.center,
                      style: getHeadlineLargeStyle(context).copyWith(
                          color: flyternGuideGreen, fontWeight: flyternFontWeightBold)),
                  Image.network(
                    getPaymentInfo(insuranceBookingController.paymentInfo,"ConfirmIcon"),
                    width: screenwidth * .4,
                    height: screenwidth * .4,
                    errorBuilder:
                        (context, error, stackTrace) {
                      return  Icon(
                          Ionicons.checkmark_circle_outline  ,
                          size: screenwidth*.4,color:flyternGuideGreen);
                    },
                  ),
                  Text(
                      getPaymentInfo(insuranceBookingController.paymentInfo,"ConfirmMsg"),
                      textAlign: TextAlign.center,
                      style: getHeadlineLargeStyle(context).copyWith(
                          color: flyternGuideGreen, fontWeight: flyternFontWeightBold)),

                  addVerticalSpace(flyternSpaceLarge*2),
                  Container(
                    padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                    color: flyternBackgroundWhite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getPaymentTitle(insuranceBookingController.paymentInfo, "BookingID"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Text(getPaymentInfo(insuranceBookingController.paymentInfo,"BookingID"),
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightRegular)),
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
                        Text(getPaymentTitle(insuranceBookingController.paymentInfo, "PaymentStatus"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Text(getPaymentInfo(insuranceBookingController.paymentInfo,"PaymentStatus"),
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightRegular)),
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
                        Text(getPaymentTitle(insuranceBookingController.paymentInfo, "PaymentMethod"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                        Expanded(child: Container()),
                        Container(
                            decoration:
                            flyternBorderedContainerSmallDecoration,
                            clipBehavior: Clip.hardEdge,
                            width: screenwidth * .1,
                            height: screenwidth * .1,
                            child: Center(
                                child: Image.network(
                                  getPaymentInfo(insuranceBookingController.paymentInfo,"PaymentMethodIcon"),
                                  width: screenwidth * .08,
                                  height: screenwidth * .08,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                        width: screenwidth * .08,
                                        height: screenwidth * .08);
                                  },
                                ))),
                        addHorizontalSpace(flyternSpaceMedium),
                        Text(getPaymentInfo(insuranceBookingController.paymentInfo,"PaymentMethod"),
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightRegular)),
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
                        Text(getPaymentTitle(insuranceBookingController.paymentInfo, "FinalBookingAmount"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),

                        Text(getPaymentInfo(insuranceBookingController.paymentInfo,"FinalBookingAmount"),
                            style: getBodyMediumStyle(context).copyWith(
                                fontWeight: flyternFontWeightRegular)),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: insuranceBookingController.isIssued.value,
                    child: InkWell(
                      onTap: (){
                        _launchUrl(insuranceBookingController.pdfLink.value);
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
                  i < insuranceBookingController.alert.length;
                  i++)
                    Container(
                      padding: flyternLargePaddingAll.copyWith(bottom: 0),
                      child: DataCapsuleCard(
                        label: insuranceBookingController.alert[i],
                        theme: 1,
                      ),
                    ),

                  for (var i = 0;
                  i < getBookingInfoGroupLength(insuranceBookingController.bookingInfo);
                  i++)
                    Wrap(
                      children: [
                        Padding(
                          padding: flyternLargePaddingAll,
                          child: Text(
                              getBookingInfoGroupName(insuranceBookingController.bookingInfo,i),
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                        Container(
                          height: ( getBookingInfoGroupSize(insuranceBookingController.bookingInfo,i) *
                              50)+(flyternSpaceLarge*2),
                          child: Column(
                            children: [
                              for (var ind = 0;
                              ind < getBookingInfoGroupSize(insuranceBookingController.bookingInfo,i);
                              ind++)
                                getBookingInfoTitle(insuranceBookingController.bookingInfo,
                                    i, ind) !=
                                    "DIVIDER"
                                    ? Container(
                                  padding: flyternLargePaddingHorizontal
                                      .copyWith(
                                      top: ind == 0
                                          ? flyternSpaceLarge
                                          : flyternSpaceMedium,
                                      bottom: ind == getBookingInfoGroupSize(insuranceBookingController.bookingInfo,
                                          i) -
                                          1
                                          ? flyternSpaceLarge
                                          : flyternSpaceMedium),
                                  decoration: BoxDecoration(
                                      color: flyternBackgroundWhite,
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ind == getBookingInfoGroupSize(insuranceBookingController.bookingInfo,
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
                                          getBookingInfoTitle(insuranceBookingController.bookingInfo,
                                              i, ind),
                                          style: getBodyMediumStyle(
                                              context)
                                              .copyWith(
                                              color:
                                              flyternGrey60)),
                                      Text( getBookingInfoValue(insuranceBookingController.bookingInfo,
                                          i, ind),
                                          style: getBodyMediumStyle(
                                              context)
                                              .copyWith(
                                              color:
                                              flyternGrey80)),
                                    ],
                                  ),
                                )
                                    : ind != getBookingInfoGroupSize(insuranceBookingController.bookingInfo,
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
                            insuranceBookingController.processId.value,
                            onChanged: (value) {
                              insuranceBookingController.updateProcessId(value);
                            },
                          ),
                        ],
                      ),
                    ),


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
                    padding: flyternLargePaddingAll.copyWith(top: flyternSpaceLarge*2),
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
                  insuranceBookingController.resetAndNavigateToHome();
                },
                child:Text( "continue".tr )),
          ),
        ),
      ),
    );
  }

  getAge(DateTime dateOfBirth) {
    return "${DateTime.now().year - dateOfBirth.year} years";
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {
      print('Could not launch $_url');
    }
  }

  String getFormattedDOB(DateTime dateOfBirth) {
    final f = DateFormat.yMMMMd('en_US');
    return f.format(dateOfBirth);
  }

}
