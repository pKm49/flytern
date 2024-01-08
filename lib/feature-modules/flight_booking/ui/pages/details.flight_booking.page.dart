import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/models/cabin_info.flight_booking.model.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/ui/components/contact_details_getter.shared.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/details_addon_service_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/details_itinerary_card.flight_booking.component.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
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
                    Visibility(
                      visible:flightBookingController.flightDetails.value.alertMsg!="" &&
                flightBookingController
                    .flightDetails.value.cabinInfos.isEmpty,
                      child: Container(
                        padding: flyternMediumPaddingAll,
                        margin: flyternLargePaddingAll.copyWith(bottom: flyternSpaceMedium),
                        decoration: BoxDecoration(
                          color: flyternPrimaryColorBg,
                          borderRadius: BorderRadius.circular(
                              flyternBorderRadiusExtraSmall),
                        ),
                        child: Html(
                          data: flightBookingController.flightDetails.value.alertMsg,
                        ),
                      ),
                    ),
                      Visibility(
                        visible:flightBookingController.flightDetails.value.priceChanged,
                        child: Container(
                          padding: flyternMediumPaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                          margin: flyternLargePaddingAll.copyWith(bottom:  0),
                          decoration: BoxDecoration(
                            color: flyternPrimaryColorBg,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: Html(
                            data: flightBookingController.flightDetails.value.priceChangedMessage,
                          ),
                        ),
                      ),
                    Visibility(
                      visible:flightBookingController.flightDetails.value.scheduleChanged,
                      child: Container(
                        padding: flyternMediumPaddingAll.copyWith(top: flyternSpaceSmall,bottom: flyternSpaceSmall),
                        margin: flyternLargePaddingAll.copyWith(bottom: 0),
                        decoration: BoxDecoration(
                          color: flyternPrimaryColorBg,
                          borderRadius: BorderRadius.circular(
                              flyternBorderRadiusExtraSmall),
                        ),
                        child: Html(
                          data: flightBookingController.flightDetails.value.scheduleChangedMessage,
                        ),
                      ),
                    ),


                    Visibility(
                      visible: flightBookingController
                          .flightDetails.value.flightSegments.isNotEmpty,
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("itinerary".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
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

                    Visibility(
                      visible: flightBookingController
                          .flightDetails.value.cabinInfos.isNotEmpty,
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("cabin_class".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController
                          .flightDetails.value.cabinInfos.isNotEmpty,
                      child: Container(
                        padding: flyternLargePaddingHorizontal,
                        decoration: BoxDecoration(color: flyternBackgroundWhite),
                        child: Container(
                          padding: flyternLargePaddingVertical,
                          child: DropDownSelector(
                            validator: (value) => null,
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
                                 flightBookingController.changeSelectedCabinClass(
                                    selectedCabinInfo[0]);
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController
                          .cabinInfo.value.infoDescription !="",
                      child: Container(
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
                    ),

                    Visibility(
                      visible: flightBookingController
                          .flightDetails.value.cabinInfos.isNotEmpty,
                      child: Padding(
                        padding: flyternLargePaddingAll,
                        child: Text("price_details".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold)),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.adult > 0
                      && flightBookingController.flightDetails.value.isBaseFareToShow,
                      child: FlightDetailsAddonServiceCard(
                        ImageUrl: ASSETS_COUPLE_ICON,
                        keyLabel: "adult".tr,
                        value: " ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.adultBase.toStringAsFixed(3)}",
                        valueLabel:
                            "${"base_fare".tr}",

                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                          "-1" &&
                          flightBookingController.flightDetails.value.adult > 0
                          && flightBookingController.flightDetails.value.isBaseFareToShow,
                      child: Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal,
                          child: Divider()),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.child > 0
                          && flightBookingController.flightDetails.value.isBaseFareToShow,
                      child: FlightDetailsAddonServiceCard(
                        ImageUrl: ASSETS_KIDS_ICON,
                        keyLabel: "child".tr,
                        value: " ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.childBase.toStringAsFixed(3)}",
                        valueLabel:
                        "${"base_fare".tr}",
                         ),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                          "-1" &&
                          flightBookingController.flightDetails.value.child > 0
                          && flightBookingController.flightDetails.value.isBaseFareToShow,
                      child: Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal,
                          child: Divider()),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id !=
                              "-1" &&
                          flightBookingController.flightDetails.value.infant >
                              0 && flightBookingController.flightDetails.value.isBaseFareToShow,
                      child: FlightDetailsAddonServiceCard(
                        ImageUrl: ASSETS_KIDS_ICON,
                        keyLabel: "infant".tr,
                        value: " ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.infantBase.toStringAsFixed(3)}",
                        valueLabel:
                        "${"base_fare".tr}",

                      ),
                    ),

                    Visibility(
                      visible:
                      flightBookingController.cabinInfo.value.id !=
                          "-1" &&
                          flightBookingController.flightDetails.value.infant >
                              0 && flightBookingController.flightDetails.value.isBaseFareToShow,
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
                            top: flightBookingController.flightDetails.value.isBaseFareToShow ?
                            flyternSpaceSmall:flyternSpaceLarge, bottom: flyternSpaceSmall),
                        color: flyternBackgroundWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("base_fare".tr,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey60)),
                            Text(
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalBase.toStringAsFixed(3)}",
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
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalTax.toStringAsFixed(3)}",
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
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.totalPrice.toStringAsFixed(3)}",
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                          ],
                        ),
                      ),
                    ),

                    Visibility(
                      visible: flightBookingController.cabinInfo.value.id != "-1" &&
                          flightBookingController.cabinInfo.value.discount >
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
                                " - ${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.discount.toStringAsFixed(3)}",
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
                                "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.finalAmount.toStringAsFixed(3)}",
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
        bottomSheet:flightBookingController
            .flightDetails.value.cabinInfos.isNotEmpty && !flightBookingController.isFlightDetailsLoading.value ? Container(
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
                            "${flightBookingController.cabinInfo.value.currency} ${flightBookingController.cabinInfo.value.finalAmount.toStringAsFixed(3)}"),
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
                        Localizations.localeOf(context)
                            .languageCode
                            .toString() ==
                            'ar'? Ionicons.chevron_back :Ionicons.chevron_forward,
                        size: flyternFontSize20,
                      )
                    ],
                  )),
            ),
          ),
        ):Container(width: screenwidth,height: 1),
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
