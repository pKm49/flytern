import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/activity_booking/controllers/activity_booking.controller.dart';
import 'package:flytern/feature-modules/activity_booking/ui/components/city_card.activity_booking.component.dart';
  import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/models/general_item.dart';
 import 'package:flytern/shared-module/ui/components/dropdown_selector.shared.component.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

class ActivityBookingLandingPage extends StatefulWidget {
  const ActivityBookingLandingPage({super.key});

  @override
  State<ActivityBookingLandingPage> createState() =>
      _ActivityBookingLandingPageState();
}

class _ActivityBookingLandingPageState
    extends State<ActivityBookingLandingPage> {
   final activityBookingController = Get.find<ActivityBookingController>();

   final ScrollController _controller = ScrollController();



   @override
   void initState() {
     super.initState();

     // Setup the listener.
     _controller.addListener(() {
       if (_controller.position.atEdge) {
         bool isTop = _controller.position.pixels == 0;
         if (isTop) {
           print('At the top');
         } else {
           print('At the bottom');
           activityBookingController.getCities( activityBookingController.pageId.value+1,
               activityBookingController.countryisocode.value);
         }
       }
     });
   }
   
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
                        controller: _controller,
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
                visible: activityBookingController.isInitialDataPageLoading.value,
                child: Container(
                  width: screenwidth,
                  color: flyternBackgroundWhite,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                        color: flyternSecondaryColor,
                        size: 50,
                      )),
                )),
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
