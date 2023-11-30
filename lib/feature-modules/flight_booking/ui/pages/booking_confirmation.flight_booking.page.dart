import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/booking_summary_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/details_itinerary_card.flight_booking.component.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.shared.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

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
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(mode=="view"?'booking_confirmation'.tr:
          'booking_details'.tr),
          elevation: 0.5,
        ),
        body: Obx(
            ()=> Stack(
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
                visible:
                !flightBookingController.isFlightConfirmationDataLoading.value,
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
                              Icon(
                                  flightBookingController.isIssued.value?
                                  Ionicons.checkmark_circle_outline:
                                  Ionicons.close_circle_outline,
                                  size: screenwidth*.4,color:
                              flightBookingController.isIssued.value?
                              flyternGuideGreen:flyternGuideRed),
                              Padding(
                                padding: EdgeInsets.only(top: flyternSpaceLarge),
                                child: Text(
                                    flightBookingController.isIssued.value?
                                    "success".tr:"failed".tr,
                                    textAlign: TextAlign.center,
                                    style: getHeadlineLargeStyle(context).copyWith(
                                        color: flightBookingController.isIssued.value?
                                        flyternGuideGreen:flyternGuideRed, fontWeight: flyternFontWeightBold)),
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
                            Text(flightBookingController.isIssued.value?
                            "success".tr:"failed".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flightBookingController.isIssued.value?
                                    flyternGuideGreen:flyternGuideRed,
                                    fontWeight: flyternFontWeightBold)),
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
                            Text(flightBookingController.bookingRef.value,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: flightBookingController.isIssued.value,
                        child: InkWell(
                          onTap: (){
                            _launchUrl(flightBookingController.pdfLink.value);
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
                      i < flightBookingController.alert.length;
                      i++)
                        Container(
                          padding: flyternLargePaddingAll.copyWith(bottom: 0),
                          child: DataCapsuleCard(
                            label: flightBookingController.alert[i],
                            theme: 1,
                          ),
                        ),

                      for (var i = 0;
                      i < flightBookingController.getBookingInfoGroupLength();
                      i++)
                        Wrap(
                          children: [
                            Padding(
                              padding: flyternLargePaddingAll,
                              child: Text(
                                  flightBookingController
                                      .getBookingInfoGroupName(i),
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ),
                            Container(
                              height: (flightBookingController
                                  .getBookingInfoGroupSize(i) *
                                  50)+(flyternSpaceLarge*2),
                              child: Column(
                                children: [
                                  for (var ind = 0;
                                  ind <
                                      flightBookingController
                                          .getBookingInfoGroupSize(i);
                                  ind++)
                                    flightBookingController.getBookingInfoTitle(
                                        i, ind) !=
                                        "DIVIDER"
                                        ? Container(
                                      padding: flyternLargePaddingHorizontal
                                          .copyWith(
                                          top: ind == 0
                                              ? flyternSpaceLarge
                                              : flyternSpaceMedium,
                                          bottom: ind ==
                                              flightBookingController
                                                  .getBookingInfoGroupSize(
                                                  i) -
                                                  1
                                              ? flyternSpaceLarge
                                              : flyternSpaceMedium),
                                      decoration: BoxDecoration(
                                          color: flyternBackgroundWhite,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ind ==
                                                  flightBookingController
                                                      .getBookingInfoGroupSize(
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
                                              flightBookingController
                                                  .getBookingInfoTitle(
                                                  i, ind),
                                              style: getBodyMediumStyle(
                                                  context)
                                                  .copyWith(
                                                  color:
                                                  flyternGrey60)),
                                          Text(
                                              flightBookingController
                                                  .getBookingInfoValue(
                                                  i, ind),
                                              style: getBodyMediumStyle(
                                                  context)
                                                  .copyWith(
                                                  color:
                                                  flyternGrey80)),
                                        ],
                                      ),
                                    )
                                        : ind !=
                                        flightBookingController
                                            .getBookingInfoGroupSize(
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
                    :flightBookingController.resetAndNavigateToHome();
                  },
                  child:Text(isCancelling || isDateChanging? "confirm".tr :"continue".tr )),
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
      print('Could not launch $_url');
    }
  }

  getAge(DateTime dateOfBirth) {
    return "${DateTime.now().year - dateOfBirth.year} years";
  }
}
