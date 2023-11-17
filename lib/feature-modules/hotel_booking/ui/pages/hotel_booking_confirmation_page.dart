import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking_controller.dart';
import 'package:flytern/feature-modules/hotel_booking/data/models/business_models/hotel_search_response.dart';
import 'package:flytern/shared/ui/components/user_details_card.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/hote_search_result_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelBookingConfirmationPage extends StatefulWidget {
  const HotelBookingConfirmationPage({super.key});

  @override
  State<HotelBookingConfirmationPage> createState() => _HotelBookingConfirmationPageState();
}

class _HotelBookingConfirmationPageState extends State<HotelBookingConfirmationPage> {

  final hotelBookingController = Get.find<HotelBookingController>();

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
        body: Stack(
          children: [
            Visibility(
                visible: hotelBookingController
                    .isHotelConfirmationDataLoading.value,
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
              visible: !hotelBookingController
                  .isHotelConfirmationDataLoading.value,
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
                            Icon(Ionicons.checkmark_circle_outline,size: screenwidth*.4,color: flyternGuideGreen),
                            Padding(
                              padding: EdgeInsets.only(top: flyternSpaceLarge),
                              child: Text(
                                  hotelBookingController.bookingRef.value !=""?
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
                          Text(hotelBookingController.bookingRef.value,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        _launchUrl(hotelBookingController.pdfLink.value);
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
                    // Payment summary

                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("payment_summary".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),

                    for(var i=0;i<hotelBookingController.hotelDetails.value.rooms.length;i++)
                      Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top:i==0 ?flyternSpaceLarge:flyternSpaceMedium, bottom:i==0 ?flyternSpaceSmall: flyternSpaceMedium),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${hotelBookingController.hotelDetails.value.rooms[i].roomDisplayNo} - "
                                "${hotelBookingController.hotelDetails.value.rooms[i].roomref}" ,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${hotelBookingController.hotelDetails.value.priceUnit}"
                                    " ${hotelBookingController.selectedRoomOption.value[i].totalPrice}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),

                    Container(
                      padding: flyternLargePaddingHorizontal.copyWith(
                          top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                      color: flyternBackgroundWhite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("total_fare".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey60)),
                          Text(
                              "${hotelBookingController.hotelDetails.value.priceUnit}"
                                  " ${getBaseTotal()}",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("processing_fee".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey60)),
                          Text(
                              "${hotelBookingController.hotelDetails.value.priceUnit} ${hotelBookingController.processingFee.value}",
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternGrey80)),
                        ],
                      ),
                    ),

                    Container(
                        padding: flyternLargePaddingHorizontal,
                        color: flyternBackgroundWhite,
                        child: Divider()),
                    Visibility(
                      visible: hotelBookingController.selectedPaymentGateway.value.discount > 0.0,
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${'discount'.tr}  ",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                " - ${hotelBookingController.hotelDetails.value.priceUnit} ${hotelBookingController.selectedPaymentGateway.value.discount}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGuideGreen)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible:hotelBookingController.selectedPaymentGateway.value.discount>0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Container(
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
                              "${hotelBookingController.hotelDetails.value.priceUnit}"
                                  " ${getGrandTotal()}",
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternGrey80,
                                  fontWeight: flyternFontWeightBold)),
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("hotel_details".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      color: flyternBackgroundWhite,
                      padding: flyternLargePaddingHorizontal,
                      child: HotelSearchResultCard(
                        onPressed:(){
                        },
                        hotelSearchResponse: hotelBookingController
                            .hotelSearchResponses.value.where((element) => element.hotelId ==
                            hotelBookingController.hotelId.value).toList().isNotEmpty?hotelBookingController
                            .hotelSearchResponses.value.where((element) => element.hotelId ==
                            hotelBookingController.hotelId.value).toList()[0]:mapHotelSearchResponse(
                            {}),
                      ),
                    ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("users".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),

                    for (var i = 0;
                    i <
                        hotelBookingController
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
                          "${hotelBookingController.selectedTravelInfo[i].firstName} ${hotelBookingController.selectedTravelInfo[i].lastName}",
                          age: "",
                          gender: hotelBookingController
                              .selectedTravelInfo[i].gender,
                          passportNumber:"",
                        ),
                      ),
                    Container(
                      height: 70+(flyternSpaceSmall*2),
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
          height: 60 + (flyternSpaceSmall * 2),
          padding: flyternLargePaddingAll.copyWith(
              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: getElevatedButtonStyle(context),
                  onPressed: () {
                    hotelBookingController.resetAndNavigateToHome();
                  },
                  child: Text("continue".tr)),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    print("urlString");
    print(urlString);
    if (!await launchUrl(_url)) {
      print('Could not launch $_url');
    }
  }


  getGrandTotal() {
    double grandTotal = 0;
    hotelBookingController.selectedRoomOption.value.forEach((element) {
      grandTotal += element.totalPrice;
    });
    grandTotal +=hotelBookingController.selectedPaymentGateway.value.processingFee;
    grandTotal -=hotelBookingController.selectedPaymentGateway.value.discount;
    return grandTotal;
  }

  getBaseTotal() {
    double grandTotal = 0;
    hotelBookingController.selectedRoomOption.value.forEach((element) {
      grandTotal += element.totalPrice;
    });
    return grandTotal;
  }
}
