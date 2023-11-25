import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/constants/filter_options.activity_booking.constant.dart';
import 'package:flytern/feature-modules/activity_booking/models/response.activity_booking.model.dart';
  import 'package:flytern/shared-module/models/range_dcs.dart';
 import 'package:flytern/shared-module/models/sorting_dcs.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/element_style_helper.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/selectable_text_pill.shared.component.dart';
import 'package:get/get.dart';

class ActivityFilterOptionSelector extends StatefulWidget {
  String currency;
  ActivityResponse availableFilterOptions;
  ActivityResponse selectedFilterOptions;

  final GestureTapCallback setModalState;
  final Function(ActivityResponse selectedFilterOptions)
      filterSubmitted; // <------------|

  ActivityFilterOptionSelector(
      {super.key,
      required this.availableFilterOptions,
      required this.currency,
      required this.selectedFilterOptions,
      required this.filterSubmitted,
      required this.setModalState});

  @override
  State<ActivityFilterOptionSelector> createState() =>
      _ActivityFilterOptionSelectorState();
}

class _ActivityFilterOptionSelectorState
    extends State<ActivityFilterOptionSelector> {
  late ActivityResponse selectedFilterOptions;
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
                                      i += 30)
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
                                      30)
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
                            widget.availableFilterOptions.tourCategoryDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible:
                            widget.availableFilterOptions.tourCategoryDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium,
                              bottom: flyternSpaceSmall),
                          child: Text("categories".tr,
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
                      //         Text(widget.availableFilterOptions.tourCategoryDcs[i].name,
                      //             style: getBodyMediumStyle(context) ),
                      //         Checkbox(
                      //           checkColor: Colors.white,
                      //           fillColor: MaterialStateProperty.resolveWith(elementStyleHelpers.getColor),
                      //           value: isAirlineSelected(widget.availableFilterOptions.tourCategoryDcs[i]),
                      //           onChanged: (bool? value) {
                      //              manageAirlineSelection(widget.availableFilterOptions.tourCategoryDcs[i]);
                      //           },
                      //         ),
                      //       ],
                      //     )),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.bestDealsDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for (var i = 0;
                                  i <
                                      (widget.availableFilterOptions.tourCategoryDcs
                                              .isNotEmpty
                                          ? widget.availableFilterOptions
                                              .tourCategoryDcs.length
                                          : 0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: flyternSpaceSmall,
                                      bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed: () {
                                      manageSelection(
                                          ActivityFilterOptions.TOURCATEGORY,
                                          selectedFilterOptions.tourCategoryDcs,
                                          widget.availableFilterOptions
                                              .tourCategoryDcs[i]);
                                    },
                                    label:
                                        '${widget.availableFilterOptions.tourCategoryDcs[i].name}',
                                    isSelected: isItemSelected(
                                        selectedFilterOptions.tourCategoryDcs,
                                        widget.availableFilterOptions
                                            .tourCategoryDcs[i]),
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
                            .availableFilterOptions.bestDealsDcs.isNotEmpty,
                        child: const Padding(
                          padding: flyternLargePaddingHorizontal,
                          child: Divider(),
                        ),
                      ),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.bestDealsDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingHorizontal.copyWith(
                              top: flyternSpaceMedium),
                          child: Text("deals".tr,
                              style: getBodyMediumStyle(context)
                                  .copyWith(fontWeight: flyternFontWeightBold)),
                        ),
                      ),
                      Visibility(
                        visible: widget
                            .availableFilterOptions.bestDealsDcs.isNotEmpty,
                        child: Padding(
                          padding: flyternLargePaddingAll,
                          child: Wrap(
                            children: [
                              for (var i = 0;
                                  i <
                                      (widget.availableFilterOptions
                                              .bestDealsDcs.isNotEmpty
                                          ? widget.availableFilterOptions
                                              .bestDealsDcs.length
                                          : 0);
                                  i++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: flyternSpaceSmall,
                                      bottom: flyternSpaceSmall),
                                  child: SelectableTilePill(
                                    onPressed: () {
                                      manageSelection(
                                          ActivityFilterOptions.BESTDEAL,
                                          selectedFilterOptions
                                              .bestDealsDcs,
                                          widget.availableFilterOptions
                                              .bestDealsDcs[i]);
                                    },
                                    label:
                                        '${widget.availableFilterOptions.bestDealsDcs[i].name}',
                                    isSelected: isItemSelected(
                                        selectedFilterOptions.bestDealsDcs,
                                        widget.availableFilterOptions
                                            .bestDealsDcs[i]),
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

  manageSelection(ActivityFilterOptions filterOption, List<SortingDcs> sortingDcs,
      SortingDcs item) {
    isItemSelected(sortingDcs, item)
        ? removeSelection(filterOption, item)
        : addSelection(filterOption, item);
  }

  removeSelection(ActivityFilterOptions filterOption, SortingDcs item) {
    List<SortingDcs> tempItems = [];

    switch (filterOption) {
      case ActivityFilterOptions.TOURCATEGORY:
        {
          tempItems = selectedFilterOptions.tourCategoryDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case ActivityFilterOptions.BESTDEAL:
        {
          tempItems = selectedFilterOptions.bestDealsDcs
              .where((element) => element.value != item.value)
              .toList();
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case ActivityFilterOptions.PRICERANGE:
        {
          break;
        }
  
    }


  }

  addSelection(ActivityFilterOptions filterOption, SortingDcs item) {
    List<SortingDcs> tempItems = [];

    switch (filterOption) {
      case ActivityFilterOptions.TOURCATEGORY:
        {
          tempItems = selectedFilterOptions.tourCategoryDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case ActivityFilterOptions.BESTDEAL:
        {
          tempItems = selectedFilterOptions.bestDealsDcs;
          tempItems.add(item);
          setSelectedFilterOptions(filterOption, tempItems);
          break;
        }
      case ActivityFilterOptions.PRICERANGE:
        {
          break;
        }
 
    }
  }

  setSelectedFilterOptions(
      ActivityFilterOptions filterOption, List<SortingDcs> items) {
    selectedFilterOptions = ActivityResponse(
        activities: [],
        objectID: 1,
        priceDcs: selectedFilterOptions.priceDcs,
        sortingDcs: selectedFilterOptions.sortingDcs,
        tourCategoryDcs: filterOption == ActivityFilterOptions.TOURCATEGORY
            ? items
            : selectedFilterOptions.tourCategoryDcs,
        bestDealsDcs: filterOption == ActivityFilterOptions.BESTDEAL
            ? items
            : selectedFilterOptions.bestDealsDcs,
      );

    setState(() {});
    widget.setModalState();
  }

  setPriceRange(RangeValues rangeValues) {
    List<RangeDcs> priceRange = [];

    priceRange.add(RangeDcs(min: rangeValues.start, max: rangeValues.end));

    selectedFilterOptions = ActivityResponse(
        activities: [],
        priceDcs: priceRange,
        objectID: 1,
        sortingDcs: selectedFilterOptions.sortingDcs,
        tourCategoryDcs: selectedFilterOptions.tourCategoryDcs,
        bestDealsDcs: selectedFilterOptions.bestDealsDcs);
    print("setPriceRange");
    print(selectedFilterOptions.priceDcs[0].min);
    print(selectedFilterOptions.priceDcs[0].max);
    _currentSliderValue = rangeValues;
    setState(() {});
    widget.setModalState();
  }
}
