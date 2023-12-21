import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flytern/feature-modules/hotel_booking/controllers/hotel_booking.controller.dart';
import 'package:flytern/feature-modules/hotel_booking/models/search_result.hotel_booking.model.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/search_result_card.hotel_booking.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/card_loader.hotel_booking.component.dart';
import 'package:flytern/feature-modules/hotel_booking/ui/components/filter_option_selector.hotel_booking.component.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/services/utility-services/widget_properties_generator.shared.service.dart';
 import 'package:flytern/shared-module/ui/components/sort_option_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HotelSearchResultPage extends StatefulWidget {
  const HotelSearchResultPage({super.key});

  @override
  State<HotelSearchResultPage> createState() => _HotelSearchResultPageState();
}

class _HotelSearchResultPageState extends State<HotelSearchResultPage>
    with SingleTickerProviderStateMixin {
  final hotelBookingController = Get.find<HotelBookingController>();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (isTop) {

        } else {

          hotelBookingController.getHotelSearchResultsNextPage();
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text("search_results".tr),
      ),
      body: Obx(
        () => Stack(
          children: [
            Visibility(
              visible: (!hotelBookingController
                          .isHotelSearchResponsesLoading.value ||
                      !hotelBookingController
                          .isHotelSearchFilterResponsesLoading.value) &&
                  hotelBookingController.objectId.value != -1,
              child: Container(
                width: screenwidth,
                height: screenheight,
                child: Column(
                  children: [
                    Container(
                      width: screenwidth,
                      padding: flyternSmallPaddingVertical.copyWith(
                          left: flyternSpaceSmall,
                          right: flyternSpaceSmall,
                          bottom: 0),
                      decoration: BoxDecoration(
                        border: flyternDefaultBorderBottomOnly,
                        color: flyternBackgroundWhite,
                      ),
                      child: Wrap(
                        children: [
                          for (var i = 1; i < 6; i++)
                            Visibility(
                              visible:i==5?!hotelBookingController
                    .isHotelSearchResponsesLoading.value:true,
                              child: Container(
                                padding: flyternSmallPaddingHorizontal.copyWith(
                                    top: flyternSpaceExtraSmall,
                                    bottom: flyternSpaceExtraSmall),
                                margin: EdgeInsets.only(
                                    bottom: flyternSpaceSmall,
                                    right: flyternSpaceSmall),
                                decoration: BoxDecoration(
                                  color: flyternSecondaryColorBg,
                                  borderRadius: BorderRadius.circular(
                                      flyternBorderRadiusExtraSmall),
                                ),
                                child: Text(
                                  getSearchParamsPreview(i),
                                  style: getLabelLargeStyle(context).copyWith(
                                      color: flyternSecondaryColor,
                                      fontSize: flyternFontSize12),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    Visibility(
                      visible:  (hotelBookingController.sortingDcs.isNotEmpty ||
                          isFilterOptionsNotEmpty()),
                      child: Container(
                        padding: flyternMediumPaddingAll,
                        decoration:
                            BoxDecoration(border: flyternDefaultBorderBottomOnly),
                        child: Row(
                          children: [
                            Visibility(
                              visible: hotelBookingController.sortingDcs.isNotEmpty,
                              child: Expanded(
                                  child: InkWell(
                                onTap: () {
                                  showSortOptions();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("sort".tr,
                                              style: getLabelLargeStyle(context)
                                                  .copyWith(
                                                      fontWeight:
                                                          flyternFontWeightLight,
                                                      color: flyternGrey40)),
                                          addVerticalSpace(flyternSpaceExtraSmall),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(hotelBookingController
                                                .sortingDc.value.name,
                                                style: getLabelLargeStyle(context)
                                                    .copyWith(color: flyternGrey80)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(Ionicons.chevron_down,
                                        color: flyternGrey40)
                                  ],
                                ),
                              )),
                            ),
                            Visibility(
                                visible: hotelBookingController.sortingDcs.isNotEmpty &&
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
                                            style: getLabelLargeStyle(context)
                                                .copyWith(
                                                    fontWeight:
                                                        flyternFontWeightLight,
                                                    color: flyternGrey40)),
                                        addVerticalSpace(flyternSpaceExtraSmall),
                                        Text(getFilterTitle(),
                                            style: getLabelLargeStyle(context)
                                                .copyWith(color: flyternGrey80)),
                                      ],
                                    ),
                                    Icon(Ionicons.chevron_down,
                                        color: flyternGrey40)
                                  ],
                                ),
                              )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !hotelBookingController
                              .isHotelSearchFilterResponsesLoading.value &&
                          hotelBookingController
                              .hotelSearchResponses.isNotEmpty,
                      child: Expanded(
                          child: Container(
                        color: flyternBackgroundWhite,
                        child: ListView.builder(
                            controller: _controller,
                            itemCount: hotelBookingController
                                .hotelSearchResponses.length,
                            itemBuilder: (context, i) {
                              return Container(
                                  padding: flyternLargePaddingHorizontal,
                                  decoration: BoxDecoration(
                                      border: flyternDefaultBorderBottomOnly),
                                  child: HotelSearchResultCard(
                                    onPressed: () {
                                       hotelBookingController.getHotelDetails(
                                          hotelBookingController
                                              .hotelSearchResponses
                                              .value[i]
                                              .hotelId);
                                    },
                                    hotelSearchResponse: hotelBookingController
                                        .hotelSearchResponses.value[i],
                                  ));
                            }),
                      )),
                    ),
                    Visibility(
                        visible: hotelBookingController
                            .isHotelSearchPageResponsesLoading.value,
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
                      visible: hotelBookingController
                          .isHotelSearchFilterResponsesLoading.value,
                      child: Expanded(
                        child: Container(
                          width: screenwidth,
                          color: flyternGrey10,
                          child: HotelCardLoader(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !hotelBookingController
                              .isHotelSearchFilterResponsesLoading.value &&
                          hotelBookingController
                              .hotelSearchResponses.value.isEmpty &&
                          hotelBookingController.objectId.value != -1,
                      child: Expanded(
                        child: Container(
                          width: screenwidth,
                          color: flyternBackgroundWhite,
                          child: Center(
                            child:  Container(
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
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !hotelBookingController
                      .isHotelSearchResponsesLoading.value &&
                  hotelBookingController.hotelSearchResponses.value.isEmpty &&
                  hotelBookingController.objectId.value == -1,
              child: Container(
                width: screenwidth,
                height: screenheight,
                color: flyternGrey10,
                child: Center(
                  child:  Container(
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
            Visibility(
              visible:
                  hotelBookingController.isHotelSearchResponsesLoading.value &&
                      hotelBookingController.objectId.value == -1,
              child: Container(
                width: screenwidth,
                height: screenheight,
                color: flyternGrey10,
                child: HotelCardLoader(),
              ),
            )
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
            selectedSort: hotelBookingController.sortingDc.value.value,
            sortChanged: (String selectedSort) {
              hotelBookingController.updateSort(selectedSort);
              Navigator.pop(context);
            },
            title: "sort_by".tr,
            sortingDcs: hotelBookingController.sortingDcs.value,
          );
        });
  }

  String getSearchParamsPreview(int index) {
    String searchParamsPreviewString = "";

    if (index == 1) {
      if (hotelBookingController.hotelSearchData.value.destination != "") {
        searchParamsPreviewString +=
            "${hotelBookingController.selectedDestination.value.uniqueCombination},";
      }
      return searchParamsPreviewString;
    }

    searchParamsPreviewString = "";

    if (index == 2) {
      return " ${getLargeFormattedDate(hotelBookingController.hotelSearchData.value.checkInDate)}";
    }

    if (index == 3) {
      return "${"rooms_no".tr.replaceAll("2", hotelBookingController.hotelSearchData.value.rooms.length.toString())}";
    }

    if(index == 4){
        num durationDays = hotelBookingController.hotelSearchData.value.checkOutDate.difference(
            hotelBookingController.hotelSearchData.value.checkInDate
        ).inDays;
        if(durationDays == 1){
          return "single_night".tr;
        }
        return "night_count".tr.replaceAll("1", durationDays.toString());

    }
    if(index == 5){

      if(hotelBookingController.totalHotels.value < hotelBookingController.hotelSearchResponses.length){
        return "hotel_count".tr.replaceAll("1",hotelBookingController.hotelSearchResponses.length.toString());
      }

      if(hotelBookingController.totalHotels.value == 1){
        return "hotel_count_single".tr;
      }

      return "hotel_count".tr.replaceAll("1",hotelBookingController.totalHotels.value.toString());

    }

    return searchParamsPreviewString;
  }

  String getLargeFormattedDate(DateTime dateTime) {
    if (dateTime == null) {
      return "";
    }
    final f = DateFormat('dd-MMM yy');
    return f.format(dateTime);
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
            return HotelFilterOptionSelector(
                currency: hotelBookingController.priceUnit.value,
                availableFilterOptions: getAvailableFilterOptions(),
                selectedFilterOptions: getSelectedFilterOptions(),
                filterSubmitted: (HotelSearchResult selectedFilterOptions) {
                  hotelBookingController.setFilterValues(selectedFilterOptions);
                  Navigator.pop(context);
                },
                setModalState: () {

                  setModalState(() {});
                });
          });
        });
  }
  String getNoItemMessage() {
    if(hotelBookingController.alertMsg.value !=""){
      return hotelBookingController.alertMsg.value;
    }else{
      return "no_item".tr;
    }
  }

  HotelSearchResult getAvailableFilterOptions() {
    return HotelSearchResult(
        objectID: -1,
        alertMsg: "",
        totalHotels:0,
        searchResponses: [],
        priceDcs: hotelBookingController.priceDcs.value,
        sortingDcs: [],
        ratingDcs: hotelBookingController.ratingDcs.value,
        locationDcs: hotelBookingController.locationDcs.value);
  }

  HotelSearchResult getSelectedFilterOptions() {
    return HotelSearchResult(
        objectID: -1,
        alertMsg: "",
        totalHotels:0,
        searchResponses: [],
        priceDcs: hotelBookingController.selectedPriceDcs.value,
        sortingDcs: [],
        ratingDcs: hotelBookingController.selectedratingDcs.value,
        locationDcs: hotelBookingController.selectedlocationDcs.value);
  }

  String getFilterTitle() {
    String filterTitleAll = "all".tr;
    int filterCount = 0;

    if (hotelBookingController.selectedPriceDcs.isNotEmpty) {
      filterCount++;
    }

    if (hotelBookingController.selectedlocationDcs.isNotEmpty) {
      filterCount++;
    }

    if (hotelBookingController.selectedratingDcs.isNotEmpty) {
      filterCount++;
    }

    if (filterCount > 0) {
      return "filter_items".tr.replaceAll("2", filterCount.toString());
    } else {
      return filterTitleAll;
    }
  }

  bool isFilterOptionsNotEmpty() {
    return  
        hotelBookingController.priceDcs.isNotEmpty||
        hotelBookingController.locationDcs.isNotEmpty||
        hotelBookingController.ratingDcs.isNotEmpty ;
  }
}
