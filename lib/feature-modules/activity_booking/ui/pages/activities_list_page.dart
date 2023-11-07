import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking_controller.dart';
import 'package:flytern/feature-modules/activity_booking/data/models/activity_response.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_filter_option_selector.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card_loader.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/flight_filter_option_selector.dart';
import 'package:flytern/shared/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/services/utility-services/widget_properties_generator.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
import 'package:flytern/shared/ui/components/sort_option_selector.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ActivitiesListPage extends StatefulWidget {
  const ActivitiesListPage({super.key});

  @override
  State<ActivitiesListPage> createState() =>
      _ActivitiesListPageState();
}

class _ActivitiesListPageState extends State<ActivitiesListPage> {
  final activityBookingController = Get.put(ActivityBookingController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return  Obx(
          ()=> Scaffold(
        appBar: AppBar(
          title: Text("activities".tr +
              (activityBookingController.activities.isNotEmpty?
              " - ${activityBookingController.activities[0].cityName}"
                  :
              "activities".tr)),
        ),
        body: Container(
          width: screenwidth,
          height: screenheight * .9,
          color: flyternGrey10,
          child: Column(
            children: [
              Container(
                  width: screenwidth - flyternSpaceMedium * 2,
                  padding: flyternMediumPaddingHorizontal,
                  margin: flyternMediumPaddingAll,
                  decoration: BoxDecoration(
                    color: flyternBackgroundWhite,
                    boxShadow: flyternItemShadow,
                    borderRadius:
                    BorderRadius.circular(flyternBorderRadiusExtraSmall),
                  ),
                  child: DropDownSelector(
                    titleText: "select_destination".tr,
                    selected: activityBookingController.cityId.value,
                    items: [

                      for (var i = 0;
                      i < activityBookingController.cities.value.length;
                      i++)
                        GeneralItem(
                            id: activityBookingController
                                .cities.value[i].cityID,
                            name: activityBookingController
                                .cities.value[i].cityName,
                            imageUrl: ""),
                    ],
                    hintText: "select_destination".tr,
                    valueChanged: (newZone) {
                      activityBookingController.getActivities(newZone,false);
                    },
                  )),
              Container(
                padding: flyternLargePaddingAll.copyWith(bottom: flyternSpaceSmall),
                color: flyternBackgroundWhite,
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
                                    visible: activityBookingController
                                        .sortingDcs.value.isNotEmpty &&
                                        activityBookingController
                                            .sortingDc.value.value !=
                                            "-1",
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: flyternSpaceExtraSmall),
                                      child: Text(
                                          activityBookingController
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
              Container(
                  color: flyternBackgroundWhite,
                  child: Divider()),

              Visibility(
                visible:  activityBookingController.isActivitiesLoading.value,
                child: Expanded(
                  child: ListView.builder(
                      itemCount:3,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(border:
                          i==(activityBookingController.activities.length-1)?null:
                          flyternDefaultBorderBottomOnly),
                          child: ActivityListCardLoader(
                          ),
                        );
                      }),
                ),
              ),
              Visibility(
                visible: !activityBookingController.isActivitiesLoading.value,
                child: Expanded(
                  child: ListView.builder(
                      itemCount:
                          activityBookingController.activities.length,
                      itemBuilder: (context, i) {
                        return Container(
                          decoration: BoxDecoration(border:
                          i==(activityBookingController.activities.length-1)?null:
                          flyternDefaultBorderBottomOnly),
                          child: ActivityListCard(
                            activityData: activityBookingController.activities.value[i],
                            onPressed: (){

                            },
                          ),
                        );
                      }),
                ),
              ),
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
            selectedSort: activityBookingController.sortingDc.value.value,
            sortChanged: (String selectedSort) {
              activityBookingController.updateSort(selectedSort);
              Navigator.pop(context);
            },
            title: "sort_by".tr,
            sortingDcs: activityBookingController.sortingDcs.value,
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
            return ActivityFilterOptionSelector(
                currency: activityBookingController.currency.value,
                availableFilterOptions: getAvailableFilterOptions(),
                selectedFilterOptions: getSelectedFilterOptions(),
                filterSubmitted: (ActivityResponse selectedFilterOptions) {

                  activityBookingController
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
  String getFilterTitle() {
    String filterTitleAll = "all".tr;
    int filterCount = 0;

    if (activityBookingController.selectedPriceDcs.isNotEmpty) {
      filterCount++;
    }

    if (activityBookingController.selectedBestDealsDcs.isNotEmpty) {
      filterCount++;
    }

    if (activityBookingController.selectedTourCategoryDcs.isNotEmpty) {
      filterCount++;
    }
    if(filterCount>0){
      return "filter_items".tr.replaceAll("2", filterCount.toString());
    }else{
      return filterTitleAll;
    }
  }

  ActivityResponse getAvailableFilterOptions() {
    return ActivityResponse(
      activities: [],
      priceDcs: activityBookingController.priceDcs.value,
      sortingDcs: [], 
      objectID: 1,
      tourCategoryDcs: activityBookingController.tourCategoryDcs.value,
      bestDealsDcs: activityBookingController.bestDealsDcs.value, 
    );
  }

  ActivityResponse getSelectedFilterOptions() {
    return ActivityResponse(
      activities: [],
      priceDcs: activityBookingController.selectedPriceDcs.value,
      sortingDcs: [],
      objectID: 1,
      tourCategoryDcs: activityBookingController.selectedTourCategoryDcs.value,
      bestDealsDcs: activityBookingController.selectedBestDealsDcs.value,
    );
  }

}
