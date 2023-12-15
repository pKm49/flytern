import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/flight_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/seat_column.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/addons/seat/seat_selection.flight_booking.model.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/toaster_snackbar_shower.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/selectable_text_pill.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightSeatSelectionPage extends StatefulWidget {
  const FlightSeatSelectionPage({super.key});

  @override
  State<FlightSeatSelectionPage> createState() =>
      _FlightSeatSelectionPageState();
}

class _FlightSeatSelectionPageState extends State<FlightSeatSelectionPage> {
  final flightBookingController = Get.find<FlightBookingController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text('available_seats'.tr),
        ),
        body: Stack(
          children: [
            Visibility(
                visible: flightBookingController.isGetSeatsLoading.value,
                child: Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                  color: flyternSecondaryColor,
                  size: 50,
                ))),
            Visibility(
              visible: !flightBookingController.isGetSeatsLoading.value,
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
                    Container(
                      padding: flyternLargePaddingAll,
                      color: flyternBackgroundWhite,
                      child: Wrap(
                        children: [
                          for (var i = 0;
                          i < flightBookingController.addonRoutes.length;
                          i++)
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: flyternSpaceSmall,
                                  bottom: flyternSpaceSmall),
                              child: SelectableTilePill(
                                onPressed: () {
                                  if (flightBookingController
                                      .addonRoutes[i].routeID != flightBookingController
                                      .selectedRouteForSeat.value) {
                                    flightBookingController
                                        .changeSelectedRouteForSeat(flightBookingController
                                        .addonRoutes[i].routeID);
                                  }
                                },
                                label:flightBookingController
                                    .addonRoutes[i].groupName,
                                isSelected: flightBookingController
                                    .addonRoutes[i].routeID == flightBookingController
                                    .selectedRouteForSeat.value,
                                themeNumber: 2,
                              ),
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
                              groupValue: flightBookingController
                                  .selectedPassengerForSeat.value,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    flightBookingController
                                        .changeSelectedPassengerForSeat(value);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    for (var i = 0;
                        i < flightBookingController.addonFlightClass.length;
                        i++)
                      Visibility(
                        visible: flightBookingController
                                .addonFlightClass[i].routeID ==
                            flightBookingController.selectedRouteForSeat.value,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: flyternLargePaddingAll,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                        flightBookingController
                                            .addonFlightClass[i]
                                            .ticketClassType,
                                        style: getBodyMediumStyle(context)
                                            .copyWith(
                                                color: flyternGrey80,
                                                fontWeight:
                                                    flyternFontWeightBold)),
                                  ),
                                  Visibility(
                                      visible: flightBookingController
                                          .addonFlightClass[i].wifi,
                                      child: Icon(Ionicons.wifi,
                                          color: flyternGrey60,
                                          size: flyternFontSize20)),
                                  Visibility(
                                      visible: flightBookingController
                                          .addonFlightClass[i].meal,
                                      child: addHorizontalSpace(
                                          flyternSpaceSmall)),
                                  Visibility(
                                      visible: flightBookingController
                                          .addonFlightClass[i].meal,
                                      child: Icon(Ionicons.restaurant_outline,
                                          color: flyternGrey60,
                                          size: flyternFontSize20)),
                                  Visibility(
                                      visible: flightBookingController
                                          .addonFlightClass[i].monitor,
                                      child: addHorizontalSpace(
                                          flyternSpaceSmall)),
                                  Visibility(
                                      visible: flightBookingController
                                          .addonFlightClass[i].monitor,
                                      child: Icon(Ionicons.tv_outline,
                                          color: flyternGrey60,
                                          size: flyternFontSize20)),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: flyternBackgroundWhite,
                                border: flyternDefaultBorderBottomOnly
                              ),
                              padding: flyternLargePaddingAll ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(getSelectedSeatPrice(),style: getBodyMediumStyle(context).
                                    copyWith(color: flyternSecondaryColor,fontWeight: flyternFontWeightBold),)),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Ionicons.square,
                                            color: flyternTertiaryColor),
                                        addHorizontalSpace(flyternSpaceMedium),
                                        Text("available".tr,
                                            style: getBodyMediumStyle(context)
                                                .copyWith(color: flyternGrey80)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Icon(Ionicons.square, color: flyternGrey40),
                                        addHorizontalSpace(flyternSpaceMedium),
                                        Text("occupied".tr,
                                            style: getBodyMediumStyle(context)
                                                .copyWith(color: flyternGrey80)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: flightBookingController
                                      .addonFlightClass[i]
                                      .wingRowPositionFirstRow !=
                                  -1,
                              child: Container(
                                color: flyternBackgroundWhite,
                                padding: flyternLargePaddingAll.copyWith(
                                    top: flyternSpaceLarge * 2),
                                height: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var wingRowIndex =
                                            flightBookingController
                                                .addonFlightClass[i]
                                                .wingRowPositionFirstRow;
                                        wingRowIndex <=
                                            flightBookingController
                                                .addonFlightClass[i]
                                                .wingRowPositionLastRow;
                                        wingRowIndex++)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          for (var columnPositionIndex = 0;
                                              columnPositionIndex <
                                                  flightBookingController
                                                      .addonFlightClass[i]
                                                      .columnPosition
                                                      .split("-")
                                                      .toList()
                                                      .length;
                                              columnPositionIndex++)
                                            Expanded(
                                              flex: int.parse(
                                                  flightBookingController
                                                          .addonFlightClass[i]
                                                          .columnPosition
                                                          .split("-")
                                                          .toList()[
                                                      columnPositionIndex]),
                                              child: Row(
                                                mainAxisAlignment: columnPositionIndex ==
                                                        0
                                                    ? MainAxisAlignment.start
                                                    : columnPositionIndex ==
                                                            (flightBookingController
                                                                    .addonFlightClass[
                                                                        i]
                                                                    .columnPosition
                                                                    .split("-")
                                                                    .toList()
                                                                    .length -
                                                                1)
                                                        ? MainAxisAlignment.end
                                                        : MainAxisAlignment
                                                            .center,
                                                children: [
                                                  for (var columnIndex = 0;
                                                      columnIndex <
                                                          (columnPositionIndex ==
                                                                  0
                                                              ? (int.parse(flightBookingController
                                                                          .addonFlightClass[
                                                                              i]
                                                                          .columnPosition
                                                                          .split(
                                                                              "-")
                                                                          .toList()[
                                                                      columnPositionIndex]) +
                                                                  1)
                                                              : int.parse(flightBookingController
                                                                      .addonFlightClass[
                                                                          i]
                                                                      .columnPosition
                                                                      .split("-")
                                                                      .toList()[
                                                                  columnPositionIndex]));
                                                      columnIndex++)
                                                    columnIndex == 0 &&
                                                            columnPositionIndex ==
                                                                0
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                        flyternSpaceSmall),
                                                            child: Text(
                                                                flightBookingController
                                                                    .addonFlightClass[
                                                                        i]
                                                                    .seats[
                                                                        wingRowIndex -
                                                                            1]
                                                                    .row
                                                                    .toString(),
                                                                style: getBodyMediumStyle(
                                                                        context)
                                                                    .copyWith(
                                                                        color:
                                                                            flyternGrey60)),
                                                          )
                                                        : InkWell(
                                                      onTap: (){
                                                        if(isSeatAvailable(getSeat(
                                                            flightBookingController.addonFlightClass[
                                                            i],
                                                            wingRowIndex,
                                                            columnIndex,
                                                            columnPositionIndex) )){
                                                          flightBookingController.selectSeat(getSeat(
                                                              flightBookingController
                                                                  .addonFlightClass[i],
                                                              wingRowIndex,
                                                              columnIndex,
                                                              columnPositionIndex),
                                                              flightBookingController.
                                                              addonFlightClass[i].seats[wingRowIndex - 1].row);
                                                        }

                                                      },
                                                          child: Container(
                                                              padding:
                                                                  flyternSmallPaddingAll,
                                                              width:
                                                                  flyternFontSize24 *
                                                                      1.3,
                                                              height:
                                                                  flyternFontSize24 *
                                                                      1.3,
                                                              margin: EdgeInsets.only(
                                                                  right:
                                                                      flyternSpaceSmall,
                                                                  bottom:
                                                                      flyternSpaceSmall),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: !isSeatAvailable(getSeat(
                                                                    flightBookingController.addonFlightClass[
                                                                    i],
                                                                    wingRowIndex,
                                                                    columnIndex,
                                                                    columnPositionIndex) )
                                                                    ? flyternGrey40
                                                                    : isSelected(getSeat(
                                                                            flightBookingController
                                                                                .addonFlightClass[i],
                                                                            wingRowIndex,
                                                                            columnIndex,
                                                                            columnPositionIndex))
                                                                        ? flyternGuideGreen
                                                                        : flyternTertiaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            flyternBorderRadiusExtraSmall),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                getSeat(
                                                                        flightBookingController
                                                                            .addonFlightClass[i],
                                                                        wingRowIndex,
                                                                        columnIndex,
                                                                        columnPositionIndex)
                                                                    .position,
                                                                style: TextStyle(
                                                                    color:
                                                                        flyternBackgroundWhite),
                                                              )),
                                                            ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: flightBookingController
                                      .addonFlightClass[i]
                                      .exitRowPositionFirstRow !=
                                  -1,
                              child: Container(
                                color: flyternBackgroundWhite,
                                padding: flyternLargePaddingAll,
                                height: 170,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var wingRowIndex =
                                            flightBookingController
                                                .addonFlightClass[i]
                                                .exitRowPositionFirstRow;
                                        wingRowIndex <=
                                            flightBookingController
                                                .addonFlightClass[i]
                                                .exitRowPositionLastRow;
                                        wingRowIndex++)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          for (var columnPositionIndex = 0;
                                              columnPositionIndex <
                                                  flightBookingController
                                                      .addonFlightClass[i]
                                                      .columnPosition
                                                      .split("-")
                                                      .toList()
                                                      .length;
                                              columnPositionIndex++)
                                            Expanded(
                                              flex: int.parse(
                                                  flightBookingController
                                                          .addonFlightClass[i]
                                                          .columnPosition
                                                          .split("-")
                                                          .toList()[
                                                      columnPositionIndex]),
                                              child: Row(
                                                mainAxisAlignment: columnPositionIndex ==
                                                        0
                                                    ? MainAxisAlignment.start
                                                    : columnPositionIndex ==
                                                            (flightBookingController
                                                                    .addonFlightClass[
                                                                        i]
                                                                    .columnPosition
                                                                    .split("-")
                                                                    .toList()
                                                                    .length -
                                                                1)
                                                        ? MainAxisAlignment.end
                                                        : MainAxisAlignment
                                                            .center,
                                                children: [
                                                  for (var columnIndex = 0;
                                                      columnIndex <
                                                          (columnPositionIndex ==
                                                                  0
                                                              ? (int.parse(flightBookingController
                                                                          .addonFlightClass[
                                                                              i]
                                                                          .columnPosition
                                                                          .split(
                                                                              "-")
                                                                          .toList()[
                                                                      columnPositionIndex]) +
                                                                  1)
                                                              : int.parse(flightBookingController
                                                                      .addonFlightClass[
                                                                          i]
                                                                      .columnPosition
                                                                      .split("-")
                                                                      .toList()[
                                                                  columnPositionIndex]));
                                                      columnIndex++)
                                                    columnIndex == 0 &&
                                                            columnPositionIndex ==
                                                                0
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                        flyternSpaceSmall),
                                                            child: Text(
                                                                flightBookingController
                                                                    .addonFlightClass[
                                                                        i]
                                                                    .seats[
                                                                        wingRowIndex -
                                                                            1]
                                                                    .row
                                                                    .toString(),
                                                                style: getBodyMediumStyle(
                                                                        context)
                                                                    .copyWith(
                                                                        color:
                                                                            flyternGrey60)),
                                                          )
                                                        : InkWell(
                                                      onTap: (){
                                                        if(isSeatAvailable(getSeat(
                                                            flightBookingController.addonFlightClass[
                                                            i],
                                                            wingRowIndex,
                                                            columnIndex,
                                                            columnPositionIndex) )){
                                                          flightBookingController.selectSeat(getSeat(
                                                              flightBookingController
                                                                  .addonFlightClass[i],
                                                              wingRowIndex,
                                                              columnIndex,
                                                              columnPositionIndex),
                                                              flightBookingController.
                                                              addonFlightClass[i].seats[wingRowIndex - 1].row);
                                                        }

                                                      },
                                                      child: Container(
                                                        padding:
                                                        flyternSmallPaddingAll,
                                                        width:
                                                        flyternFontSize24 *
                                                            1.3,
                                                        height:
                                                        flyternFontSize24 *
                                                            1.3,
                                                        margin: EdgeInsets.only(
                                                            right:
                                                            flyternSpaceSmall,
                                                            bottom:
                                                            flyternSpaceSmall),
                                                        decoration:
                                                        BoxDecoration(
                                                          color: !isSeatAvailable(getSeat(
                                                              flightBookingController.addonFlightClass[
                                                              i],
                                                              wingRowIndex,
                                                              columnIndex,
                                                              columnPositionIndex) )
                                                              ? flyternGrey40
                                                              : isSelected(getSeat(
                                                              flightBookingController
                                                                  .addonFlightClass[i],
                                                              wingRowIndex,
                                                              columnIndex,
                                                              columnPositionIndex))
                                                              ? flyternGuideGreen
                                                              : flyternTertiaryColor,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              flyternBorderRadiusExtraSmall),
                                                        ),
                                                        child: Center(
                                                            child: Text(
                                                              getSeat(
                                                                  flightBookingController
                                                                      .addonFlightClass[i],
                                                                  wingRowIndex,
                                                                  columnIndex,
                                                                  columnPositionIndex)
                                                                  .position,
                                                              style: TextStyle(
                                                                  color:
                                                                  flyternBackgroundWhite),
                                                            )),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
        bottomSheet: !flightBookingController.isGetSeatsLoading.value
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
                              .isSeatsSaveLoading.value){
                            handleSubmission();

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
                                    .isSeatsSaveLoading.value,
                                child: Text("apply".tr)),
                            Visibility(
                                visible: flightBookingController
                                    .isSeatsSaveLoading.value,
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
                        ))  ,
                  ),
                ),
              )
            : Container(width: screenwidth, height: 10),
      ),
    );
  }

  int getColumnIndex() {
    return 0;
  }

  FlightAddonSeatColumn getSeat(FlightAddonFlightClass addonFlightClass,
      int wingRowIndex, int columnIndex, int columnPositionIndex) {

    if (columnPositionIndex == 0) {
      return addonFlightClass.seats[wingRowIndex - 1].columns[columnIndex - 1];
    } else {
      int sectionColumnCount = 0;
      for (var i = columnPositionIndex; i > 0; i--) {
        sectionColumnCount += int.parse(
            addonFlightClass.columnPosition.split("-").toList()[i - 1]);
      }


      if (columnIndex + sectionColumnCount >=
          addonFlightClass.seats[wingRowIndex - 1].columns.length) {
        return mapFlightAddonSeatColumn({});
      } else {
        return addonFlightClass
            .seats[wingRowIndex - 1].columns[columnIndex + sectionColumnCount];
      }
    }
  }

  isSelected(FlightAddonSeatColumn seat) {
    List<FlightAddonSeatSelection> listOfSelection = flightBookingController
        .flightAddonSetSeatData.value.listOfSelection
        .where((element) => (element.routeID ==
                flightBookingController.selectedRouteForSeat.value &&
            element.passengerID ==
                flightBookingController.selectedPassengerForSeat.value))
        .toList();
    if (listOfSelection.isNotEmpty) {
      if (listOfSelection[0].seatId == seat.seatId) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void handleSubmission() {

    bool isSeatsSelected = true;

    flightBookingController.flightAddonSetSeatData.value.listOfSelection.forEach((element) {
      if(element.seatId == "-1"){
        isSeatsSelected = false;
      }
    });

    if(!isSeatsSelected){
      showSnackbar(context, "please_select_seat".tr, "error");
    }else{
      flightBookingController.setSeats();

    }

  }

  bool isSeatAvailable(FlightAddonSeatColumn seat) {
    if(!seat.isAvailable){
      return false;
    }

    List<FlightAddonSeatSelection> listOfSelection = flightBookingController
        .flightAddonSetSeatData.value.listOfSelection
        .where((element) => (element.seatId == seat.seatId &&
        element.routeID ==
    flightBookingController.selectedRouteForSeat.value &&
    element.passengerID !=
        flightBookingController.selectedPassengerForSeat.value))
        .toList();
    if (listOfSelection.isNotEmpty) {
      return false;
    }
    return true;

  }

  String getSelectedSeatPrice() {

    List<FlightAddonSeatSelection> listOfSelection = flightBookingController
        .flightAddonSetSeatData.value.listOfSelection
        .where((element) => (element.routeID ==
        flightBookingController.selectedRouteForSeat.value &&
        element.passengerID ==
            flightBookingController.selectedPassengerForSeat.value))
        .toList();
    if (listOfSelection.isNotEmpty) {

     return "${listOfSelection[0].currency} ${listOfSelection[0].amount}";
    }
    return "";

  }

  String getTotalSeatPrice() {
    String currency = "KWD";
    double amount = 0.0;
    flightBookingController
        .flightAddonSetSeatData.value.listOfSelection.forEach((element) {
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
