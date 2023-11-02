import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/constants/business_specific/flight_mode.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_result.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper-services/flight_booking_helper_services.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_form.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_filter_option_selector.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card_loader.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_type_tab.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/filter_option_selector.dart';
import 'package:flytern/shared/ui/components/sort_option_selector.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class FlightSearchResultPage extends StatefulWidget {
  const FlightSearchResultPage({super.key});

  @override
  State<FlightSearchResultPage> createState() => _FlightSearchResultPageState();
}

class _FlightSearchResultPageState extends State<FlightSearchResultPage>
    with SingleTickerProviderStateMixin {
  final flightBookingController = Get.find<FlightBookingController>();
  var flightBookingHelperServices = FlightBookingHelperServices();

  late TabController tabController;

  int selectedTab = -1;
  int multicityCount = 1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);

    tabController.addListener(() {
      print("addListener called");
      if (selectedTab != tabController.index) {
        changeDate(tabController.index);
        selectedTab = tabController.index;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
          () =>  Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text(flightBookingController.isModifySearchVisible.value
              ? "modify_search".tr
              : "search_results".tr),
          actions: [
            InkWell(
                onTap: () {
                  flightBookingController.toggleModifierVisibility();
                },
                child: flightBookingController.isModifySearchVisible.value
                    ? Center(
                        child: Text("cancel".tr,
                            style: getBodyMediumStyle(context).copyWith(
                                color: flyternSecondaryColor,
                                fontWeight: flyternFontWeightBold)),
                      )
                    : Icon(Ionicons.create_outline)),
            addHorizontalSpace(flyternSpaceMedium),
          ],
        ),
        body: Container(
            width: screenwidth,
            height: screenheight,
            child: Column(
              children: [
                Visibility(
                    visible: !flightBookingController.isModifySearchVisible.value,
                    child: addVerticalSpace(flyternSpaceMedium)),
                Visibility(
                  visible: !flightBookingController.isModifySearchVisible.value,
                  child: Container(
                    width: screenwidth,
                    padding: flyternLargePaddingHorizontal,
                    child: Text(getSearchParamsPreview(),
                        textAlign: TextAlign.start,
                        style: getLabelLargeStyle(context).copyWith(
                            fontWeight: flyternFontWeightLight,
                            color: flyternGrey60)),
                  ),
                ),
                Visibility(
                    visible: !flightBookingController.isModifySearchVisible.value,
                    child: addVerticalSpace(flyternSpaceSmall)),
                Visibility(
                    visible: !flightBookingController.isModifySearchVisible.value,
                    child: Divider()),
                Visibility(
                    visible: !flightBookingController.isModifySearchVisible.value,
                    child: addVerticalSpace(flyternSpaceExtraSmall)),
                Visibility(
                  visible: !flightBookingController.isModifySearchVisible.value,
                  child: Container(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            showSortOptions();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("sort".tr,
                                      style: getLabelLargeStyle(context).copyWith(
                                          fontWeight: flyternFontWeightLight,
                                          color: flyternGrey60)),
                                  Visibility(
                                    visible: flightBookingController
                                            .sortingDcs.value.isNotEmpty &&
                                        flightBookingController
                                                .sortingDc.value.value !=
                                            "-1",
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: flyternSpaceExtraSmall),
                                      child: Text(
                                          flightBookingController
                                              .sortingDc.value.name,
                                          style: getBodyMediumStyle(context)
                                              .copyWith(color: flyternGrey80)),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Ionicons.chevron_down,
                                  size: flyternFontSize20, color: flyternGrey40)
                            ],
                          ),
                        )),
                        addHorizontalSpace(flyternSpaceLarge * 1.5),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            showFilterOptions();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("filter".tr,
                                      style: getLabelLargeStyle(context).copyWith(
                                          fontWeight: flyternFontWeightLight,
                                          color: flyternGrey60)),
                                  addVerticalSpace(flyternSpaceExtraSmall),
                                  Text(getFilterTitle(),
                                      style: getBodyMediumStyle(context)
                                          .copyWith(color: flyternGrey80)),
                                ],
                              ),
                              Icon(Ionicons.chevron_down,
                                  size: flyternFontSize20, color: flyternGrey40)
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: !flightBookingController.isModifySearchVisible.value,
                    child: addVerticalSpace(flyternSpaceExtraSmall)),
                Visibility(
                    visible: !flightBookingController.isModifySearchVisible.value,
                    child: Divider()),
                Visibility(
                  visible: !flightBookingController.isModifySearchVisible.value,
                  child: Container(
                      padding: flyternMediumPaddingHorizontal,
                      decoration:
                          BoxDecoration(border: flyternDefaultBorderBottomOnly),
                      child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.zero,
                          // indicator: new BubbleTabIndicator(
                          //   indicatorHeight: 30.0,
                          //   indicatorColor: AppColors.PrimaryColor,
                          //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          // ),
                          indicatorColor: flyternSecondaryColor,
                          indicatorWeight: 2,
                          padding: EdgeInsets.zero,
                          controller: tabController,
                          labelColor: flyternSecondaryColor,
                          labelStyle: TextStyle(
                              color: flyternSecondaryColor,
                              fontWeight: FontWeight.bold),
                          unselectedLabelColor: flyternGrey40,
                          tabs: <Tab>[
                            for (var i = 0; i < 3; i++)
                              Tab(
                                text: getLargeFormattedDate(
                                    flightBookingController.startDate.value
                                        .add(Duration(days: i))),
                              ),
                          ])),
                ),

                // addVerticalSpace(flyternSpaceLarge),
                // Visibility(
                //     visible: flightBookingController.isModifySearchVisible.value,
                //     child: Padding(
                //       padding: flyternLargePaddingHorizontal,
                //       child: Text("modify_search".tr,
                //           style: getHeadlineMediumStyle(context).copyWith(
                //               fontWeight: flyternFontWeightBold,
                //               color: flyternGrey80)),
                //     )),
                // Visibility(
                //   visible: flightBookingController.isModifySearchVisible.value,
                //   child: Container(
                //     height: (screenheight * .65),
                //     width: screenwidth - (flyternSpaceLarge * 2),
                //     padding: flyternMediumPaddingAll,
                //     decoration: flyternShadowedContainerSmallDecoration,
                //     margin: flyternLargePaddingAll,
                //     child: FlightBookingForm(
                //       flightBookingController: flightBookingController,
                //     ),
                //   ),
                // ),
                Visibility(
                  visible:
                      !flightBookingController
                              .isFlightSearchResponsesLoading.value &&
                          !flightBookingController
                              .isFlightSearchFilterResponsesLoading.value &&
                          !flightBookingController.isModifySearchVisible.value,
                  child: Expanded(
                      child: Container(
                          color: flyternGrey10,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: flightBookingController
                                  .flightSearchResponses.length,
                              itemBuilder: (BuildContext context, int index) {

                                return Container(
                                    margin: const EdgeInsets.only(
                                        top: flyternSpaceMedium),
                                    child: FlightSearchResultCard(
                                      flightBookingController:flightBookingController ,
                                      onMoreOptionsPressed: () {
                                        flightBookingController.getMoreOptions(
                                            flightBookingController
                                                .flightSearchResponses.value[index]
                                                .index);
                                      },
                                      flightSearchResponse:
                                          flightBookingController
                                              .flightSearchResponses.value[index],
                                      onPressed: () {
                                        flightBookingController.getFlightDetails(flightBookingController
                                            .flightSearchResponses.value[index]
                                            .index);
                                      },
                                    ));
                              }))),
                ),
                Visibility(
                  visible: (flightBookingController
                              .isFlightSearchResponsesLoading.value ||
                          flightBookingController
                              .isFlightSearchFilterResponsesLoading.value) &&
                      !flightBookingController.isModifySearchVisible.value,
                  child: Expanded(
                      child: Container(
                          color: flyternGrey10,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: const EdgeInsets.only(
                                        top: flyternSpaceMedium),
                                    child: FlightSearchResultCardLoader());
                              }))),
                ),
                Visibility(
                  visible: flightBookingController.isModifySearchVisible.value,
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.all(flyternSpaceLarge),
                      height: flightBookingHelperServices
                          .getFlightBookingContainerHeight(
                              screenheight, flightBookingController),
                      width: screenwidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(ASSETS_FLIGHTS_BG),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: screenheight * .025,
                                width: screenwidth,
                              ),
                              Container(
                                height: flightBookingHelperServices
                                        .getFlightBookingContainerHeight(
                                            screenheight,
                                            flightBookingController) -
                                    (screenheight * .025) -
                                    (flyternSpaceLarge * 2),
                                decoration:
                                    flyternShadowedContainerSmallDecoration,
                                width: screenwidth - (flyternSpaceLarge * 2),
                                padding: flyternMediumPaddingAll,
                                child: Container(
                                  margin: EdgeInsets.only(top: flyternSpaceLarge),
                                  child: FlightBookingForm(
                                    isRedirectionRequired: false,
                                    flightBookingController:
                                        flightBookingController,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  height: screenheight * .05,
                                  width: screenwidth - (flyternSpaceLarge * 2),
                                  padding: flyternMediumPaddingHorizontal,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: FlightTypeTab(
                                          onPressed: () {
                                            flightBookingController
                                                .setFlightMode(FlightMode.ONEWAY);
                                          },
                                          icon: Ionicons.arrow_forward_outline,
                                          label: 'one_way'.tr,
                                          isSelected: flightBookingController
                                                  .flightSearchData.value.mode ==
                                              FlightMode.ONEWAY,
                                        ),
                                      ),
                                      addHorizontalSpace(flyternSpaceSmall),
                                      Expanded(
                                        child: FlightTypeTab(
                                          onPressed: () {
                                            flightBookingController.setFlightMode(
                                                FlightMode.ROUNDTRIP);
                                          },
                                          icon: Ionicons.swap_horizontal_outline,
                                          label: 'round_trip'.tr,
                                          isSelected: flightBookingController
                                                  .flightSearchData.value.mode ==
                                              FlightMode.ROUNDTRIP,
                                        ),
                                      ),
                                      addHorizontalSpace(flyternSpaceSmall),
                                      Expanded(
                                        child: FlightTypeTab(
                                          onPressed: () {
                                            flightBookingController.setFlightMode(
                                                FlightMode.MULTICITY);
                                          },
                                          icon: Ionicons.share_social_outline,
                                          label: 'multi_city'.tr,
                                          isSelected: flightBookingController
                                                  .flightSearchData.value.mode ==
                                              FlightMode.MULTICITY,
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                height: flightBookingHelperServices
                                        .getFlightBookingContainerHeight(
                                            screenheight,
                                            flightBookingController) -
                                    (screenheight * .05) -
                                    (flyternSpaceLarge * 2),
                                width: screenwidth - (flyternSpaceLarge * 2),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: flyternSpaceLarge,
                  width: screenwidth,
                  color: flyternGrey10,
                )
              ],
            ),
          ),

      ),
    );
  }

  void showSortOptions() {
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
          return SortOptionSelector(
            selectedSort: flightBookingController.sortingDc.value.value,
            sortChanged: (String selectedSort) {
              flightBookingController.updateSort(selectedSort);
              Navigator.pop(context);
            },
            title: "sort_by".tr,
            sortingDcs: flightBookingController.sortingDcs.value,
          );
        });
  }

  void showFilterOptions() {
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
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setModalState /*You can rename this!*/) {
            return FlightFilterOptionSelector(
                currency: flightBookingController.currency.value,
                availableFilterOptions: getAvailableFilterOptions(),
                selectedFilterOptions: getSelectedFilterOptions(),
                filterSubmitted: (FlightSearchResult selectedFilterOptions) {
                  print("setPriceRange 2");
                  print(selectedFilterOptions.priceDcs[0].min);
                  print(selectedFilterOptions.priceDcs[0].max);
                  flightBookingController
                      .setFilterValues(selectedFilterOptions);
                  Navigator.pop(context);
                },
                setModalState: () {
                  print('modalState Changed');
                  setModalState(() {});
                });
          });
        });
  }

  String getSearchParamsPreview() {
    String searchParamsPreviewString = "";

    if (flightBookingController.flightSearchData.value.searchList.isNotEmpty) {
      flightBookingController.flightSearchData.value.searchList
          .forEach((element) {
        searchParamsPreviewString +=
            "${element.departure.airportCode}-${element.arrival.airportCode}${getDateString(element)} -";
      });
    }
    searchParamsPreviewString +=
        " ${flightBookingController.flightSearchData.value.mode.name}";

    if (flightBookingController.flightSearchData.value.adults > 0) {
      searchParamsPreviewString +=
          " -${flightBookingController.flightSearchData.value.adults} ${'adults'.tr}";
    }

    if (flightBookingController.flightSearchData.value.child > 0) {
      searchParamsPreviewString +=
          " -${flightBookingController.flightSearchData.value.child} ${'children'.tr}";
    }

    if (flightBookingController.flightSearchData.value.infants > 0) {
      searchParamsPreviewString +=
          " -${flightBookingController.flightSearchData.value.infants} ${'infants'.tr}";
    }
    return searchParamsPreviewString;
  }

  String getLargeFormattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    final f = DateFormat('E, dd-MMM yy');
    return f.format(dateTime);
  }

  String getFormattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    final f = DateFormat('dd-MMM-yy');
    return f.format(dateTime);
  }

  getDateString(FlightSearchItem element) {
    if (element.returnDate == null) {
      return "  ${getFormattedDate(element.departureDate)}";
    }
    if (element.returnDate?.day == element.departureDate.day) {
      return "  ${getFormattedDate(element.departureDate)}";
    }
    return " ${element.departureDate.day}-${getFormattedDate(element.returnDate)}";
  }

  FlightSearchResult getAvailableFilterOptions() {
    return FlightSearchResult(
      searchResponses: [],
      priceDcs: flightBookingController.priceDcs.value,
      sortingDcs: [],
      airlineDcs: flightBookingController.airlineDcs.value,
      departureTimeDcs: flightBookingController.departureTimeDcs.value,
      arrivalTimeDcs: flightBookingController.arrivalTimeDcs.value,
      stopDcs: flightBookingController.stopDcs.value,
    );
  }

  FlightSearchResult getSelectedFilterOptions() {
    return FlightSearchResult(
      searchResponses: [],
      priceDcs: flightBookingController.selectedPriceDcs.value,
      sortingDcs: [],
      airlineDcs: flightBookingController.selectedAirlineDcs.value,
      departureTimeDcs: flightBookingController.selectedDepartureTimeDcs.value,
      arrivalTimeDcs: flightBookingController.selectedArrivalTimeDcs.value,
      stopDcs: flightBookingController.selectedStopDcs.value,
    );
  }

  changeDate(int index) {
    print("changedate 1");
    print(index);

    flightBookingController.changeDate(
        0,
        false,
        flightBookingController.startDate.value.add(Duration(days: index)),
        true);
  }

  String getFilterTitle() {
    String filterTitleAll = "all".tr;
    int filterCount = 0;

    if (flightBookingController.selectedPriceDcs.isNotEmpty) {
      filterCount++;
    }

    if (flightBookingController.selectedAirlineDcs.isNotEmpty) {
      filterCount++;
    }

    if (flightBookingController.selectedDepartureTimeDcs.isNotEmpty) {
      filterCount++;
    }

    if (flightBookingController.selectedArrivalTimeDcs.isNotEmpty) {
      filterCount++;
    }
    if (flightBookingController.selectedStopDcs.isNotEmpty) {
      filterCount++;
    }
    if(filterCount>0){
      return "filter_items".tr.replaceAll("2", filterCount.toString());
    }else{
      return filterTitleAll;
    }
  }
}
