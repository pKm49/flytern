import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking.controller.dart';
import 'package:flytern/feature-modules/flight_booking/constants/flight_mode.flight_booking.constant.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_item.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/models/search_result.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/services/helper.flight_booking.service.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/booking_form.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/filter_option_selector.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/search_result_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/search_result_card_loader.flight_booking.component.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_type_tab.flight_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/data_capsule_card.shared.component.dart';
import 'package:flytern/shared-module/ui/components/sort_option_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FlightSearchResultPage extends StatefulWidget {
  const FlightSearchResultPage({super.key});

  @override
  State<FlightSearchResultPage> createState() => _FlightSearchResultPageState();
}

class _FlightSearchResultPageState extends State<FlightSearchResultPage>
    with SingleTickerProviderStateMixin {
  final flightBookingController = Get.find<FlightBookingController>();
  var flightBookingHelperServices = FlightBookingHelperServices();
  final ScrollController _controller = ScrollController();

  late TabController tabController;

  int selectedTab = -1;
  int multicityCount = 1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);

    tabController.addListener(() {

      if (selectedTab != tabController.index) {
        changeDate(tabController.index);
        selectedTab = tabController.index;
        setState(() {});
      }
    });

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {

        } else {

          flightBookingController.getFlightSearchResultsNextPage();
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
    _controller.dispose();

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
                    padding: flyternMediumPaddingHorizontal,
                    child: Wrap(
                      children: [
                        for(var i=1;i<5;i++)
                          Container(
                            padding: flyternSmallPaddingHorizontal.copyWith(
                                top: flyternSpaceExtraSmall,
                                bottom: flyternSpaceExtraSmall),
                            margin: EdgeInsets.only(bottom: flyternSpaceSmall,right: flyternSpaceSmall),
                            decoration: BoxDecoration(
                              color: flyternSecondaryColorBg,
                              borderRadius: BorderRadius.circular(flyternBorderRadiusExtraSmall),
                            ),
                            child: Text(
                              getSearchParamsPreview(i),style: getLabelLargeStyle(context).copyWith(
                            fontSize: flyternFontSize12,
                                color:flyternSecondaryColor,
                            ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible:!flightBookingController.isModifySearchVisible.value &&
                        !flightBookingController
                            .isFlightSearchFilterResponsesLoading.value ,
                    child: Divider()),
                Visibility(
                    visible:
                        !flightBookingController.isModifySearchVisible.value,
                    child: addVerticalSpace(flyternSpaceExtraSmall)),
                Visibility(
                  visible:
                      !flightBookingController
                          .isFlightSearchFilterResponsesLoading.value &&

                          (flightBookingController.sortingDcs.isNotEmpty ||
                          isFilterOptionsNotEmpty()) &&
                      !flightBookingController.isModifySearchVisible.value,
                  child: Container(
                    padding: flyternLargePaddingHorizontal,
                    child: Row(
                      children: [
                        Visibility(
                          visible: flightBookingController.sortingDcs.isNotEmpty,
                          child: Expanded(
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
                        ),
                        Visibility(
                            visible: flightBookingController.sortingDcs.isNotEmpty &&
                                isFilterOptionsNotEmpty(),
                            child: addHorizontalSpace(flyternSpaceLarge * 1.5)),
                        Visibility(
                          visible:
                              isFilterOptionsNotEmpty(),
                          child: Expanded(
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
                          )),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: !flightBookingController
                        .isFlightSearchFilterResponsesLoading.value &&
                        (flightBookingController.sortingDcs.isNotEmpty ||
                            isFilterOptionsNotEmpty()) &&
                        !flightBookingController.isModifySearchVisible.value,
                    child: addVerticalSpace(flyternSpaceExtraSmall)),
                Visibility(
                    visible:
                        !flightBookingController
                            .isFlightSearchFilterResponsesLoading.value &&
                            (flightBookingController.sortingDcs.isNotEmpty ||
                                isFilterOptionsNotEmpty()) &&
                        !flightBookingController.isModifySearchVisible.value,
                    child: Divider()),
                Visibility(
                  visible:
                      !flightBookingController
                          .isFlightSearchFilterResponsesLoading.value &&
                      !flightBookingController.isModifySearchVisible.value,
                  child: Container(
                      padding: flyternMediumPaddingHorizontal,
                      decoration:
                          BoxDecoration(border: flyternDefaultBorderBottomOnly),
                      child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.zero,
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
                Visibility(
                  visible:
                      !flightBookingController
                              .isFlightSearchResponsesLoading.value &&
                          !flightBookingController
                              .isFlightSearchFilterResponsesLoading.value &&
                          !flightBookingController.flightSearchResponses.value.isEmpty &&
                          !flightBookingController.isModifySearchVisible.value,
                  child: Expanded(
                      child: Container(
                          color: flyternGrey10,
                          child: ListView.builder(
                             controller: _controller,
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
                    visible: flightBookingController.isFlightSearchPageResponsesLoading.value,
                    child: Container(
                      width: screenwidth,
                      color: flyternGrey10,
                      child: Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                            color: flyternSecondaryColor,
                            size: 50,
                          )),
                    )),
                Visibility(
                  visible:
                  !flightBookingController.isFlightSearchResponsesLoading.value &&
                      !flightBookingController
                          .isFlightSearchFilterResponsesLoading.value &&
                      !flightBookingController.isModifySearchVisible.value&&
                      flightBookingController.flightSearchResponses.value.isEmpty ,
                  child: Expanded(
                    child: Container(
                      width: screenwidth, 
                      color: flyternGrey10,
                      child: Center(
                        child: Container(
                          padding: flyternMediumPaddingAll,
                          margin: flyternLargePaddingAll.copyWith(bottom: flyternSpaceMedium),
                          decoration: BoxDecoration(
                            color: flyternPrimaryColorBg,
                            borderRadius: BorderRadius.circular(
                                flyternBorderRadiusExtraSmall),
                          ),
                          child: Html(
                            data:getNoItemMessage(),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(flyternSpaceLarge),
                          // height: flightBookingHelperServices
                          //     .getFlightBookingContainerHeight(
                          //         screenheight, flightBookingController),
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
                                    // height: flightBookingHelperServices
                                    //         .getFlightBookingContainerHeight(
                                    //             screenheight,
                                    //             flightBookingController) -
                                    //     (screenheight * .025) -
                                    //     (flyternSpaceLarge * 2),
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
                                    // height: flightBookingHelperServices
                                    //         .getFlightBookingContainerHeight(
                                    //             screenheight,
                                    //             flightBookingController) -
                                    //     (screenheight * .05) -
                                    //     (flyternSpaceLarge * 2),
                                    width: screenwidth - (flyternSpaceLarge * 2),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: !flightBookingController.isModifySearchVisible.value,
                  child: Container(
                    height: flyternSpaceLarge,
                    width: screenwidth,
                    color: flyternGrey10,
                  ),
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

                  flightBookingController
                      .setFilterValues(selectedFilterOptions);
                  Navigator.pop(context);
                },
                setModalState: () {
                   setModalState(() {});
                });
          });
        });
  }

  String getSearchParamsPreview(int index) {
    String searchParamsPreviewString = "";

    if(index ==1){
      if (flightBookingController.flightSearchData.value.searchList.isNotEmpty) {
        flightBookingController.flightSearchData.value.searchList
            .forEach((element) {
          searchParamsPreviewString +=
          "${element.departure.airportCode}-${element.arrival.airportCode}";
        });
        return searchParamsPreviewString;
      }
    }
    searchParamsPreviewString = "";
    if(index == 2){
      if (flightBookingController.flightSearchData.value.searchList.isNotEmpty) {
        flightBookingController.flightSearchData.value.searchList
            .forEach((element) {
          searchParamsPreviewString +=
          "${getDateString(element)} ";
        });
        return searchParamsPreviewString;
      }
    }

    if(index == 3){
      return "${flightBookingController.flightSearchData.value.mode.name}";
    }
    searchParamsPreviewString = "";
    if(index == 4){
      if (flightBookingController.flightSearchData.value.adults > 0) {
        searchParamsPreviewString +=
        "${flightBookingController.flightSearchData.value.adults} ${'adults'.tr}";
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

    return searchParamsPreviewString = "";

  }

  String getLargeFormattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    final f = DateFormat('E, dd-MMM');
    return f.format(dateTime);
  }

  String getFormattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    }
    final f = DateFormat('dd-MMM');
    return f.format(dateTime);
  }

  getDateString(FlightSearchItem element) {
    if (element.returnDate == null) {
      return "${getFormattedDate(element.departureDate)}";
    }

    if (element.returnDate?.year == element.departureDate.year) {

      if (element.returnDate?.month == element.departureDate.month) {
        if (element.returnDate?.day == element.departureDate.day) {
          return "${getFormattedDate(element.departureDate)}";
        }
         return "${element.departureDate.day} & ${getFormattedDate(element.returnDate)}";
      }

      return "${getFormattedDate(element.departureDate)} & ${getFormattedDate(element.returnDate)}";

    }else{

      if (element.returnDate?.month == element.departureDate.month) {
        if (element.returnDate?.day == element.departureDate.day) {
          return "${getFormattedDate(element.departureDate)}";
        }
        return "${element.departureDate.day} & ${getFormattedDate(element.returnDate)}";
      }

      return "${getFormattedDate(element.departureDate)} & ${getFormattedDate(element.returnDate)}";

    }


  }

  FlightSearchResult getAvailableFilterOptions() {
    return FlightSearchResult(
      pageSize: 0,
      alertMsg: "",
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
      pageSize: 0,
      alertMsg: "",
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

  String getNoItemMessage() {
    if(flightBookingController.alertMsg.value !=""){
      return flightBookingController.alertMsg.value;
    }else{
      return "no_item".tr;
    }
  }

  bool isFilterOptionsNotEmpty() {
    return flightBookingController.airlineDcs.isNotEmpty ||
        flightBookingController.priceDcs.isNotEmpty||
        flightBookingController.departureTimeDcs.isNotEmpty||
        flightBookingController.stopDcs.isNotEmpty||
        flightBookingController.arrivalTimeDcs.isNotEmpty;
  }
}
