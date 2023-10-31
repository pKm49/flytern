import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/enums/flight_filter_options.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/range_dcs.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/sorting_dcs.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/element_style_helpers.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/selectable_text_pill.dart';
import 'package:get/get.dart';

class FlightFilterOptionSelector extends StatefulWidget {
  String currency;
  FlightSearchResult availableFilterOptions;
  FlightSearchResult selectedFilterOptions;

  final GestureTapCallback setModalState;
  final Function(FlightSearchResult selectedFilterOptions)
      filterSubmitted; // <------------|

  FlightFilterOptionSelector(
      {super.key,
      required this.availableFilterOptions,
      required this.currency,
      required this.selectedFilterOptions,
      required this.filterSubmitted,
      required this.setModalState});

  @override
  State<FlightFilterOptionSelector> createState() =>
      _FlightFilterOptionSelectorState();
}

class _FlightFilterOptionSelectorState
    extends State<FlightFilterOptionSelector> {
  late FlightSearchResult selectedFilterOptions;
  RangeValues _currentSliderValue = const RangeValues(0, 10000);
  var elementStyleHelpers = ElementStyleHelpers();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedFilterOptions = widget.selectedFilterOptions;
    _currentSliderValue = RangeValues(
      widget.selectedFilterOptions.priceDcs.isNotEmpty
          ? widget.selectedFilterOptions.priceDcs[0].min
          :  widget.availableFilterOptions.priceDcs.isNotEmpty
          ? widget.availableFilterOptions.priceDcs[0].min
          : 0,
      widget.selectedFilterOptions.priceDcs.isNotEmpty
          ? widget.selectedFilterOptions.priceDcs[0].max
          :  widget.availableFilterOptions.priceDcs.isNotEmpty
          ? widget.availableFilterOptions.priceDcs[0].max
          : 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      width: screenwidth,
      height: screenheight * .9,
      padding: flyternSmallPaddingAll,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: screenwidth,
              padding: flyternLargePaddingVertical,
              decoration: flyternBorderedContainerSmallDecoration,
              child: Column(
                children: [
                  Padding(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("filter".tr,
                            style: getHeadlineMediumStyle(context).copyWith(
                                color: flyternGrey80,
                                fontWeight: flyternFontWeightBold),
                            textAlign: TextAlign.center),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("cancel".tr,
                              style: getBodyMediumStyle(context).copyWith(
                                  color: flyternSecondaryColor,
                                  fontWeight: flyternFontWeightBold),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(flyternSpaceSmall),
                  Divider(),
                  addVerticalSpace(flyternSpaceMedium),
                  Expanded(
                      child: ListView(
                    children: [
                      // price
                      Visibility(
                        visible:
                            widget.availableFilterOptions.priceDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              bottom: flyternSpaceMedium),
                          child: Text("${'price'.tr} (${widget.currency})",
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.priceDcs.isNotEmpty,
                        child: Container(
                          color: flyternBackgroundWhite,
                          padding: flyternLargePaddingHorizontal,
                          height: 75,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var i = (widget.availableFilterOptions
                                              .priceDcs.isNotEmpty
                                          ? widget.availableFilterOptions
                                              .priceDcs[0].min
                                          : 0);
                                      i <=
                                          (widget.availableFilterOptions
                                                  .priceDcs.isNotEmpty
                                              ? widget.availableFilterOptions
                                                  .priceDcs[0].max
                                              : 0);
                                      i += 100)
                                    Expanded(
                                        child: Text("$i",
                                            textAlign: i <=
                                                    (widget.availableFilterOptions
                                                            .priceDcs.isNotEmpty
                                                        ? (widget
                                                                .availableFilterOptions
                                                                .priceDcs[0]
                                                                .max /
                                                            2)
                                                        : 0)
                                                ? TextAlign.center
                                                : TextAlign.end))
                                ],
                              ),
                              SliderTheme(
                                data: SliderThemeData(
                                  // here
                                  trackShape: CustomTrackShape(),
                                ),
                                child: RangeSlider(
                                  max: widget
                                      .availableFilterOptions.priceDcs[0].max,
                                  divisions: widget.availableFilterOptions
                                          .priceDcs.isNotEmpty
                                      ? (widget.availableFilterOptions
                                                  .priceDcs[0].max /
                                              100)
                                          .round()
                                      : 3,
                                  activeColor: flyternSecondaryColor,
                                  labels: RangeLabels(
                                    _currentSliderValue.start
                                        .round()
                                        .toString(),
                                    _currentSliderValue.end.round().toString(),
                                  ),
                                  onChanged: (RangeValues values) {

                                    setPriceRange(values);

                                  },
                                  values: _currentSliderValue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //airline
                      Visibility(
                        visible:
                            widget.availableFilterOptions.airlineDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.airlineDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium,
                              bottom: flyternSpaceSmall),
                          child: Text("airline".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                      ),

                      // Padding(
                      //     padding:flyternLargePaddingHorizontal.copyWith(
                      //       bottom: flyternSpaceExtraSmall
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(widget.availableFilterOptions.airlineDcs[i].name,
                      //             style: getBodyMediumStyle(context) ),
                      //         Checkbox(
                      //           checkColor: Colors.white,
                      //           fillColor: MaterialStateProperty.resolveWith(elementStyleHelpers.getColor),
                      //           value: isAirlineSelected(widget.availableFilterOptions.airlineDcs[i]),
                      //           onChanged: (bool? value) {
                      //              manageAirlineSelection(widget.availableFilterOptions.airlineDcs[i]);
                      //           },
                      //         ),
                      //       ],
                      //     )),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.departureTimeDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for (var i = 0;
                                  i <
                                      (widget.availableFilterOptions.airlineDcs
                                              .isNotEmpty
                                          ? widget.availableFilterOptions
                                              .airlineDcs.length
                                          : 0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: flyternSpaceSmall,
                                      bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed: () {
                                      manageSelection(
                                          FlightFilterOptions.AIRLINE,
                                          selectedFilterOptions.airlineDcs,
                                          widget.availableFilterOptions
                                              .airlineDcs[i]);
                                    },
                                    label:
                                        '${widget.availableFilterOptions.airlineDcs[i].name}',
                                    isSelected: isItemSelected(
                                        selectedFilterOptions.airlineDcs,
                                        widget.availableFilterOptions
                                            .airlineDcs[i]),
                                    themeNumber: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      //  Departure Time
                      Visibility(
                        visible: widget
                            .availableFilterOptions.departureTimeDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.departureTimeDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium),
                          child: Text("departure_time".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.departureTimeDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for (var i = 0;
                                  i <
                                      (widget.availableFilterOptions
                                              .departureTimeDcs.isNotEmpty
                                          ? widget.availableFilterOptions
                                              .departureTimeDcs.length
                                          : 0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: flyternSpaceSmall,
                                      bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed: () {
                                      manageSelection(
                                          FlightFilterOptions.DEPARTURETIME,
                                          selectedFilterOptions
                                              .departureTimeDcs,
                                          widget.availableFilterOptions
                                              .departureTimeDcs[i]);
                                    },
                                    label:
                                        '${widget.availableFilterOptions.departureTimeDcs[i].name}',
                                    isSelected: isItemSelected(
                                        selectedFilterOptions.departureTimeDcs,
                                        widget.availableFilterOptions
                                            .departureTimeDcs[i]),
                                    themeNumber: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Arrival Time
                      Visibility(
                        visible: widget
                            .availableFilterOptions.arrivalTimeDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.arrivalTimeDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium),
                          child: Text("arrival_time".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.arrivalTimeDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for (var i = 0;
                                  i <
                                      (widget.availableFilterOptions
                                              .arrivalTimeDcs.isNotEmpty
                                          ? widget.availableFilterOptions
                                              .arrivalTimeDcs.length
                                          : 0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: flyternSpaceSmall,
                                      bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed: () {
                                      manageSelection(
                                          FlightFilterOptions.ARRIVALTIME,
                                          selectedFilterOptions.arrivalTimeDcs,
                                          widget.availableFilterOptions
                                              .arrivalTimeDcs[i]);
                                    },
                                    label:
                                        '${widget.availableFilterOptions.arrivalTimeDcs[i].name}',
                                    isSelected: isItemSelected(
                                        selectedFilterOptions.arrivalTimeDcs,
                                        widget.availableFilterOptions
                                            .arrivalTimeDcs[i]),
                                    themeNumber: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      //Stops
                      Visibility(
                        visible:
                            widget.availableFilterOptions.stopDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.stopDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium,
                              bottom: flyternSpaceSmall),
                          child: Text("stops".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                      ),

                      for (var i = 0;
                          i <
                              (widget.availableFilterOptions.stopDcs.isNotEmpty
                                  ? widget.availableFilterOptions.stopDcs.length
                                  : 0);
                          i++)
                        Padding(
                            padding: flyternLargePaddingHorizontal.copyWith(
                                bottom: flyternSpaceExtraSmall),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    widget
                                        .availableFilterOptions.stopDcs[i].name,
                                    style: getBodyMediumStyle(context)),
                                Checkbox(
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      elementStyleHelpers.getColor),
                                  value: isItemSelected(
                                      selectedFilterOptions.stopDcs,
                                      widget.availableFilterOptions.stopDcs[i]),
                                  onChanged: (bool? value) {
                                    manageSelection(
                                        FlightFilterOptions.STOPS,
                                        selectedFilterOptions.stopDcs,
                                        widget
                                            .availableFilterOptions.stopDcs[i]);
                                  },
                                ),
                              ],
                            )),
                    ],
                  ))
                ],
              ),
            ),
          ),
          addVerticalSpace(flyternSpaceSmall),
          InkWell(
            onTap: () {
              widget.filterSubmitted(selectedFilterOptions);
            },
            child: Container(
              width: screenwidth,
              padding: flyternMediumPaddingAll,
              decoration: flyternBorderedContainerSmallDecoration,
              child: Center(
                child: Text("done".tr,
                    style: getHeadlineMediumStyle(context).copyWith(
                        color: flyternPrimaryColor,
                        fontWeight: flyternFontWeightBold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isItemSelected(List<SortingDcs> sortingDcs, SortingDcs item) {
    return sortingDcs
        .where((element) => element.value == item.value)
        .toList()
        .isNotEmpty;
  }

  manageSelection(FlightFilterOptions filterOption, List<SortingDcs> sortingDcs,
      SortingDcs item) {
    isItemSelected(sortingDcs, item)
        ? removeSelection(filterOption, item)
        : addSelection(filterOption, item);
  }

  removeSelection(FlightFilterOptions filterOption, SortingDcs item) {
    List<SortingDcs> tempItems = [];

    switch (filterOption) {
      case FlightFilterOptions.AIRLINE:
        {
          tempItems = selectedFilterOptions.airlineDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case FlightFilterOptions.DEPARTURETIME:
        {
          tempItems = selectedFilterOptions.departureTimeDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case FlightFilterOptions.PRICERANGE:
        {
          break;
        }

      case FlightFilterOptions.ARRIVALTIME:
        {
          tempItems = selectedFilterOptions.arrivalTimeDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }

      case FlightFilterOptions.STOPS:
        {
          tempItems = selectedFilterOptions.stopDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
    }
  }

  addSelection(FlightFilterOptions filterOption, SortingDcs item) {
    List<SortingDcs> tempItems = [];

    switch (filterOption) {
      case FlightFilterOptions.AIRLINE:
        {
          tempItems = selectedFilterOptions.airlineDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case FlightFilterOptions.DEPARTURETIME:
        {
          tempItems = selectedFilterOptions.departureTimeDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case FlightFilterOptions.PRICERANGE:
        {
          break;
        }

      case FlightFilterOptions.ARRIVALTIME:
        {
          tempItems = selectedFilterOptions.arrivalTimeDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }

      case FlightFilterOptions.STOPS:
        {
          tempItems = selectedFilterOptions.stopDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
    }
  }

  setSelectedFilterOptions(
      FlightFilterOptions filterOption, List<SortingDcs> items) {
    selectedFilterOptions = FlightSearchResult(
        searchResponses: [],
        priceDcs: selectedFilterOptions.priceDcs,
        sortingDcs: selectedFilterOptions.sortingDcs,
        airlineDcs: filterOption == FlightFilterOptions.AIRLINE
            ? items
            : selectedFilterOptions.airlineDcs,
        departureTimeDcs: filterOption == FlightFilterOptions.DEPARTURETIME
            ? items
            : selectedFilterOptions.departureTimeDcs,
        arrivalTimeDcs: filterOption == FlightFilterOptions.ARRIVALTIME
            ? items
            : selectedFilterOptions.arrivalTimeDcs,
        stopDcs: filterOption == FlightFilterOptions.STOPS
            ? items
            : selectedFilterOptions.stopDcs);

    setState(() {});
    widget.setModalState();
  }

  setPriceRange(RangeValues rangeValues) {
    List<RangeDcs> priceRange = [];

    priceRange.add(RangeDcs(min: rangeValues.start, max: rangeValues.end));

    selectedFilterOptions = FlightSearchResult(
        searchResponses: [],
        priceDcs: priceRange,
        sortingDcs: selectedFilterOptions.sortingDcs,
        airlineDcs: selectedFilterOptions.airlineDcs,
        departureTimeDcs: selectedFilterOptions.departureTimeDcs,
        arrivalTimeDcs: selectedFilterOptions.arrivalTimeDcs,
        stopDcs: selectedFilterOptions.stopDcs);
    print("setPriceRange");
    print(selectedFilterOptions.priceDcs[0].min);
    print(selectedFilterOptions.priceDcs[0].max);
    _currentSliderValue = rangeValues;
    setState(() {});
    widget.setModalState();
  }
}
