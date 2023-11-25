import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_summary_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared-module/ui/components/user_details_card.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
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
                              Icon(Ionicons.checkmark_circle_outline,size: screenwidth*.4,color: flyternGuideGreen),
                              Padding(
                                padding: EdgeInsets.only(top: flyternSpaceLarge),
                                child: Text(
                                    flightBookingController.bookingRef.value !=""?
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
                            Text(flightBookingController.bookingRef.value,style: getBodyMediumStyle(context).copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                      InkWell(
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
                      Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("payment_summary".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id != "-1",
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceLarge, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("base_fare".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalBase}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id != "-1",
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id != "-1",
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("tax_fare".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalTax}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: flightBookingController.processingFee.value != 0.0,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),

                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id != "-1",
                        child: Container(
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
                                  "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalPrice}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),


                      Visibility(
                        visible: flightBookingController.seatTotalAmount.value != 0.0,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.seatTotalAmount.value != 0.0,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("seats".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.cabinInfo.value.currency} "
                                      "${flightBookingController.seatTotalAmount.value}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: flightBookingController.mealTotalAmount.value != 0.0,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.mealTotalAmount.value != 0.0,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("meal".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.cabinInfo.value.currency} "
                                      "${flightBookingController.mealTotalAmount.value}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: flightBookingController.baggageTotalAmount.value != 0.0,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.baggageTotalAmount.value != 0.0,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("extra_buggage".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.cabinInfo.value.currency} "
                                      "${flightBookingController.baggageTotalAmount.value}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: flightBookingController.processingFee.value !=
                            0.0,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.processingFee.value  != 0.0,
                        child: Container(
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
                                  "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.processingFee.value}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id !=
                            "-1" &&
                            flightBookingController.cabinInfo.value.totalBase > 0.0,
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id !=
                            "-1" &&
                            flightBookingController.cabinInfo.value.discount > 0.0,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${'discount'.tr} (${'promo_code'.tr}-${flightBookingController.cabinInfo.value.promoCode})",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "- ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.discount}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGuideGreen)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id != "-1",
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.cabinInfo.value.id != "-1",
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${'grand_total'.tr} ",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.cabinInfo.value.currency}"
                                      " ${(flightBookingController.cabinInfo.value.finalAmount +
                                      flightBookingController.seatTotalAmount.value +
                                      flightBookingController.mealTotalAmount.value +
                                      flightBookingController.baggageTotalAmount.value +
                                      flightBookingController.processingFee.value)}",
                                  style: getBodyMediumStyle(context).copyWith(
                                      color: flyternGrey80,
                                      fontWeight: flyternFontWeightBold)),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: flightBookingController.paymentCode.value !="",
                        child: Container(
                            padding: flyternLargePaddingHorizontal,
                            color: flyternBackgroundWhite,
                            child: Divider()),
                      ),
                      Visibility(
                        visible: flightBookingController.processingFee.value  != 0.0,
                        child: Container(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceSmall, bottom: flyternSpaceLarge),
                          color: flyternBackgroundWhite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("payment_gateway".tr,
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey60)),
                              Text(
                                  "${flightBookingController.paymentCode.value}",
                                  style: getBodyMediumStyle(context)
                                      .copyWith(color: flyternGrey80)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: flyternLargePaddingAll,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("flight_summary".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold)),
                            Text("flight_details".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    decoration: TextDecoration.underline,
                                    color: flyternTertiaryColor)),
                          ],
                        ),
                      ),
                      for (var i = 0;
                      i <
                          flightBookingController
                              .flightDetails.value.flightSegments.length;
                      i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: flyternSpaceLarge),
                          child: FlightDetailsItineraryCard(
                              flightSegment: flightBookingController
                                  .flightDetails.value.flightSegments[i]),
                        ),
                      Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("passengers".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                      for (var i = 0;
                      i <
                          flightBookingController
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
                            "${flightBookingController.selectedTravelInfo[i].firstName} ${flightBookingController.selectedTravelInfo[i].lastName}",
                            age: getAge(flightBookingController
                                .selectedTravelInfo[i].dateOfBirth),
                            gender: flightBookingController
                                .selectedTravelInfo[i].gender,
                            passportNumber: flightBookingController
                                .selectedTravelInfo[i].passportNumber,
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
