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

class InsuranceBookingSummaryPage extends StatefulWidget {
  const InsuranceBookingSummaryPage({super.key});

  @override
  State<InsuranceBookingSummaryPage> createState() => _InsuranceBookingSummaryPageState();
}

class _InsuranceBookingSummaryPageState extends State<InsuranceBookingSummaryPage> {

  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();

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
              child: Text("user_details".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            UserDetailsCard(
              isActionAllowed:false,
              title: "contributor".tr,
              name: "Andrew Martin",
              email: "andrewmartin@gmail.com",
              mobile: "+92 334431234",
            ),

            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            UserDetailsCard(
              isActionAllowed:false,
              title: "spouse".tr,
              name: "Martin Andrew",
              email: "andrewmartin@gmail.com",
              mobile: "+92 334431234",
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            UserDetailsCard(
              isActionAllowed:false,
              title: "son".tr,
              name: "Martin Andrew",
              email: "andrewmartin@gmail.com",
              mobile: "+92 334431234",
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal,
              child: Divider(),
            ),
            UserDetailsCard(
              isActionAllowed:false,
              title: "daughter".tr,
              name: "Martin Andrew",
              email: "andrewmartin@gmail.com",
              mobile: "+92 334431234",
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
                  Text("ticket_price".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
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
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("total".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("AED 1520",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),

            Padding(
              padding: flyternLargePaddingAll,
              child: Text("select_payment_method".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium,bottom: flyternSpaceSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      children: [

                        Container(
                            decoration: flyternBorderedContainerSmallDecoration,
                            clipBehavior: Clip.hardEdge,
                            width: screenwidth*.15,
                            height: screenwidth*.15,
                            child: Center(child: Image.asset(ASSETS_APPLE_PAY_ICON,width: screenwidth*.1))),

                        addHorizontalSpace(flyternSpaceMedium),

                        Text("apple_pay".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 1,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      children: [

                        Container(
                            decoration: flyternBorderedContainerSmallDecoration,
                            clipBehavior: Clip.hardEdge,
                            width: screenwidth*.15,
                            height: screenwidth*.15,
                            child: Center(child: Image.asset(ASSETS_PAYPAL_ICON,width: screenwidth*.08))),

                        addHorizontalSpace(flyternSpaceMedium),

                        Text("pay_pal".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 2,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
                padding: flyternLargePaddingHorizontal,
                color:flyternBackgroundWhite,
                child: Divider()),
            Container(
              color: flyternBackgroundWhite,
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Row(
                      children: [


                        Container(
                            decoration: flyternBorderedContainerSmallDecoration,
                            clipBehavior: Clip.hardEdge,
                            width: screenwidth*.15,
                            height: screenwidth*.15,
                            child: Center(child: Image.asset(ASSETS_VISA_ICON,width: screenwidth*.08))),
                        addHorizontalSpace(flyternSpaceMedium),

                        Text("visa".tr,
                            style: getBodyMediumStyle(context)
                                .copyWith(color: flyternGrey80)),
                      ],
                    ),
                  ),
                  Radio(
                    activeColor: flyternSecondaryColor,
                    value: 3,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        selectedPaymentMethod = value!;
                      });
                    },
                  ),
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
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Approute_insuranceConfirmation);
                 },
                child:Text("proceed".tr )),
          ),
        ),
      ),
    );
  }
}
