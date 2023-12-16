import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/details_itinerary_card.flight_booking.component.dart';
import 'package:flytern/shared-module/services/booking_info_helper.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/confirm_dialogue.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class FlightBookingConfirmationPage extends StatefulWidget {
  const FlightBookingConfirmationPage({super.key});

  @override
  State<FlightBookingConfirmationPage> createState() =>
      _FlightBookingConfirmationPageState();
}

class _FlightBookingConfirmationPageState
    extends State<FlightBookingConfirmationPage> {
  final ExpansionTileController controller = ExpansionTileController();
  final ExpansionTileController controller2 = ExpansionTileController();

  bool isCancelling = false;
  bool isDateChanging = false;

  int selectedPaymentMethod = 1;
  dynamic argumentData = Get.arguments;
  final flightBookingController = Get.find<FlightBookingController>();

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

    return WillPopScope(
      onWillPop: () async {
        if(mode == "view"){
          return false;
        }else {
          return true;
        }
      },
      child: Obx(
        ()=> Scaffold(
          appBar: AppBar(
              title: Padding(
                padding:   EdgeInsets.only(left:(mode == "edit" ? 0 : (flyternSpaceLarge))),
                child: Text(mode == "view"
                    ? 'booking_confirmation'.tr
                    : 'booking_details'.tr),
              ),
              elevation: 0.5,
              automaticallyImplyLeading: mode == "edit" ?true:false),
          body:   Stack(
              children: [
                Visibility(
                    visible: flightBookingController
                        .isFlightConfirmationDataLoading.value,
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
                  visible: !flightBookingController
                      .isFlightConfirmationDataLoading.value,
                  child: Container(
                    width: screenwidth,
                    height: screenheight,
                    color: flyternGrey10,
                    child: ListView(
                      children: [

                        Visibility(
                          visible:flightBookingController.alert.isEmpty && flightBookingController.paymentGateways.isEmpty &&
                              flightBookingController
                                  .flightDetails.value.flightSegments.isEmpty,
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

                        addVerticalSpace(flyternSpaceLarge  ),
                        Visibility(
                            visible: mode == "view",
                            child: addVerticalSpace(flyternSpaceLarge )),
                        Visibility(
                          visible: mode == "view",
                          child: Text(
                              getPaymentInfo(flightBookingController.paymentInfo,
                                  "ThankyouMsg"),
                              textAlign: TextAlign.center,
                              style: getHeadlineLargeStyle(context).copyWith(
                                  color: flyternGuideGreen,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                        Visibility(
                          visible: mode == "view",
                          child: Image.network(
                            getPaymentInfo(
                                flightBookingController.paymentInfo, "ConfirmIcon"),
                            width: screenwidth * .4,
                            height: screenwidth * .4,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Ionicons.checkmark_circle_outline,
                                  size: screenwidth * .4, color: flyternGuideGreen);
                            },
                          ),
                        ),
                        Visibility(
                          visible: mode == "view",
                          child: Text(
                              getPaymentInfo(flightBookingController.paymentInfo,
                                  "ConfirmMsg"),
                              textAlign: TextAlign.center,
                              style: getHeadlineLargeStyle(context).copyWith(
                                  color: flyternGuideGreen,
                                  fontWeight: flyternFontWeightBold)),
                        ),
                        Visibility(
                            visible: mode == "view",child: addVerticalSpace(flyternSpaceLarge * 2)),
                        Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceLarge, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  getPaymentTitle(
                                      flightBookingController.paymentInfo,
                                      "BookingID"),
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  getPaymentInfo(
                                      flightBookingController.paymentInfo,
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
                                      flightBookingController.paymentInfo,
                                      "PaymentStatus"),
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  getPaymentInfo(
                                      flightBookingController.paymentInfo,
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
                                      flightBookingController.paymentInfo,
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
                                        flightBookingController.paymentInfo,
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
                                      flightBookingController.paymentInfo,
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
                                      flightBookingController.paymentInfo,
                                      "FinalBookingAmount"),
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  getPaymentInfo(
                                      flightBookingController.paymentInfo,
                                      "FinalBookingAmount"),
                                  style: getBodyMediumStyle(context).copyWith(
                                      fontWeight: flyternFontWeightRegular)),
                            ],
                          ),
                        ),
                        Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                        Visibility(
                          visible: flightBookingController.isIssued.value,
                          child: InkWell(
                            onTap: () {
                              _launchUrl(flightBookingController.pdfLink.value);
                            },
                            child: Container(
                              padding: flyternLargePaddingHorizontal.copyWith(
                                  top: flyternSpaceSmall,
                                  bottom: flyternSpaceLarge),
                              color: flyternBackgroundWhite,
                              child: Text("get_eticket_flight".tr,
                                  style: getBodyMediumStyle(context).copyWith(
                                      decoration: TextDecoration.underline,
                                      color: flyternTertiaryColor)),
                            ),
                          ),
                        ),
                        for (var i = 0;
                            i < flightBookingController.alert.length;
                            i++)
                          Container(
                            padding: flyternMediumPaddingAll,
                            margin: flyternLargePaddingAll.copyWith(bottom: flyternSpaceMedium),
                            decoration: BoxDecoration(
                              color: flyternPrimaryColorBg,
                              borderRadius: BorderRadius.circular(
                                  flyternBorderRadiusExtraSmall),
                            ),
                            child: Html(
                              data: flightBookingController.alert[i],
                            ),
                          ),



                        for (var i = 0;
                        i <
                            getBookingInfoGroupLength(
                                flightBookingController.bookingInfo);
                        i++)
                          Wrap(
                            children: [
                              Padding(
                                padding: flyternLargePaddingAll,
                                child: Text(
                                    getBookingInfoGroupName(
                                        flightBookingController.bookingInfo, i),
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
                                            flightBookingController
                                                .bookingInfo,
                                            i);
                                    ind++)
                                      getBookingInfoTitle(
                                          flightBookingController
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
                                                    flightBookingController
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
                                                        flightBookingController
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
                                                    flightBookingController
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
                                                      flightBookingController
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
                                              flightBookingController
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


                        Visibility(
                          visible: flightBookingController
                              .flightDetails.value.flightSegments.isNotEmpty,
                          child: Padding(
                            padding: flyternLargePaddingAll.copyWith(
                                top: flyternSpaceLarge * 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("flight_summary".tr,
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: flyternGrey80,
                                        fontWeight: flyternFontWeightBold)),
                              ],
                            ),
                          ),
                        ),
                        for (var i = 0;
                            i <
                                flightBookingController
                                    .flightDetails.value.flightSegments.length;
                            i++)
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: flyternSpaceLarge),
                            child: FlightDetailsItineraryCard(
                                flightSegment: flightBookingController
                                    .flightDetails.value.flightSegments[i]),
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
          bottomSheet:mode == "edit"?Container(width: screenwidth,height: 0,): Container(
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
                          : flightBookingController.resetAndNavigateToHome();
                    },
                    child: Text(isCancelling || isDateChanging
                        ? "confirm".tr
                        : "continue".tr)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //"get_eticket".tr
  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);

    if (!await launchUrl(_url)) {

    }
  }

  getAge(DateTime dateOfBirth) {
    return "${DateTime.now().year - dateOfBirth.year} years";
  }
}
