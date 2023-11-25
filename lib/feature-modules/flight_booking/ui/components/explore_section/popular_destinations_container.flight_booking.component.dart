import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/models/popular_destination.flight_booking.model.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.flight_booking.component.dart';
import 'package:flytern/feature-modules/packages/controllers/package.controller.dart';
import 'package:flytern/shared-module/constants/app_specific/route_names.shared.constant.dart';
 import 'package:flytern/shared-module/constants/ui_specific/style_params.shared.constant.dart';
import 'package:flytern/shared-module/constants/ui_specific/widget_styles.shared.constant.dart';
import 'package:get/get.dart';

class PopularDestinationsContainer extends StatelessWidget {
  PackageBookingController packageBookingController;
  List<PopularDestination> popularDestinations;

  PopularDestinationsContainer({super.key, required this.popularDestinations,
   required this.packageBookingController});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Container(
      color: flyternBackgroundWhite,
      child: Wrap(
        children: [
          for (var i = 0; i < popularDestinations.length; i++)
            Container(
              decoration: BoxDecoration(border:
              i==(popularDestinations.length-1)?null:
              flyternDefaultBorderBottomOnly),
              child: InkWell(
                onTap: (){
                  packageBookingController.getPackageDetails(popularDestinations[i].refId);
                  Get.toNamed(Approute_packagesDetails);
                },
                child: PopularPackageListCard(
                  imageUrl: popularDestinations[i].url,
                  title: popularDestinations[i].name,
                  destination: popularDestinations[i].destinations,
                  rating: popularDestinations[i].ratings,
                  price: popularDestinations[i].price,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
