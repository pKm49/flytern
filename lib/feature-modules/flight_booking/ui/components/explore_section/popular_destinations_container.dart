import 'package:flutter/material.dart';
import 'package:flytern/feature-modules/flight_booking/data/models/business_models/popular_destination.dart';
import 'package:flytern/feature-modules/flight_booking/ui/components/explore_section/popular_package_list_card.dart';
import 'package:flytern/shared/data/constants/ui_constants/asset_urls.dart';
import 'package:flytern/shared/data/constants/ui_constants/style_params.dart';
import 'package:flytern/shared/data/constants/ui_constants/widget_styles.dart';

class PopularDestinationsContainer extends StatelessWidget {
  List<PopularDestination> popularDestinations;

  PopularDestinationsContainer({super.key, required this.popularDestinations});

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
              child: PopularPackageListCard(
                imageUrl: popularDestinations[i].url,
                title: popularDestinations[i].name,
                destination: popularDestinations[i].destinations,
                rating: popularDestinations[i].ratings,
                price: popularDestinations[i].price,
              ),
            ),
        ],
      ),
    );
  }
}
