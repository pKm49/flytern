import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/models/recommended_package.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/asset_urls.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:flytern/shared-module/services/utility-services/widget_generator.shared.service.dart';
import 'package:get/get.dart';

class RecommendedForYouContainer extends StatelessWidget {

  List <RecommendedPackage> recommendedPackages;
  PackageBookingController packageBookingController;
  RecommendedForYouContainer({super.key, required this.recommendedPackages
    , required this.packageBookingController});

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

    return Container(
        width: screenwidth,
        height: screenwidth * .7,
        padding: flyternMediumPaddingHorizontal,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: recommendedPackages.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(right: flyternSpaceMedium),
                child:InkWell(
                  onTap: (){
                    packageBookingController.getPackageDetails(recommendedPackages[index].refId);
                    Get.toNamed(Approute_packagesDetails);
                  },
                  child: FlightRecommendedItemCard(
                      imageUrl: recommendedPackages[index].url,
                      title: recommendedPackages[index].name,
                      rating: recommendedPackages[index].ratings
                  ),
                ),
              );
            }
        ));
  }
}
