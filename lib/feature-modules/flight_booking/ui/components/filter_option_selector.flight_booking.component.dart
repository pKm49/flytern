import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/constants/flight_filter_options.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_result.flight_booking.model.dart';
import 'package:flytern/shared-module/models/range_dcs.dart';
import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/element_style_helper.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/selectable_text_pill.shared.component.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

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
          : widget.availableFilterOptions.priceDcs.isNotEmpty
              ? widget.availableFilterOptions.priceDcs[0].min
              : 0,
      widget.selectedFilterOptions.priceDcs.isNotEmpty
          ? widget.selectedFilterOptions.priceDcs[0].max
          : widget.availableFilterOptions.priceDcs.isNotEmpty
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
                        Text(
                            "filter".tr +
                                (getFilterCount() > 0
                                    ? " ( ${getFilterCount()} )"
                                    : ""),
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
                  addVerticalSpace(flyternSpaceSmall),
                  Expanded(
                      child: ListView(
                    children: [
                      Visibility(
                        visible: getFilterCount() > 0,
                        child: Padding(
                          padding: flyternLargePaddingAll.copyWith(
                              top: flyternSpaceSmall,
                              bottom: flyternSpaceSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  clearFilter();
                                },
                                child: Icon(Ionicons.trash_bin_outline,
                                    color: flyternSecondaryColor,
                                    size: flyternFontSize20),
                              ),
                              addHorizontalSpace(flyternSpaceSmall),
                              InkWell(
                                onTap: () {
                                  clearFilter();
                                },
                                child: Text("clear".tr,
                                    style: getBodyMediumStyle(context).copyWith(
                                        color: flyternSecondaryColor,
                                        fontWeight: flyternFontWeightBold),
                                    textAlign: TextAlign.center),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Stops
                      Visibility(
                        visible:
                            widget.availableFilterOptions.stopDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: 0, bottom: flyternSpaceSmall),
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

                      // price
                      Visibility(
                        visible:
                            widget.availableFilterOptions.priceDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.priceDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
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
                                      i += getPriceRangeDivision())
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
                                      getPriceRangeDivision())
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
        totalFlights: 0,
        pageSize: 0,
        alertMsg: "",
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
        pageSize: 0,
        totalFlights: 0,
        alertMsg: "",
        priceDcs: priceRange,
        sortingDcs: selectedFilterOptions.sortingDcs,
        airlineDcs: selectedFilterOptions.airlineDcs,
        departureTimeDcs: selectedFilterOptions.departureTimeDcs,
        arrivalTimeDcs: selectedFilterOptions.arrivalTimeDcs,
        stopDcs: selectedFilterOptions.stopDcs);

    _currentSliderValue = rangeValues;
    setState(() {});
    widget.setModalState();
  }

  int getFilterCount() {
    int filterCount = 0;

    if (selectedFilterOptions.priceDcs.isNotEmpty) {
      filterCount++;
    }

    if (selectedFilterOptions.airlineDcs.isNotEmpty) {
      filterCount++;
    }

    if (selectedFilterOptions.departureTimeDcs.isNotEmpty) {
      filterCount++;
    }

    if (selectedFilterOptions.arrivalTimeDcs.isNotEmpty) {
      filterCount++;
    }
    if (selectedFilterOptions.stopDcs.isNotEmpty) {
      filterCount++;
    }
    return filterCount;
  }

  void clearFilter() {
    widget.filterSubmitted(FlightSearchResult(
        pageSize: 0,
        totalFlights: 0,
        alertMsg: "",
        searchResponses: [],
        priceDcs: [],
        sortingDcs: [],
        airlineDcs: [],
        departureTimeDcs: [],
        arrivalTimeDcs: [],
        stopDcs: []));
  }

  num getPriceRangeDivision() {
    return (widget.availableFilterOptions
        .priceDcs[0].max - widget.availableFilterOptions
        .priceDcs[0].min)/5;
  }
}
