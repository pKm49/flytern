import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/search_result_card.hotel_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelBookingConfirmationPage extends StatefulWidget {
  const HotelBookingConfirmationPage({super.key});

  @override
  State<HotelBookingConfirmationPage> createState() =>
      _HotelBookingConfirmationPageState();
}

class _HotelBookingConfirmationPageState
    extends State<HotelBookingConfirmationPage> {
  final hotelBookingController = Get.find<HotelBookingController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('summary'.tr),
          elevation: 0.5,
        ),
        body: Stack(
          children: [
            Visibility(
                visible:
                    hotelBookingController.isHotelConfirmationDataLoading.value,
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
              visible:
                  !hotelBookingController.isHotelConfirmationDataLoading.value,
              child: Container(
                width: screenwidth,
                height: screenheight,
                color: flyternGrey10,
                child: ListView(
                  children: [

                    addVerticalSpace(flyternSpaceLarge*2),
                    Text(
                        getPaymentInfo(hotelBookingController.paymentInfo,"ThankyouMsg"),
                        textAlign: TextAlign.center,
                        style: getHeadlineLargeStyle(context).copyWith(
                            color: flyternGuideGreen, fontWeight: flyternFontWeightBold)),
                    Image.network(
                      getPaymentInfo(hotelBookingController.paymentInfo,"ConfirmIcon"),
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
                        getPaymentInfo(hotelBookingController.paymentInfo,"ConfirmMsg"),
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
                          Text(getPaymentTitle(hotelBookingController.paymentInfo, "BookingID"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                          Text(getPaymentInfo(hotelBookingController.paymentInfo,"BookingID"),
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
                          Text(getPaymentTitle(hotelBookingController.paymentInfo, "PaymentStatus"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                          Text(getPaymentInfo(hotelBookingController.paymentInfo,"PaymentStatus"),
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
                          Text(getPaymentTitle(hotelBookingController.paymentInfo, "PaymentMethod"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),
                          Expanded(child: Container()),
                          Container(
                              decoration:
                              flyternBorderedContainerSmallDecoration,
                              clipBehavior: Clip.hardEdge,
                              width: screenwidth * .1,
                              height: screenwidth * .1,
                              child: Center(
                                  child: Image.network(
                                    getPaymentInfo(hotelBookingController.paymentInfo,"PaymentMethodIcon"),
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
                          Text(getPaymentInfo(hotelBookingController.paymentInfo,"PaymentMethod"),
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
                          Text(getPaymentTitle(hotelBookingController.paymentInfo, "FinalBookingAmount"),style: getBodyMediumStyle(context).copyWith(color: flyternGrey60)),

                          Text(getPaymentInfo(hotelBookingController.paymentInfo,"FinalBookingAmount"),
                              style: getBodyMediumStyle(context).copyWith(
                                  fontWeight: flyternFontWeightRegular)),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: hotelBookingController.isIssued.value,
                      child: InkWell(
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
                    ),

                    
                    for (var i = 0;
                        i < hotelBookingController.alert.length;
                        i++)
                      Container(
                        padding: flyternLargePaddingAll.copyWith(bottom: 0),
                        child: DataCapsuleCard(
                          label: hotelBookingController.alert[i],
                          theme: 1,
                        ),
                      ),

                    for (var i = 0;
                    i < getBookingInfoGroupLength(hotelBookingController.bookingInfo);
                    i++)
                      Wrap(
                        children: [
                          Padding(
                            padding: flyternLargePaddingAll,
                            child: Text(
                                getBookingInfoGroupName(hotelBookingController.bookingInfo,i),
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold)),
                          ),
                          Container(
                            height: ( getBookingInfoGroupSize(hotelBookingController.bookingInfo,i) *
                                50)+(flyternSpaceLarge*2),
                            child: Column(
                              children: [
                                for (var ind = 0;
                                ind < getBookingInfoGroupSize(hotelBookingController.bookingInfo,i);
                                ind++)
                                  getBookingInfoTitle(hotelBookingController.bookingInfo,
                                      i, ind) !=
                                      "DIVIDER"
                                      ? Container(
                                    padding: flyternLargePaddingHorizontal
                                        .copyWith(
                                        top: ind == 0
                                            ? flyternSpaceLarge
                                            : flyternSpaceMedium,
                                        bottom: ind == getBookingInfoGroupSize(hotelBookingController.bookingInfo,
                                            i) -
                                            1
                                            ? flyternSpaceLarge
                                            : flyternSpaceMedium),
                                    decoration: BoxDecoration(
                                        color: flyternBackgroundWhite,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: ind == getBookingInfoGroupSize(hotelBookingController.bookingInfo,
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
                                            getBookingInfoTitle(hotelBookingController.bookingInfo,
                                                i, ind),
                                            style: getBodyMediumStyle(
                                                context)
                                                .copyWith(
                                                color:
                                                flyternGrey60)),
                                        Text( getBookingInfoValue(hotelBookingController.bookingInfo,
                                            i, ind),
                                            style: getBodyMediumStyle(
                                                context)
                                                .copyWith(
                                                color:
                                                flyternGrey80)),
                                      ],
                                    ),
                                  )
                                      : ind != getBookingInfoGroupSize(hotelBookingController.bookingInfo,
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
                        i < hotelBookingController.paymentGateways.length;
                        i++)
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: i ==
                                      hotelBookingController
                                              .paymentGateways.length -
                                          1
                                  ? Colors.transparent
                                  : flyternGrey20,
                              width: 0.5,
                            ),
                          ),
                          color: flyternBackgroundWhite,
                        ),
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceMedium,
                            bottom: i ==
                                    hotelBookingController
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
                                        hotelBookingController.paymentGateways
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
                                      hotelBookingController
                                          .paymentGateways.value[i].displayName,
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                ],
                              ),
                            ),
                            Radio(
                              activeColor: flyternSecondaryColor,
                              value: hotelBookingController
                                  .paymentGateways.value[i].processID,
                              groupValue:
                                  hotelBookingController.processId.value,
                              onChanged: (value) {
                                hotelBookingController.updateProcessId(value);
                              },
                            ),
                          ],
                        ),
                      ),
                    Container(
                      padding: flyternLargePaddingHorizontal.copyWith(
                          top: flyternSpaceLarge, bottom: flyternSpaceSmall),
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
                      padding: flyternLargePaddingAll.copyWith(
                          top: flyternSpaceLarge * 2),
                      child: Text("hotel_details".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      color: flyternBackgroundWhite,
                      padding: flyternLargePaddingHorizontal,
                      child: HotelSearchResultCard(
                        onPressed: () {},
                        hotelSearchResponse: hotelBookingController
                                .hotelSearchResponses.value
                                .where((element) =>
                                    element.hotelId ==
                                    hotelBookingController.hotelId.value)
                                .toList()
                                .isNotEmpty
                            ? hotelBookingController.hotelSearchResponses.value
                                .where((element) =>
                                    element.hotelId ==
                                    hotelBookingController.hotelId.value)
                                .toList()[0]
                            : mapHotelSearchResponse({}),
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
    grandTotal +=
        hotelBookingController.selectedPaymentGateway.value.processingFee;
    grandTotal -= hotelBookingController.selectedPaymentGateway.value.discount;
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
