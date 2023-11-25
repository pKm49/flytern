import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/cabin_class.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_data.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/services/delegates/destination_search_delegate.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper-services/flight_booking_helper_services.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/shared-module/services/delegates/input_getter_delegate.dart';
import 'package:flytern/shared-module/services/utility-services/element_style_helpers.dart';
import 'package:flytern/shared-module/ui/components/booking_options_selector.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared-module/ui/components/custom_date_picker.dart';
import 'package:flytern/shared-module/ui/components/selectable_text_pill.dart';
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
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.flightBookingController.flightSearchData.value
                    .searchList.length,
                itemBuilder: (context, index) => Container(
                      height: index != 0 ? 230 : 215,
                      width: screenwidth,
                      child: Column(
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      FlightDestination destination =
                                          await showSearch(
                                              context: context,
                                              delegate:
                                                  DestinationSearchDelegate());

                                      widget.flightBookingController
                                          .setDestination(
                                              destination, false, index);
                                    },
                                    child: Row(
                                      children: [
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          direction: Axis.vertical,
                                          children: [
                                            for (var i = 0; i < 10; i++)
                                              Container(
                                                color: i % 2 == 0
                                                    ? flyternSecondaryColor
                                                    : Colors.transparent,
                                                width: 1,
                                                height: 3,
                                              ),
                                            Icon(Icons.flight_takeoff_outlined,
                                                color: flyternSecondaryColor),
                                          ],
                                        ),
                                        addHorizontalSpace(flyternSpaceSmall),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            clipBehavior: Clip.hardEdge,
                                            child: FlightAirportLabelCard(
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
                                                  .airportName,
                                              sideNumber: 1,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(flyternSpaceMedium),
                                InkWell(
                                  onTap: () {
                                    widget.flightBookingController
                                        .reverseTrip(index);
                                  },
                                  child: Icon(
                                    Ionicons.sync_circle,
                                    size: 35,
                                    color: flyternTertiaryColor,
                                  ),
                                ),
                                addHorizontalSpace(flyternSpaceMedium),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () async {
                                      FlightDestination destination =
                                          await showSearch(
                                              context: context,
                                              delegate:
                                                  DestinationSearchDelegate());

                                      widget.flightBookingController
                                          .setDestination(
                                              destination, true, index);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          direction: Axis.vertical,
                                          children: [
                                            for (var i = 0; i < 10; i++)
                                              Container(
                                                color: i % 2 == 0
                                                    ? flyternSecondaryColor
                                                    : Colors.transparent,
                                                width: 1,
                                                height: 3,
                                              ),
                                            Icon(Icons.flight_land_outlined,
                                                color: flyternSecondaryColor),
                                          ],
                                        ),
                                        addHorizontalSpace(flyternSpaceSmall),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            clipBehavior: Clip.hardEdge,
                                            child: FlightAirportLabelCard(
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
                                                  .airportName,
                                              sideNumber: 1,
                                            ),
                                          ),
                                        )
                                      ],
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
                                            false);
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
                                                  addVerticalSpace(flyternSpaceSmall),
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
                                              true);
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
                                                  flyternSpaceSmall ),
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
                                                        flyternSpaceSmall ),
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
                      .getSearchResults(widget.isRedirectionRequired);
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
                padding: EdgeInsets.only(top: flyternSpaceLarge,bottom: flyternSpaceMedium),
                child: Row(
                  children: [
                    Icon(Ionicons.time_outline,
                        size: flyternFontSize20,
                        color: flyternSecondaryColor),
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
                    for(var i=0;i<widget.flightBookingController.quickSearch.length;i++)
                    InkWell(
                      onTap: () {
                        widget.flightBookingController.getQuickSearchResult(
                            widget.flightBookingController.quickSearch[i]);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: flyternSpaceSmall,bottom: flyternSpaceSmall),
                        padding: flyternExtraSmallPaddingAll.copyWith(
                          left: flyternSpaceSmall,right: flyternSpaceSmall
                        ),
                        decoration:flyternBorderedContainerSmallDecoration.
                        copyWith(border: Border.all(color: flyternTertiaryColor, width: .2)),
                        child: Text(getSearchParamsPreview(widget
                            .flightBookingController.quickSearch[i])),
                      )
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  void showCustomDatePicker(
      int index, DateTime currentDateTime, bool isReturn) {
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
            selectedDate: currentDateTime,
            minimumDate: isReturn
                ? widget.flightBookingController.flightSearchData.value
                    .searchList[index].departureDate
                : DateTime.now(),
            maximumDate: isReturn
                ? widget.flightBookingController.flightSearchData.value
                    .searchList[index].departureDate
                    .add(Duration(days: 365))
                : DateTime.now().add(Duration(days: 365)),
            dateSelected: (DateTime? dateTime) {
              if (dateTime != null && dateTime.isAfter(DateTime.now())) {
                widget.flightBookingController
                    .changeDate(index, isReturn, dateTime, false);
              }
            },
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
}
