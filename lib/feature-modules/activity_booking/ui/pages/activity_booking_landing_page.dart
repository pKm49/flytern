import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking_controller.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/activity_list_card.dart';
import 'package:flytern/feature-modules/package_booking/ui/components/package_list_card.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/data/models/business_models/general_item.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
import 'package:flytern/shared/ui/components/dropdown_selector.dart';
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
    double screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    return Obx(
          () =>
          Container(
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

                        GeneralItem(
                            id: "ALL",
                            name: "all".tr,
                            imageUrl: ""),
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
                  visible: !activityBookingController.isInitialDataLoading
                      .value,
                  child: Expanded(
                      child: Container(
                          color: flyternBackgroundWhite,
                          child: ListView.builder(
                            itemCount: activityBookingController.cities.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                    padding: flyternLargePaddingHorizontal,
                                    child: Wrap(
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            activityBookingController.getActivities(activityBookingController
                                                .cities[index].cityID,true);

                                          },
                                          child: Row(
                                            children: [
                                              Image.network(activityBookingController
                                                  .cities[index].imageUrl,
                                                  width: screenwidth * .2 ,
                                                  height: screenwidth * .2 ,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Container(
                                                        color: flyternGrey10,
                                                        width: screenwidth * .2 ,
                                                        height: screenwidth *
                                                            .2 );
                                                  }),
                                              addHorizontalSpace(flyternSpaceMedium),
                                              Expanded(child: Text(
                                                activityBookingController
                                                    .cities[index].cityName,))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: flyternSpaceMedium),
                                          child: Divider(),
                                        ),
                                      ],
                                    )),
                          ))),
                ),
                Visibility(
                  visible: activityBookingController.isInitialDataLoading.value,
                  child: Expanded(
                      child: Container(
                          color: flyternBackgroundWhite,
                          child: ListView.builder(
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                  padding: flyternLargePaddingHorizontal,
                                    child: Wrap(
                                      children: [
                                        Row(
                                          children: [

                                            Shimmer.fromColors(
                                              baseColor: flyternBackgroundWhite,
                                              highlightColor: flyternGrey20,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:flyternGrey10,
                                                  borderRadius:
                                                  BorderRadius.circular(flyternBorderRadiusExtraSmall),
                                                ),
                                                width: screenwidth * .2 ,
                                                height: screenwidth * .2 ,
                                              ),
                                            ),
                                            addHorizontalSpace(flyternSpaceMedium),
                                            Expanded(child: Shimmer.fromColors(
                                              baseColor: flyternBackgroundWhite,
                                              highlightColor: flyternGrey20,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:flyternGrey10,
                                                  borderRadius:
                                                  BorderRadius.circular(flyternBorderRadiusExtraSmall),
                                                ),
                                                height: 20,
                                                width: screenwidth * .5,
                                              ),
                                            ),)
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: flyternSpaceMedium),
                                          child: Divider(),
                                        ),
                                      ],
                                    )),
                          ))),
                ),
              ],
            ),
          ),
    );
  }
}
