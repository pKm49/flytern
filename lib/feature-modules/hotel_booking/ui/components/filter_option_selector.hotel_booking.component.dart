import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/hotel_booking/constants/filter_options.hotel_booking.constant.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_result.hotel_booking.model.dart';
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

class HotelFilterOptionSelector extends StatefulWidget {
  String currency;
  HotelSearchResult availableFilterOptions;
  HotelSearchResult selectedFilterOptions;

  final GestureTapCallback setModalState;
  final Function(HotelSearchResult selectedFilterOptions)
      filterSubmitted; // <------------|

  HotelFilterOptionSelector(
      {super.key,
      required this.availableFilterOptions,
      required this.currency,
      required this.selectedFilterOptions,
      required this.filterSubmitted,
      required this.setModalState});

  @override
  State<HotelFilterOptionSelector> createState() =>
      _HotelFilterOptionSelectorState();
}

class _HotelFilterOptionSelectorState extends State<HotelFilterOptionSelector> {
  late HotelSearchResult selectedFilterOptions;
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
                      Visibility(
                        visible: getFilterCount() > 0,
                        child: Padding(
                          padding: flyternLargePaddingAll.copyWith(
                              top: 0,
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
                        visible: widget
                            .availableFilterOptions.locationDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.locationDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium,
                              bottom: flyternSpaceSmall),
                          child: Text("location".tr,
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
                      //         Text(widget.availableFilterOptions.locationDcs[i].name,
                      //             style: getBodyMediumStyle(context) ),
                      //         Checkbox(
                      //           checkColor: Colors.white,
                      //           fillColor: MaterialStateProperty.resolveWith(elementStyleHelpers.getColor),
                      //           value: isAirlineSelected(widget.availableFilterOptions.locationDcs[i]),
                      //           onChanged: (bool? value) {
                      //              manageAirlineSelection(widget.availableFilterOptions.locationDcs[i]);
                      //           },
                      //         ),
                      //       ],
                      //     )),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.ratingDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for (var i = 0;
                                  i <
                                      (widget.availableFilterOptions.locationDcs
                                              .isNotEmpty
                                          ? widget.availableFilterOptions
                                              .locationDcs.length
                                          : 0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: flyternSpaceSmall,
                                      bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed: () {
                                      manageSelection(
                                          HotelFilterOptions.LOCATION,
                                          selectedFilterOptions.locationDcs,
                                          widget.availableFilterOptions
                                              .locationDcs[i]);
                                    },
                                    label:
                                        '${widget.availableFilterOptions.locationDcs[i].name}',
                                    isSelected: isItemSelected(
                                        selectedFilterOptions.locationDcs,
                                        widget.availableFilterOptions
                                            .locationDcs[i]),
                                    themeNumber: 2,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      //  Departure Time
                      Visibility(
                        visible:
                            widget.availableFilterOptions.ratingDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.ratingDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium),
                          child: Text("rating".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.ratingDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for (var i = 0;
                                  i <
                                      (widget.availableFilterOptions.ratingDcs
                                              .isNotEmpty
                                          ? widget.availableFilterOptions
                                              .ratingDcs.length
                                          : 0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: flyternSpaceSmall,
                                      bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed: () {
                                      manageSelection(
                                          HotelFilterOptions.RATING,
                                          selectedFilterOptions.ratingDcs,
                                          widget.availableFilterOptions
                                              .ratingDcs[i]);
                                    },
                                    label:
                                        '${widget.availableFilterOptions.ratingDcs[i].name}',
                                    isSelected: isItemSelected(
                                        selectedFilterOptions.ratingDcs,
                                        widget.availableFilterOptions
                                            .ratingDcs[i]),
                                    themeNumber: 2,
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

  manageSelection(HotelFilterOptions filterOption, List<SortingDcs> sortingDcs,
      SortingDcs item) {
    isItemSelected(sortingDcs, item)
        ? removeSelection(filterOption, item)
        : addSelection(filterOption, item);
  }

  removeSelection(HotelFilterOptions filterOption, SortingDcs item) {
    List<SortingDcs> tempItems = [];

    switch (filterOption) {
      case HotelFilterOptions.PRICERANGE:
        {
          break;
        }

      case HotelFilterOptions.RATING:
        {
          tempItems = selectedFilterOptions.ratingDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }

      case HotelFilterOptions.LOCATION:
        {
          tempItems = selectedFilterOptions.locationDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
    }
  }

  addSelection(HotelFilterOptions filterOption, SortingDcs item) {
    List<SortingDcs> tempItems = [];

    switch (filterOption) {
      case HotelFilterOptions.LOCATION:
        {
          tempItems = selectedFilterOptions.locationDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case HotelFilterOptions.RATING:
        {
          tempItems = selectedFilterOptions.ratingDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case HotelFilterOptions.PRICERANGE:
        {
          break;
        }
    }
  }

  setSelectedFilterOptions(
      HotelFilterOptions filterOption, List<SortingDcs> items) {
    selectedFilterOptions = HotelSearchResult(
        objectID: -1,
        searchResponses: [],
        priceDcs: selectedFilterOptions.priceDcs,
        sortingDcs: selectedFilterOptions.sortingDcs,
        locationDcs: filterOption == HotelFilterOptions.LOCATION
            ? items
            : selectedFilterOptions.locationDcs,
        ratingDcs: filterOption == HotelFilterOptions.RATING
            ? items
            : selectedFilterOptions.ratingDcs);

    setState(() {});
    widget.setModalState();
  }

  setPriceRange(RangeValues rangeValues) {
    List<RangeDcs> priceRange = [];

    priceRange.add(RangeDcs(min: rangeValues.start, max: rangeValues.end));

    selectedFilterOptions = HotelSearchResult(
        objectID: -1,
        searchResponses: [],
        priceDcs: priceRange,
        sortingDcs: selectedFilterOptions.sortingDcs,
        locationDcs: selectedFilterOptions.locationDcs,
        ratingDcs: selectedFilterOptions.ratingDcs);
    print("setPriceRange");
    print(selectedFilterOptions.priceDcs[0].min);
    print(selectedFilterOptions.priceDcs[0].max);
    _currentSliderValue = rangeValues;
    setState(() {});
    widget.setModalState();
  }

  int getFilterCount() {
    int filterCount = 0;

    if (selectedFilterOptions.priceDcs.isNotEmpty) {
      filterCount++;
    }

    if (selectedFilterOptions.locationDcs.isNotEmpty) {
      filterCount++;
    }

    if (selectedFilterOptions.ratingDcs.isNotEmpty) {
      filterCount++;
    }

    return filterCount;
  }

  void clearFilter() {
    widget.filterSubmitted(HotelSearchResult(
        searchResponses: [],
        priceDcs: [],
        sortingDcs: [],
        locationDcs: [],
        ratingDcs: [],
        objectID: -1));
  }
}
