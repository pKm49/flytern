import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/flight_search_item.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_booking_form.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_search_result_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_type_tab.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
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

  late TabController tabController;
  bool isModifySearchVisible = false;
  int selectedTab = 1;
  int multicityCount = 1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("search_results".tr),
        actions: [
          InkWell(
              onTap: () {
                setState(() {
                  isModifySearchVisible = !isModifySearchVisible;
                });
              },
              child: Icon(Ionicons.create_outline)),
          addHorizontalSpace(flyternSpaceMedium),
        ],
      ),
      body: Container(
        width: screenwidth,
        height: screenheight,
        child: Column(
          children: [
            addVerticalSpace(flyternSpaceMedium),
            Visibility(
              visible: !isModifySearchVisible,
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
                visible: !isModifySearchVisible,
                child: addVerticalSpace(flyternSpaceSmall)),
            Visibility(visible: !isModifySearchVisible, child: Divider()),
            Visibility(
                visible: !isModifySearchVisible,
                child: addVerticalSpace(flyternSpaceExtraSmall)),
            Container(
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
                              visible: flightBookingController.sortingDcs.value.isNotEmpty &&
                                  flightBookingController.sortingDc.value.value !="-1",
                              child: Padding(
                                padding: const EdgeInsets.only(top:flyternSpaceExtraSmall),
                                child: Text( flightBookingController.sortingDc.value.name,
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
                            Text("all".tr,
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
            addVerticalSpace(flyternSpaceExtraSmall),
            Divider(),
            Container(
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
                          text: getLargeFormattedDate(flightBookingController
                              .flightSearchData
                              .value
                              .searchList[0]
                              .departureDate
                              .add(Duration(days: i))),
                        ),
                    ])),

            // addVerticalSpace(flyternSpaceLarge),
            // Visibility(
            //     visible: isModifySearchVisible,
            //     child: Padding(
            //       padding: flyternLargePaddingHorizontal,
            //       child: Text("modify_search".tr,
            //           style: getHeadlineMediumStyle(context).copyWith(
            //               fontWeight: flyternFontWeightBold,
            //               color: flyternGrey80)),
            //     )),
            // Visibility(
            //   visible: isModifySearchVisible,
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
            Expanded(
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
                                flightSearchResponse: flightBookingController
                                    .flightSearchResponses[index],
                                onPressed: () {
                                  Get.toNamed(Approute_flightsDetails);
                                },
                              ));
                        })))
          ],
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
            title: "sort_by".tr,
            values: ["airline".tr, "price".tr],
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
            return FilterOptionSelector(
                bookingServiceNumber: 1,
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
}
