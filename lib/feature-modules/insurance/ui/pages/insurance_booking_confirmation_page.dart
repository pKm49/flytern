import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/feature-modules/insurance/controllers/insurance_controller.dart';
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
                          insuranceBookingController.bookingRef.value !=""?
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
                  Text(insuranceBookingController.bookingRef.value,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),
            InkWell(
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
