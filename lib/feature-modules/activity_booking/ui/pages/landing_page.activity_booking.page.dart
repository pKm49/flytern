import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking.controller.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/city_card.activity_booking.component.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/list_card.activity_booking.component.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ActivityBookingLandingPage extends StatefulWidget {
  const ActivityBookingLandingPage({super.key});

  @override
  State<ActivityBookingLandingPage> createState() =>
      _ActivityBookingLandingPageState();
}

class _ActivityBookingLandingPageState
    extends State<ActivityBookingLandingPage> {
  final activityBookingController = Get.put(ActivityBookingController());

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Obx(
      () => Container(
        height: screenheight,
        width: screenwidth,
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
                  selected: activityBookingController.countryisocode.value,
                  items: [
                    GeneralItem(id: "ALL", name: "all".tr, imageUrl: ""),
                    for (var i = 0;
                        i < activityBookingController.destinations.value.length;
                        i++)
                      GeneralItem(
                          id: activityBookingController
                              .destinations.value[i].countryISOCode,
                          name: activityBookingController
                              .destinations.value[i].countryName,
                          imageUrl: activityBookingController
                              .destinations.value[i].flag),
                  ],
                  hintText: "select_destination".tr,
                  valueChanged: (newZone) {
                    activityBookingController.getCities(1, newZone);
                  },
                )),
            Visibility(
              visible: !activityBookingController.isInitialDataLoading.value,
              child: Expanded(
                  child: Container(
                      color: flyternBackgroundWhite,
                      padding: flyternSmallPaddingAll,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: activityBookingController.cities.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                padding: flyternSmallPaddingAll,
                                child: InkWell(
                                  onTap: () {
                                    activityBookingController.getActivities(
                                        activityBookingController
                                            .cities[index].cityID,
                                        true);
                                  },
                                  child: ActivityCityCard(
                                    title: activityBookingController
                                        .cities[index].cityName,
                                    imageUrl: activityBookingController
                                        .cities[index].imageUrl,
                                  ),
                                ),
                              )))),
            ),
            Visibility(
              visible: activityBookingController.isInitialDataLoading.value,
              child: Expanded(
                  child: Container(
                      color: flyternBackgroundWhite,
                      padding: flyternSmallPaddingAll,
                      child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                padding: flyternSmallPaddingAll,
                                child:  Shimmer.fromColors(
                                  baseColor: flyternBackgroundWhite,
                                  highlightColor: flyternGrey20,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:flyternGrey10,
                                      borderRadius:
                                      BorderRadius.circular(flyternBorderRadiusExtraSmall),
                                    ),
                                    width: screenwidth*.25,
                                    height: screenwidth*.25,
                                  ),
                                ),
                              )))),
            ),
          ],
        ),
      ),
    );
  }
}
