import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_response.hotel_booking.model.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
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
  String mode = "view";
  dynamic argumentData = Get.arguments;

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

    return WillPopScope(
      onWillPop: () async {
        if (mode == "view") {
          return false;
        } else {
          return true;
        }
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
              title: Padding(
                padding: EdgeInsets.only(
                    left: (mode == "edit" ? 0 : (flyternSpaceLarge))),
                child: Text(mode == "view"
                    ? 'booking_confirmation'.tr
                    : 'booking_details'.tr),
              ),
              elevation: 0.5,
              automaticallyImplyLeading: mode == "edit" ? true : false),
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
                      addVerticalSpace(flyternSpaceLarge),
                      Visibility(
                          visible: mode == "view",
                          child: addVerticalSpace(flyternSpaceLarge)),
                      Visibility(
                        visible: mode == "view",
                        child: Text(
                            getPaymentInfo(hotelBookingController.paymentInfo,
                                "ThankyouMsg"),
                            textAlign: TextAlign.center,
                            style: getHeadlineLargeStyle(context).copyWith(
                                color: flyternGuideGreen,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      Visibility(
                        visible: mode == "view",
                        child: Image.network(
                          getPaymentInfo(hotelBookingController.paymentInfo,
                              "ConfirmIcon"),
                          width: screenwidth * .4,
                          height: screenwidth * .4,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Ionicons.checkmark_circle_outline,
                                size: screenwidth * .4,
                                color: flyternGuideGreen);
                          },
                        ),
                      ),
                      Visibility(
                        visible: mode == "view",
                        child: Text(
                            getPaymentInfo(hotelBookingController.paymentInfo,
                                "ConfirmMsg"),
                            textAlign: TextAlign.center,
                            style: getHeadlineLargeStyle(context).copyWith(
                                color: flyternGuideGreen,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      Visibility(
                          visible: mode == "view",
                          child: addVerticalSpace(flyternSpaceLarge * 2)),
                      Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceLarge, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                getPaymentTitle(
                                    hotelBookingController.paymentInfo,
                                    "BookingID"),
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                getPaymentInfo(
                                    hotelBookingController.paymentInfo,
                                    "BookingID"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
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
                            Text(
                                getPaymentTitle(
                                    hotelBookingController.paymentInfo,
                                    "PaymentStatus"),
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                getPaymentInfo(
                                    hotelBookingController.paymentInfo,
                                    "PaymentStatus"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
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
                            Text(
                                getPaymentTitle(
                                    hotelBookingController.paymentInfo,
                                    "PaymentMethod"),
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Expanded(child: Container()),
                            Container(
                                decoration:
                                    flyternBorderedContainerSmallDecoration,
                                clipBehavior: Clip.hardEdge,
                                width: screenwidth * .1,
                                height: screenwidth * .1,
                                child: Center(
                                    child: Image.network(
                                  getPaymentInfo(
                                      hotelBookingController.paymentInfo,
                                      "PaymentMethodIcon"),
                                  width: screenwidth * .08,
                                  height: screenwidth * .08,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                        width: screenwidth * .08,
                                        height: screenwidth * .08);
                                  },
                                ))),
                            addHorizontalSpace(flyternSpaceMedium),
                            Text(
                                getPaymentInfo(
                                    hotelBookingController.paymentInfo,
                                    "PaymentMethod"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
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
                            Text(
                                getPaymentTitle(
                                    hotelBookingController.paymentInfo,
                                    "FinalBookingAmount"),
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                getPaymentInfo(
                                    hotelBookingController.paymentInfo,
                                    "FinalBookingAmount"),
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightRegular)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: hotelBookingController.isIssued.value,
                        child: InkWell(
                          onTap: () {
                            _launchUrl(hotelBookingController.pdfLink.value);
                          },
                          child: Container(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                top: flyternSpaceSmall,
                                bottom: flyternSpaceLarge),
                            color: flyternBackgroundWhite,
                            child: Text("get_eticket".tr,
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
                          padding: flyternMediumPaddingAll,
                          margin: flyternLargePaddingAll.copyWith(
                              bottom: flyternSpaceMedium),
                          decoration: BoxDecoration(
                            color: flyternPrimaryColorBg,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: Html(
                            data: hotelBookingController.alert[i],
                          ),
                        ),
                      for (var i = 0;
                          i <
                              getBookingInfoGroupLength(
                                  hotelBookingController.bookingInfo);
                          i++)
                        Wrap(
                          children: [
                            Padding(
                              padding: flyternLargePaddingAll,
                              child: Text(
                                  getBookingInfoGroupName(
                                      hotelBookingController.bookingInfo, i),
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ),
                            Container(
                              height: (getBookingInfoGroupSize(
                                          hotelBookingController.bookingInfo,
                                          i) *
                                      50) +
                                  (flyternSpaceLarge * 2),
                              child: Column(
                                children: [
                                  for (var ind = 0;
                                      ind <
                                          getBookingInfoGroupSize(
                                              hotelBookingController
                                                  .bookingInfo,
                                              i);
                                      ind++)
                                    getBookingInfoTitle(
                                                hotelBookingController
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
                                                                hotelBookingController
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
                                                                    hotelBookingController
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
                                              children: [
                                                Text(
                                                    getBookingInfoTitle(
                                                        hotelBookingController
                                                            .bookingInfo,
                                                        i,
                                                        ind),
                                                    style: getBodyMediumStyle(
                                                            context)
                                                        .copyWith(
                                                            color:
                                                                flyternGrey60)),
                                                Text(
                                                    getBookingInfoValue(
                                                        hotelBookingController
                                                            .bookingInfo,
                                                        i,
                                                        ind),
                                                    style: getBodyMediumStyle(
                                                            context)
                                                        .copyWith(
                                                            color:
                                                                flyternGrey80)),
                                              ],
                                            ),
                                          )
                                        : ind !=
                                                getBookingInfoGroupSize(
                                                        hotelBookingController
                                                            .bookingInfo,
                                                        i) -
                                                    1
                                            ? Container(
                                                padding:
                                                    flyternLargePaddingHorizontal,
                                                color: flyternBackgroundWhite,
                                                child: Divider(
                                                    height: 3, thickness: 3))
                                            : Container(),
                                ],
                              ),
                            )
                          ],
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
                          hotelSearchResponse: HotelSearchResponse(
                              locationFilter: hotelBookingController.hotelDetails.value.location,
                              fromPrice: hotelBookingController.hotelDetails.value.fromPrice,
                              rating: hotelBookingController.hotelDetails.value.rating,
                              imageUrl: hotelBookingController.hotelDetails.value.imageUrls.isNotEmpty?hotelBookingController.hotelDetails.value.imageUrls[0]:"",
                              location: hotelBookingController.hotelDetails.value.location,
                              hotelName: hotelBookingController.hotelDetails.value.hotelName,
                              priceUnit: hotelBookingController.hotelDetails.value.priceUnit,
                              description: hotelBookingController.hotelDetails.value.descriptionInfo,
                              hotelId: hotelBookingController.hotelDetails.value.hotelId,
                              information: []),
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
          bottomSheet: mode == "edit"
              ? Container(
                  width: screenwidth,
                  height: 0,
                )
              : Container(
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
                            mode == "edit"
                                ? Navigator.pop(context)
                                : hotelBookingController
                                    .resetAndNavigateToHome();
                          },
                          child: Text("continue".tr)),
                    ),
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
