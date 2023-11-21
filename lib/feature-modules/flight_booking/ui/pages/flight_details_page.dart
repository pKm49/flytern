import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_info.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/ui/components/contact_details_getter.dart';
import 'package:flytern/shared/ui/components/data_capsule_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_addon_service_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_details_itinerary_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightDetailsPage extends StatefulWidget {
  const FlightDetailsPage({super.key});

  @override
  State<FlightDetailsPage> createState() => _FlightDetailsPageState();
}

class _FlightDetailsPageState extends State<FlightDetailsPage> {
  final flightBookingController = Get.find<FlightBookingController>();
  bool isContactDetailsOpened = true;
  late StreamSubscription subscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      subscription = flightBookingController.isFlightPretravellerDataLoading.listen((value) {
      if(value == false && !isContactDetailsOpened){
        openContactDetailsGetterBottomSheet();
      }
      if(value == true){
        isContactDetailsOpened = false;
      }
      setState(() {

      });

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text("flight_details".tr),
        ),
        body: Container(
          width: screenwidth,
          height: screenheight,
          color: flyternGrey10,
          child: Stack(
            children: [
              Visibility(
                visible: !flightBookingController.isFlightDetailsLoading.value,
                child: ListView(
                  children: [
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("itinerary".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
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
                    Visibility(
                      visible: flightBookingController
                              .flightDetails.value.fareRule !=
                          "",
                      child: Container(
                        padding: flyternLargePaddingHorizontal,
                        decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            border: flyternDefaultBorderBottomOnly),
                        child: Theme(
                          data: ThemeData()
                              .copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            title: Text("fare_rule".tr,
                                style: getBodyMediumStyle(context).copyWith(
                                    fontWeight: flyternFontWeightBold)),
                            children: <Widget>[
                              Padding(
                                padding: flyternSmallPaddingVertical,
                                child: Html(
                                  data: flightBookingController
                                      .flightDetails.value.fareRule,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("cabin_class".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Container(
                      padding: flyternLargePaddingHorizontal,
                      decoration: BoxDecoration(color: flyternBackgroundWhite),
                      child: Container(
                        width: screenwidth - flyternSpaceMedium * 2,
                        padding: flyternMediumPaddingHorizontal,
                        margin: flyternLargePaddingVertical,
                        decoration: BoxDecoration(
                          color: flyternBackgroundWhite,
                          border: flyternDefaultBorderAll,
                          borderRadius: BorderRadius.circular(
                              flyternBorderRadiusExtraSmall),
                        ),
                        child: DropDownSelector(
                          titleText: "select_cabin_class".tr,
                          selected:
                              flightBookingController.cabinInfo.value.id != "-1"
                                  ? flightBookingController.cabinInfo.value.id
                                  : null,
                          items: [
                            for (var ind = 0;
                                ind <
                                    flightBookingController
                                        .flightDetails.value.cabinInfos.length;
                                ind++)
                              GeneralItem(
                                  id: flightBookingController
                                      .flightDetails.value.cabinInfos[ind].id,
                                  name: flightBookingController.flightDetails
                                      .value.cabinInfos[ind].cabinClass,
                                  imageUrl: ""),
                          ],
                          hintText: "select_cabin_class".tr,
                          valueChanged: (newZone) {
                            List<CabinInfo> selectedCabinInfo =
                                flightBookingController
                                    .flightDetails.value.cabinInfos
                                    .where((element) => element.id == newZone)
                                    .toList();
                            if (selectedCabinInfo.isNotEmpty) {
                              print("selectedCabinInfo.isNotEmpty");
                              flightBookingController.changeSelectedCabinClass(
                                  selectedCabinInfo[0]);
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: flyternLargePaddingHorizontal.copyWith(
                          bottom: flyternSpaceLarge),
                      decoration: BoxDecoration(
                          color: flyternBackgroundWhite,
                          border: flyternDefaultBorderBottomOnly),
                      child: Html(
                        data: flightBookingController
                            .cabinInfo.value.infoDescription,
                      ),
                    ),

                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("price_details".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.adult > 0,
                      child: FlightDetailsAddonServiceCard(
                        ImageUrl: ASSETS_COUPLE_ICON,
                        keyLabel: "adult".tr,
                        valueLabel:
                            "${"base_fare".tr} : ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.adultBase}",
                      ),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.child > 0,
                      child: Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.child > 0,
                      child: FlightDetailsAddonServiceCard(
                        ImageUrl: ASSETS_COUPLE_ICON,
                        keyLabel: "child".tr,
                        valueLabel:
                            "${"base_fare".tr} : ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.childBase}",
                      ),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.infant >
                              0,
                      child: Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal,
                          child: Divider()),
                    ),
                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.infant >
                              0,
                      child: FlightDetailsAddonServiceCard(
                        ImageUrl: ASSETS_COUPLE_ICON,
                        keyLabel: "infant".tr,
                        valueLabel:
                            "${"base_fare".tr} : ${flightBookingController.cabinInfo.value.currency}"
                            " ${flightBookingController.cabinInfo.value.infantBase}",
                      ),
                    ),
                    Visibility(
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceSmall, bottom: flyternSpaceSmall),
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
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1",
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
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1" &&
                              flightBookingController.cabinInfo.value.discount >
                                  0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1",
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
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.cabinInfo.value.totalBase >
                              0.0,
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1" &&
                              flightBookingController.cabinInfo.value.discount >
                                  0.0,
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
                                " - ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.discount}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGuideGreen)),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
                          padding: flyternLargePaddingHorizontal,
                          color: flyternBackgroundWhite,
                          child: Divider()),
                    ),
                    Visibility(
                      visible:
                          flightBookingController.cabinInfo.value.id != "-1",
                      child: Container(
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
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.finalAmount}",
                                style: getBodyMediumStyle(context).copyWith(
                                    color: flyternGrey80,
                                    fontWeight: flyternFontWeightBold)),
                          ],
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible:  flightBookingController.flightDetails.value.warningMessage !="",
                    //   child: Container(
                    //     color: flyternBackgroundWhite,
                    //     padding: flyternLargePaddingAll.copyWith(top: 0),
                    //     child: DataCapsuleCard(
                    //       label: flightBookingController.flightDetails.value.warningMessage,
                    //       theme: 3,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 70 + (flyternSpaceSmall * 2),
                      padding: flyternLargePaddingAll,
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: flightBookingController.isFlightDetailsLoading.value,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                    color: flyternSecondaryColor,
                    size: 50,
                  )))
            ],
          ),
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
                    flightBookingController.getPreTravellerData(
                        flightBookingController.flightDetails.value.detailId);

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.finalAmount}"),
                      ),
                      Visibility(
                          visible: !flightBookingController
                              .isFlightPretravellerDataLoading.value,
                          child: Text("next".tr)),
                      Visibility(
                          visible: flightBookingController
                              .isFlightPretravellerDataLoading.value,
                          child: LoadingAnimationWidget.prograssiveDots(
                            color: flyternBackgroundWhite,
                            size: 20,
                          )),
                      addHorizontalSpace(flyternSpaceSmall),
                      Icon(
                        Ionicons.chevron_forward,
                        size: flyternFontSize20,
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }


  void openContactDetailsGetterBottomSheet() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return ContactDetailsGetter(route: Approute_flightsUserSelection);
        });
  }
}
