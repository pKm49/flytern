import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/controllers/flight_booking_controller.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/travel_stories_item_card.dart';
import 'package:flytern/feature-modules/package_booking/controllers/package_booking_controller.dart';
import 'package:flytern/shared-module/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared-module/data/constants/app_specific/default_values.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared-module/data/constants/ui_constants/widget_styles.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AllRecommendedItemsPage extends StatefulWidget {
  const AllRecommendedItemsPage({super.key});

  @override
  State<AllRecommendedItemsPage> createState() =>
      _AllRecommendedItemsPageState();
}

class _AllRecommendedItemsPageState extends State<AllRecommendedItemsPage> {

  final flightBookingController = Get.find<FlightBookingController>();
  final packageBookingController = Get.find<PackageBookingController>();

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("recommended_for_you".tr),
      ),
      body: Obx(
            ()=> Stack(
          children: [
            Visibility(
                visible: flightBookingController.isRecommendedLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  color: flyternGrey10,
                  child: Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                    color: flyternSecondaryColor,
                    size: 50,
                  )),
                )),
            Visibility(
                visible: !flightBookingController.isRecommendedLoading.value,
                child: Container(
                  width: screenwidth,
                  height: screenheight * .9,
                  child: ListView.builder(
                      itemCount:
                          flightBookingController.recommendedPackages.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            packageBookingController.getPackageDetails(flightBookingController.recommendedPackages[index].refId);
                            Get.toNamed(Approute_packagesDetails);
                          },
                          child: Container(
                            margin: flyternLargePaddingAll.copyWith(bottom: index == (flightBookingController.recommendedPackages.length-1)?flyternSpaceLarge:0),
                            child: FlightRecommendedItemCard(
                                imageUrl: flightBookingController
                                    .recommendedPackages[index].url,
                                title: flightBookingController
                                    .recommendedPackages[index].name,
                                rating: flightBookingController
                                    .recommendedPackages[index].ratings),
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
