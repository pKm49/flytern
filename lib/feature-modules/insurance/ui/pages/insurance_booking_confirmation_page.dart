import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/shared/ui/components/user_details_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class InsuranceBookingConfirmationPage extends StatefulWidget {
  const InsuranceBookingConfirmationPage({super.key});

  @override
  State<InsuranceBookingConfirmationPage> createState() => _InsuranceBookingConfirmationPageState();
}

class _InsuranceBookingConfirmationPageState extends State<InsuranceBookingConfirmationPage> {

  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();

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
                  Text("123123",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),


            Padding(
              padding: flyternLargePaddingAll,
              child: Text("payment_summary".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ticket_price".tr ,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("AED 10,000",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("tax".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("AED 200",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("total".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("AED 1520",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("payment_method".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("apple_pay".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("payment_status".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("captured".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("payment_reference".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("123123",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),

            Padding(
              padding: flyternLargePaddingAll,
              child: Text("user_details".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            UserDetailsCard(
              onDelete: (){},
              onEdit: (){},
              isActionAllowed:false,
              name: "adult".tr,
              age: "Andrew Martin",
              gender: "andrewmartin@gmail.com",
              passportNumber: "+92 334431234",
            ),

            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            UserDetailsCard(
              onDelete: (){},
              onEdit: (){},
              isActionAllowed:false,
              name: "adult".tr,
              age: "Andrew Martin",
              gender: "andrewmartin@gmail.com",
              passportNumber: "+92 334431234",
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            UserDetailsCard(
              onDelete: (){},
              onEdit: (){},
              isActionAllowed:false,
              name: "adult".tr,
              age: "Andrew Martin",
              gender: "andrewmartin@gmail.com",
              passportNumber: "+92 334431234",
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            UserDetailsCard(
              onDelete: (){},
              onEdit: (){},
              isActionAllowed:false,
              name: "adult".tr,
              age: "Andrew Martin",
              gender: "andrewmartin@gmail.com",
              passportNumber: "+92 334431234",
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
                  Text("COVID-19",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("Individual",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("Silver",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("One Week",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("18 Apr 23",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Get.offAllNamed(Approute_landingpage);
                },
                child:Text("get_insurance".tr )),
          ),
        ),
      ),
    );
  }
}
