import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_destination.dart';
import 'package:flytern/feature-modules/flight_booking/services/delegates/destination_search_delegate.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_airport_lable_card.dart';
import 'package:flytern/shared/ui/components/booking_options_selector.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/custom_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class FlightBookingForm extends StatefulWidget {

  FlightBookingController flightBookingController;

  FlightBookingForm(
      {super.key,
        required this.flightBookingController});

  @override
  State<FlightBookingForm> createState() => _FlightBookingFormState();
}

class _FlightBookingFormState extends State<FlightBookingForm> {
  bool isDirectFlight = false;
  int multicityCount = 1;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Wrap(
      children: [
        Obx(
        ()=> Container(
            height: widget.flightBookingController.flightSearchData.value.searchList.length*222,
            child: ListView.builder(
              itemCount: widget.flightBookingController.flightSearchData.value.searchList.length,
                itemBuilder: (context, index) =>
              Container(
                height: 220,
                width:screenwidth,
                child: Column(
                  children: [
                    Container(
                      decoration: flyternBorderedContainerSmallDecoration.copyWith(
                          border: Border.all(color: flyternSecondaryColor, width: .5)),
                      padding: flyternMediumPaddingAll,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                FlightDestination destination = await showSearch(
                                    context: context,
                                    delegate: DestinationSearchDelegate());

                                widget.flightBookingController.setDestination(destination, false,index);

                              },
                              child: Row(
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
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
                                        midLabel: widget.flightBookingController.flightSearchData.value.searchList[index].departure.airportCode,
                                        bottomLabel: widget.flightBookingController.flightSearchData.value.searchList[index].departure.airportName,
                                        sideNumber: 1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          addHorizontalSpace(flyternSpaceMedium),
                          Icon(
                            Ionicons.sync_circle,
                            size: 35,
                            color: flyternTertiaryColor,
                          ),
                          addHorizontalSpace(flyternSpaceMedium),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () async {
                                FlightDestination destination = await showSearch(
                                    context: context,
                                    delegate: DestinationSearchDelegate());

                                widget.flightBookingController.setDestination(destination, true,index);

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
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
                                        midLabel: widget.flightBookingController.flightSearchData.value.searchList[index].arrival.airportCode,
                                        bottomLabel: widget.flightBookingController.flightSearchData.value.searchList[index].arrival.airportName,
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
                      padding: const EdgeInsets.only(top:flyternSpaceMedium),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  showCustomDatePicker();
                                },
                                child: Container(
                                  decoration:
                                  flyternBorderedContainerSmallDecoration.copyWith(
                                      border:
                                      Border.all(color: flyternGrey20, width: .5)),
                                  padding: flyternMediumPaddingAll,
                                  child: Row(
                                    children: [
                                      Icon(Icons.calendar_month,
                                          color: flyternSecondaryColor,
                                          size: flyternFontSize20),
                                      addHorizontalSpace(flyternSpaceSmall * 1.5),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'travel_date'.tr,
                                              style: getLabelLargeStyle(context).copyWith(
                                                  color: flyternGrey40,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                                            Text(getFormattedDate(widget.flightBookingController.flightSearchData.value.searchList[index].departureDate),
                                                style: getLabelLargeStyle(context).copyWith(
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
                              visible:widget.flightBookingController.flightSearchData.value.mode == FlightMode.ROUNDTRIP,
                              child: addHorizontalSpace(flyternSpaceSmall)),
                          Visibility(
                            visible: widget.flightBookingController.flightSearchData.value.mode == FlightMode.ROUNDTRIP,
                            child: Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    showCustomDatePicker();
                                  },
                                  child: Container(
                                    decoration:
                                    flyternBorderedContainerSmallDecoration.copyWith(
                                        border:
                                        Border.all(color: flyternGrey20, width: .5)),
                                    padding: flyternMediumPaddingAll,
                                    child: Row(
                                      children: [
                                        Icon(Icons.calendar_month,
                                            color: flyternSecondaryColor,
                                            size: flyternFontSize20),
                                        addHorizontalSpace(flyternSpaceSmall * 1.5),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'return_date'.tr,
                                                style: getLabelLargeStyle(context).copyWith(
                                                    color: flyternGrey40,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                                              Text(getFormattedDate(widget.flightBookingController.flightSearchData.value.searchList[index].returnDate),
                                                  style: getLabelLargeStyle(context)
                                                      .copyWith(color: flyternGrey80)),
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
              )
            ),
          ),
        ),

        Visibility(
            visible: widget.flightBookingController.flightSearchData.value.mode == FlightMode.MULTICITY,
            child: Padding(
              padding: const EdgeInsets.only(bottom:flyternSpaceMedium),
              child: SizedBox(
                width: double.infinity,
                child: InkWell(
                  onTap: () {
                    widget.flightBookingController.updateFlightCount(-1);
                  },
                  child: Container(
                    decoration: flyternBorderedContainerSmallDecoration.copyWith(
                        border:
                        Border.all(color: flyternSecondaryColor, width: .5)),
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
                            color: flyternGrey40, fontWeight: FontWeight.w400),
                      ),
                      addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                      Text('2 Passengers, Economy',
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
        Container(
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
                          color: flyternGrey40, fontWeight: FontWeight.w400),
                    ),
                    addVerticalSpace(flyternSpaceExtraSmall * 1.5),
                    Text('VXS234',
                        style: getLabelLargeStyle(context).copyWith(
                          color: flyternGrey80,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
        addVerticalSpace(flyternSpaceSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isDirectFlight,
              onChanged: (bool? value) {
                setState(() {
                  isDirectFlight = value ?? false;
                });
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
                Get.toNamed(Approute_flightsSearchResult);
              },
              child: Text("search_flights".tr)),
        ),
      ],
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return flyternSecondaryColor;
    }
    return flyternBackgroundWhite;
  }

  void showCustomDatePicker() {
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
          return CustomDatePicker(
            dateSelected: (DateTime? dateTime) {},
          );
        });
  }

  String getFormattedDate(DateTime dateTime) {
    final f = DateFormat.yMMMMd('en_US');
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
            bookingServiceNumber: 1,
          );
        });
  }
}
