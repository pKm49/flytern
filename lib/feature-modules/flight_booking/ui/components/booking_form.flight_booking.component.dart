import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/constants/flight_mode.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/cabin_class.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_data.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_item.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/ui/pages/custom_destination_search_delegate.flight.page.dart';
import 'package:flytern/feature-modules/flight_booking/services/destination_search_delegate.flight_booking.service.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper.flight_booking.service.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/airport_lable_card.flight_booking.component.dart';
import 'package:flytern/shared-module/services/delegates/input_getter_delegate.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/element_style_helper.shared.service.dart';
import 'package:flytern/shared-module/ui/components/booking_options_selector.shared.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightBookingForm extends StatefulWidget {
  FlightBookingController flightBookingController;
  bool isRedirectionRequired;

  FlightBookingForm(
      {super.key,
      required this.flightBookingController,
      required this.isRedirectionRequired});

  @override
  State<FlightBookingForm> createState() => _FlightBookingFormState();
}

class _FlightBookingFormState extends State<FlightBookingForm> {
  bool isDirectFlight = false;
  var flightBookingHelperServices = FlightBookingHelperServices();
  var elementStyleHelpers = ElementStyleHelpers();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Wrap(
        children: [
          Container(
            height: flightBookingHelperServices.getFlightBookingFormItemHeight(
                widget.flightBookingController.flightSearchData.value.searchList
                    .length),
            margin: EdgeInsets.only(bottom: flyternSpaceMedium),
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.flightBookingController.flightSearchData.value
                    .searchList.length,
                itemBuilder: (context, index) => Container(
                      height: index != 0 ? 230 : 200,
                      width: screenwidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: index != 0,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: flyternSpaceSmall),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      widget.flightBookingController
                                          .updateFlightCount(index);
                                    },
                                    child: Text(
                                      "remove".tr,
                                      style: getLabelLargeStyle(context)
                                          .copyWith(
                                              color: flyternGuideRed,
                                              decoration:
                                                  TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: flyternBorderedContainerSmallDecoration
                                .copyWith(
                                    border: Border.all(
                                        color: flyternSecondaryColor,
                                        width: .5)),
                            padding: flyternMediumPaddingAll,
                            width: screenwidth -
                                ((flyternSpaceLarge * 2) +
                                    (flyternSpaceMedium * 2)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      // FlightDestination destination =
                                      //     await showSearch(
                                      //         context: context,
                                      //         delegate:
                                      //             DestinationSearchDelegate());


                                      showDestinationGetterInput(false, index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      clipBehavior: Clip.hardEdge,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FlightAirportLabelCard(
                                            topLabel: "from".tr,
                                            midLabel: widget
                                                .flightBookingController
                                                .flightSearchData
                                                .value
                                                .searchList[index]
                                                .departure
                                                .airportCode,
                                            bottomLabel: widget
                                                        .flightBookingController
                                                        .flightSearchData
                                                        .value
                                                        .searchList[index]
                                                        .departure
                                                        .airportName
                                                        .length >
                                                    12
                                                ? widget
                                                    .flightBookingController
                                                    .flightSearchData
                                                    .value
                                                    .searchList[index]
                                                    .departure
                                                    .airportName
                                                    .substring(0, 12)
                                                : widget
                                                    .flightBookingController
                                                    .flightSearchData
                                                    .value
                                                    .searchList[index]
                                                    .departure
                                                    .airportName,
                                            sideNumber: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.flightBookingController
                                        .reverseTrip(index);
                                  },
                                  child: Icon(
                                    Ionicons.swap_horizontal_outline,
                                    size: 30,
                                    color: flyternTertiaryColor,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      // FlightDestination destination =
                                      //     await showSearch(
                                      //         context: context,
                                      //         delegate:
                                      //             DestinationSearchDelegate());
                                      showDestinationGetterInput(true, index);

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      clipBehavior: Clip.hardEdge,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          FlightAirportLabelCard(
                                            topLabel: "to".tr,
                                            midLabel: widget
                                                .flightBookingController
                                                .flightSearchData
                                                .value
                                                .searchList[index]
                                                .arrival
                                                .airportCode,
                                            bottomLabel: widget
                                                        .flightBookingController
                                                        .flightSearchData
                                                        .value
                                                        .searchList[index]
                                                        .arrival
                                                        .airportName
                                                        .length >
                                                    12
                                                ? widget
                                                    .flightBookingController
                                                    .flightSearchData
                                                    .value
                                                    .searchList[index]
                                                    .arrival
                                                    .airportName
                                                    .substring(0, 12)
                                                : widget
                                                    .flightBookingController
                                                    .flightSearchData
                                                    .value
                                                    .searchList[index]
                                                    .arrival
                                                    .airportName,
                                            sideNumber: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: flyternSpaceMedium),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: () {
                                        showCustomDatePicker(
                                            index,
                                            widget
                                                .flightBookingController
                                                .flightSearchData
                                                .value
                                                .searchList[index]
                                                .departureDate,
                                            false,
                                            'travel_date'.tr);
                                      },
                                      child: Container(
                                        decoration:
                                            flyternBorderedContainerSmallDecoration
                                                .copyWith(
                                                    border: Border.all(
                                                        color: flyternGrey20,
                                                        width: .5)),
                                        padding: flyternSmallPaddingAll,
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_month,
                                                color: flyternSecondaryColor,
                                                size: flyternFontSize20),
                                            addHorizontalSpace(
                                                flyternSpaceSmall),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'travel_date'.tr,
                                                    style: getLabelLargeStyle(
                                                            context)
                                                        .copyWith(
                                                            color:
                                                                flyternGrey40,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  addVerticalSpace(
                                                      flyternSpaceSmall),
                                                  Text(
                                                      getFormattedDate(widget
                                                          .flightBookingController
                                                          .flightSearchData
                                                          .value
                                                          .searchList[index]
                                                          .departureDate),
                                                      style: getLabelLargeStyle(
                                                              context)
                                                          .copyWith(
                                                        color: flyternGrey80,
                                                      )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                                Visibility(
                                    visible: widget.flightBookingController
                                            .flightSearchData.value.mode ==
                                        FlightMode.ROUNDTRIP,
                                    child:
                                        addHorizontalSpace(flyternSpaceSmall)),
                                Visibility(
                                  visible: widget.flightBookingController
                                          .flightSearchData.value.mode ==
                                      FlightMode.ROUNDTRIP,
                                  child: Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          showCustomDatePicker(
                                              index,
                                              widget
                                                  .flightBookingController
                                                  .flightSearchData
                                                  .value
                                                  .searchList[index]
                                                  .returnDate!,
                                              true,
                                              'return_date'.tr);
                                        },
                                        child: Container(
                                          decoration:
                                              flyternBorderedContainerSmallDecoration
                                                  .copyWith(
                                                      border: Border.all(
                                                          color: flyternGrey20,
                                                          width: .5)),
                                          padding: flyternSmallPaddingAll,
                                          child: Row(
                                            children: [
                                              Icon(Icons.calendar_month,
                                                  color: flyternSecondaryColor,
                                                  size: flyternFontSize20),
                                              addHorizontalSpace(
                                                  flyternSpaceSmall),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'return_date'.tr,
                                                      style: getLabelLargeStyle(
                                                              context)
                                                          .copyWith(
                                                              color:
                                                                  flyternGrey40,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    addVerticalSpace(
                                                        flyternSpaceSmall),
                                                    Text(
                                                        widget
                                                                    .flightBookingController
                                                                    .flightSearchData
                                                                    .value
                                                                    .searchList[
                                                                        index]
                                                                    .returnDate ==
                                                                null
                                                            ? ""
                                                            : getFormattedDate(widget
                                                                .flightBookingController
                                                                .flightSearchData
                                                                .value
                                                                .searchList[
                                                                    index]
                                                                .returnDate!),
                                                        style: getLabelLargeStyle(
                                                                context)
                                                            .copyWith(
                                                                color:
                                                                    flyternGrey80)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
          ),
          Visibility(
              visible:
                  widget.flightBookingController.flightSearchData.value.mode ==
                      FlightMode.MULTICITY,
              child: Padding(
                padding: const EdgeInsets.only(bottom: flyternSpaceMedium),
                child: SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      widget.flightBookingController.updateFlightCount(-1);
                    },
                    child: Container(
                      decoration:
                          flyternBorderedContainerSmallDecoration.copyWith(
                              border: Border.all(
                                  color: flyternSecondaryColor, width: .5)),
                      padding: flyternMediumPaddingAll,
                      child: Center(
                          child: Text("+ " + "add_another_city".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(color: flyternSecondaryColor))),
                    ),
                  ),
                ),
              )),
          InkWell(
            onTap: () {
              openFlightOptionsSelector();
            },
            child: Container(
              decoration: flyternBorderedContainerSmallDecoration.copyWith(
                  border: Border.all(color: flyternGrey20, width: .5)),
              padding: flyternMediumPaddingAll,
              child: Row(
                children: [
                  Icon(Ionicons.person_outline,
                      color: flyternSecondaryColor, size: flyternFontSize20),
                  addHorizontalSpace(flyternSpaceSmall * 1.5),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'passengers_cabin_class'.tr,
                          style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey40,
                              fontWeight: FontWeight.w400),
                        ),
                        addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                        Text(
                            flightBookingHelperServices.getPassengerCabinData(
                                Localizations.localeOf(context)
                                    .languageCode
                                    .toString(),
                                widget.flightBookingController),
                            style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey80,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceMedium),
          InkWell(
            onTap: () {
              showPromoCodeInput();
            },
            child: Container(
              decoration: flyternBorderedContainerSmallDecoration.copyWith(
                  border: Border.all(color: flyternGrey20, width: .5)),
              padding: flyternMediumPaddingAll,
              child: Row(
                children: [
                  Icon(Icons.discount_outlined,
                      color: flyternSecondaryColor, size: flyternFontSize20),
                  addHorizontalSpace(flyternSpaceSmall * 1.5),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'promo_code'.tr,
                          style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey40,
                              fontWeight: FontWeight.w400),
                        ),
                        addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                        Text(
                            widget.flightBookingController.flightSearchData
                                        .value.promoCode ==
                                    ""
                                ? "enter_promo_code".tr
                                : widget.flightBookingController
                                    .flightSearchData.value.promoCode,
                            style: getLabelLargeStyle(context).copyWith(
                              color: flyternGrey80,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(
                    elementStyleHelpers.getColor),
                value: widget.flightBookingController.flightSearchData.value
                    .isDirectFlight,
                onChanged: (bool? value) {
                  if (value != null) {
                    widget.flightBookingController.updateDirectFlight(value);
                  }
                },
              ),
              addHorizontalSpace(flyternSpaceSmall),
              Expanded(
                child: Text("direct_flight".tr,
                    style: getBodyMediumStyle(context), maxLines: 2),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: getElevatedButtonStyle(context),
                onPressed: () {
                  widget.flightBookingController
                      .getSearchResults(widget.isRedirectionRequired,false);
                },
                child: widget.flightBookingController
                        .isFlightSearchResponsesLoading.value
                    ? LoadingAnimationWidget.prograssiveDots(
                        color: flyternBackgroundWhite,
                        size: 16,
                      )
                    : Text("search_flights".tr)),
          ),
          Visibility(
            visible:
                !widget.flightBookingController.isInitialDataLoading.value &&
                    widget.flightBookingController.quickSearch.isNotEmpty,
            child: Padding(
                padding: EdgeInsets.only(
                    top: flyternSpaceLarge, bottom: flyternSpaceMedium),
                child: Row(
                  children: [
                    Icon(Ionicons.time_outline,
                        size: flyternFontSize20, color: flyternSecondaryColor),
                    addHorizontalSpace(flyternSpaceSmall),
                    Text("recent_searches".tr,
                        style: getBodyMediumStyle(context)
                            .copyWith(fontWeight: flyternFontWeightBold)),
                  ],
                )),
          ),
          Visibility(
            visible:
                !widget.flightBookingController.isInitialDataLoading.value &&
                    widget.flightBookingController.quickSearch.isNotEmpty,
            child: Container(
                margin: EdgeInsets.only(bottom: flyternSpaceMedium),
                width: double.infinity,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    for (var i = 0;
                        i < widget.flightBookingController.quickSearch.length;
                        i++)
                      InkWell(
                          onTap: () {
                            widget.flightBookingController.getQuickSearchResult(
                                widget.flightBookingController.quickSearch[i]);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: flyternSpaceSmall,
                                bottom: flyternSpaceSmall),
                            padding: flyternExtraSmallPaddingAll.copyWith(
                                left: flyternSpaceSmall,
                                right: flyternSpaceSmall),
                            decoration: flyternBorderedContainerSmallDecoration
                                .copyWith(
                                    border: Border.all(
                                        color: flyternTertiaryColor,
                                        width: .2)),
                            child: Text(getSearchParamsPreview(
                                widget.flightBookingController.quickSearch[i])),
                          ))
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void showCustomDatePicker(
      int index, DateTime currentDateTime, bool isReturn, String title) {
    showModalBottomSheet(
        useSafeArea: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CustomDatePicker(
              isSingleTapSubmission:true,
            selectedDate: currentDateTime,
            minimumDate: isReturn
                ? widget.flightBookingController.flightSearchData.value
                    .searchList[index].departureDate
                : widget.flightBookingController.flightSearchData.value.mode ==
                        FlightMode.MULTICITY
                    ? index != 0
                        ? widget.flightBookingController.flightSearchData.value
                            .searchList[index - 1].departureDate
                        : DateTime.now()
                    : DateTime.now(),
            maximumDate: isReturn
                ? widget.flightBookingController.flightSearchData.value
                    .searchList[index].departureDate
                    .add(Duration(days: 365))
                : widget.flightBookingController.flightSearchData.value.mode ==
                        FlightMode.MULTICITY
                    ? currentDateTime.add(Duration(days: 365))
                    : DateTime.now().add(Duration(days: 365)),
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null && dateTime.isAfter(DateTime.now().add(const Duration(days: -1)))) {
                widget.flightBookingController
                    .changeDate(index, isReturn, dateTime);

              }
            },
            title:title
          );
        });
  }

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat.yMMMd('en_US');
    return f.format(dateTime);
  }

  void openFlightOptionsSelector() {
    showModalBottomSheet(
        useSafeArea: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(flyternBorderRadiusSmall),
              topRight: Radius.circular(flyternBorderRadiusSmall)),
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BookingOptionsSelector(
            selectedAdultCount:
                widget.flightBookingController.flightSearchData.value.adults,
            selectedChildCount:
                widget.flightBookingController.flightSearchData.value.child,
            selectedInfantCount:
                widget.flightBookingController.flightSearchData.value.infants,
            dataSubmitted: (int adultCount, int childCount, int infantCount,
                List<CabinClass> cabinClasses, List<int> childAges) {
              widget.flightBookingController.updatePassengerCountAndCabinClass(
                  adultCount, childCount, infantCount, cabinClasses);
              Navigator.pop(context);
            },
            childAges: [],
            bookingServiceNumber: 1,
            cabinClasses: widget.flightBookingController.cabinClasses.value,
            selectedCabinClasses: widget
                .flightBookingController.flightSearchData.value.allowedCabins
                .map((e) => e.value)
                .toList(),
          );
        });
  }

  void showDestinationGetterInput( bool isArrival,
      int index) {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return CustomFlightDestinationSearchDelegate(

                destinationSelected: (FlightDestination flightDestination) {
                  widget.flightBookingController
                      .setDestination(
                      flightDestination, isArrival, index);

                  Navigator.pop(context);
                });
          });
        });
  }

  void showPromoCodeInput() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return InputGetterDelegate(
                currentText: widget
                    .flightBookingController.flightSearchData.value.promoCode,
                hintText: "enter_promo_code".tr,
                textSubmitted: (String text) {
                  widget.flightBookingController.updatePromoCode(text);
                  Navigator.pop(context);
                });
          });
        });
  }

  String getSearchParamsPreview(FlightSearchData quickSearch) {
    String searchParamsPreviewString = "";

    if (quickSearch.searchList.isNotEmpty) {
      quickSearch.searchList.forEach((element) {
        searchParamsPreviewString +=
            "${element.departure.airportCode}-${element.arrival.airportCode}";
      });
    }
    // searchParamsPreviewString +=
    // " ${quickSearch.mode.name}";

    return searchParamsPreviewString;
  }

  getDateString(FlightSearchItem element) {
    if (element.returnDate == null) {
      return "  ${getFormattedDate(element.departureDate)}";
    }
    if (element.returnDate?.day == element.departureDate.day) {
      return "  ${getFormattedDate(element.departureDate)}";
    }
    return " ${element.departureDate.day}-${getFormattedDate(element.returnDate!)}";
  }

  void handleReturnClick(int index) {
    showCustomDatePicker(
        index,
        widget
            .flightBookingController
            .flightSearchData
            .value
            .searchList[index]
            .returnDate!,
        true,
        'return_date'.tr);
  }
}
