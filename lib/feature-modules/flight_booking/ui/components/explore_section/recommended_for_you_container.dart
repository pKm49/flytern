import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/recommended_package.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/recommended_item_card.dart';
import 'package:flytern/feature-modules/package_booking/controllers/package_booking_controller.dart';
import 'package:flytern/shared/data/constants/app_specific/app_route_names.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';
import 'package:flytern/shared/services/utility-services/widget_generator.dart';
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
