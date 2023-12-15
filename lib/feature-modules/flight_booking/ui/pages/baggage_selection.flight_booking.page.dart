import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/extra_package/extra_package_selection.flight_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightBaggageSelectionPage extends StatefulWidget {
  const FlightBaggageSelectionPage({super.key});

  @override
  State<FlightBaggageSelectionPage> createState() =>
      _FlightBaggageSelectionPageState();
}

class _FlightBaggageSelectionPageState extends State<FlightBaggageSelectionPage> {
 

  String selectedBaggage = "1";
  final flightBookingController = Get.find<FlightBookingController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Obx(
          () => Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text('select_baggage'.tr),
        ),
        body: Stack(
          children: [
            Visibility(
                visible: flightBookingController.isGetExtraLuggagesLoading.value,
                child: Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: flyternSecondaryColor,
                      size: 50,
                    ))),
            Visibility(
              visible: !flightBookingController.isGetExtraLuggagesLoading.value,
              child: Container(
                width: screenwidth,
                height: screenheight,
                color: flyternGrey10,
                child: ListView(
                  children: [
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("route".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    for (var i = 0;
                    i < flightBookingController.addonRoutes.length;
                    i++)
                      Container(
                        decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            border: flyternDefaultBorderBottomOnly),
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceMedium,
                            bottom: i ==
                                flightBookingController.addonRoutes.length -
                                    1
                                ? flyternSpaceMedium
                                : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                flightBookingController
                                    .addonRoutes[i].groupName,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                            Radio(
                              activeColor: flyternSecondaryColor,
                              value: flightBookingController
                                  .addonRoutes[i].routeID,
                              groupValue: flightBookingController.selectedRouteForExtraPackage.value,
                              onChanged: (value) {
                                setState(() {
                                  if(value !=null){
                                    flightBookingController.changeSelectedRouteForExtraPackage(value)  ;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("passengers".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80,
                              fontWeight: flyternFontWeightBold)),
                    ),
                    for (var i = 0;
                    i < flightBookingController.addonPassengers.length;
                    i++)
                      Container(
                        decoration: BoxDecoration(
                            color: flyternBackgroundWhite,
                            border: flyternDefaultBorderBottomOnly),
                        padding: flyternLargePaddingHorizontal.copyWith(
                            top: flyternSpaceMedium,
                            bottom: i ==
                                flightBookingController
                                    .addonPassengers.length -
                                    1
                                ? flyternSpaceMedium
                                : 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                flightBookingController
                                    .addonPassengers[i].fullName,
                                style: getBodyMediumStyle(context)
                                    .copyWith(color: flyternGrey80)),
                            Radio(
                              activeColor: flyternSecondaryColor,
                              value: flightBookingController
                                  .addonPassengers[i].passengerID,
                              groupValue: flightBookingController.selectedPassengerForExtraPackage.value,
                              onChanged: (value) {
                                setState(() {
                                  if(value !=null){
                                    flightBookingController.changeSelectedPassengerForExtraPackage(value)  ;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),


                    Padding(
                      padding: flyternLargePaddingAll,
                      child: Text("select_baggage".tr,
                          style: getBodyMediumStyle(context).copyWith(
                              color: flyternGrey80, fontWeight: flyternFontWeightBold)),
                    ),
                    for (var i = 0;
                    i < flightBookingController.addonExtraPackages.length;
                    i++)
                      Visibility(
                        visible: flightBookingController
                            .addonExtraPackages[i].routeID ==
                            flightBookingController.selectedRouteForExtraPackage.value,
                        child: Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal.copyWith(top: flyternSpaceMedium),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(flightBookingController
                                        .addonExtraPackages[i].name,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: flyternGrey80)),
                                    addHorizontalSpace(flyternSpaceSmall),
                                    Text("(${flightBookingController
                                        .addonExtraPackages[i].weight} ${flightBookingController
                                        .addonExtraPackages[i].unit})",
                                        style: getBodyMediumStyle(context)
                                            .copyWith(color: flyternGrey40)),
                                  ],
                                ),
                              ),
                              Radio(
                                activeColor: flyternSecondaryColor,
                                value: flightBookingController
                                    .addonExtraPackages[i].extraLuaggeId,
                                groupValue: getSelectedExtraPackage(),
                                onChanged: (value) {
                                  setState(() {
                                     if(value != null){
                                      flightBookingController.selectExtraPackage(flightBookingController
                                          .addonExtraPackages[i]);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
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
        bottomSheet: !flightBookingController.isGetExtraLuggagesLoading.value
            ? Container(
          width: screenwidth,
          color: flyternBackgroundWhite,
          height: 60 + (flyternSpaceSmall * 2),
          padding: flyternLargePaddingAll.copyWith(
              top: flyternSpaceSmall, bottom: flyternSpaceSmall),
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child:ElevatedButton(
                  style: getElevatedButtonStyle(context),
                  onPressed: () {
                    if(!flightBookingController
                        .isExtraLuggagesSaveLoading.value){
                      flightBookingController.setExtraPackages();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text( getTotalSeatPrice()),
                      ),
                      Visibility(
                          visible: !flightBookingController
                              .isExtraLuggagesSaveLoading.value,
                          child: Text("apply".tr)),
                      Visibility(
                          visible: flightBookingController
                              .isExtraLuggagesSaveLoading.value,
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
                  )) ,
            ),
          ),
        )
            : Container(width: screenwidth, height: 10),

      ),
    );
  }

  String getSelectedExtraPackage() {
    List<FlightAddonExtraPackageSelection> listOfSelection = flightBookingController
        .flightAddonSetExtraPackageData.value.listOfSelection
        .where((element) => (element.routeID ==
        flightBookingController.selectedRouteForExtraPackage.value &&
        element.passengerID ==
            flightBookingController.selectedPassengerForExtraPackage.value))
        .toList();
    if (listOfSelection.isNotEmpty) {
      return listOfSelection[0].extraLuaggageId;
    }
    return "-1";
  }


  String getTotalSeatPrice() {
    String currency = "KWD";
    double amount = 0.0;
    flightBookingController
        .flightAddonSetExtraPackageData.value.listOfSelection.forEach((element) {
      if(element.amount>0.0){
        amount +=element.amount;
      }
      if(element.currency !="KWD"){
        currency = element.currency;
      }
    });
    return "$currency $amount";

  }
}
