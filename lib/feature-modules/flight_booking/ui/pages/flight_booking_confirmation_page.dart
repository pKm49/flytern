import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/shared/ui/components/user_details_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';

class FlightBookingConfirmationPage extends StatefulWidget {
  const FlightBookingConfirmationPage({super.key});

  @override
  State<FlightBookingConfirmationPage> createState() => _FlightBookingConfirmationPageState();
}

class _FlightBookingConfirmationPageState extends State<FlightBookingConfirmationPage> {

  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();

  bool isCancelling = false;
  bool isDateChanging = false;

  int selectedPaymentMethod = 1;
  dynamic argumentData = Get.arguments;

  String mode = "view";

  @override
  void initState() {
    // TODO: implement initState
    mode = argumentData[0]['mode'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(mode=="view"?'booking_confirmation'.tr:
        'booking_details'.tr),
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
                  Text("meal".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("AED 25",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("baggage".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("AED 20",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("flight_summary".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                  Text("flight_details".tr,
                      style: getBodyMediumStyle(context).copyWith(
                          decoration: TextDecoration.underline,
                          color: flyternTertiaryColor )),
                ],
              ),
            ),
            FlightBookingSummaryCard(
              mode: mode,
              onCancel: (){
                setState(() {
                  isCancelling =!isCancelling;
                });
              },
              onDateChange: (){
                setState(() {
                  isDateChanging = !isDateChanging;
                });
              },
            ),

            Visibility(
              visible: isCancelling || isDateChanging,
              child: Padding(
                padding: flyternLargePaddingAll,
                child: Text("reason".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),
            ),
        Visibility(
            visible: isCancelling || isDateChanging,
              child: Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceLarge),
                color: flyternBackgroundWhite,
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "reason_for_cancel".tr,
                    )),
              ),
            ),
        Visibility(
          visible: isCancelling || isDateChanging,
              child: Padding(
                padding: flyternLargePaddingAll,
                child: Text("refund_details".tr,
                    style: getBodyMediumStyle(context).copyWith(
                        color: flyternGrey80, fontWeight: flyternFontWeightBold)),
              ),
            ),
        Visibility(
            visible: isCancelling || isDateChanging,
              child: Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("total_paid".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("AED 15,000",style: getBodyMediumStyle(context).copyWith(fontWeight: flyternFontWeightBold)),
                  ],
                ),
              ),
            ),
        Visibility(
            visible: isCancelling || isDateChanging,
              child: Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
            ),
        Visibility(
            visible: isCancelling || isDateChanging,
              child: Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("cancellation_charge".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("AED 5000",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
            ),
        Visibility(
            visible: isCancelling || isDateChanging,
              child: Container(
                  padding: flyternLargePaddingHorizontal,
                  color:flyternBackgroundWhite,
                  child: Divider()),
            ),
        Visibility(
            visible: isCancelling || isDateChanging,
              child: Container(
                padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceLarge),
                color: flyternBackgroundWhite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("refundable_amount".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                    Text("AED 1000",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                  ],
                ),
              ),
            ),



            Padding(
              padding: flyternLargePaddingAll,
              child: Text("passengers".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),

            UserDetailsCard(
              isActionAllowed:false,
              title: "adult".tr,
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
              title: "child".tr,
              name: "Martin Andrew",
              email: "andrewmartin@gmail.com",
              mobile: "+92 334431234",
            ),

            Padding(
              padding: flyternLargePaddingAll,
              child: Text("add_on_services".tr,
                  style: getBodyMediumStyle(context).copyWith(
                      color: flyternGrey80, fontWeight: flyternFontWeightBold)),
            ),
            Container(
              padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceLarge,bottom: flyternSpaceSmall),
              color: flyternBackgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("seats".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("15D",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("meal".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("Burger",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
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
                  Text("baggage".tr,style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                  Text("23 Kg",style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                ],
              ),
            ),

            // Payment summary

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
                  mode=="edit"?
                  Navigator.pop(context)
                  :Get.offAllNamed(Approute_landingpage);
                },
                child:Text(isCancelling || isDateChanging? "confirm".tr :"get_eticket".tr )),
          ),
        ),
      ),
    );
  }
}
